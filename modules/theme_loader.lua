local awful = require("awful")
local gears = require("gears")
-- Theme handling library
local beautiful = require("beautiful")

local mytheme = class()

function mytheme:init(themeName)
    local themePath = gears.filesystem.get_configuration_dir() .. "themes/" .. themeName .. "/" 
    awful.spawn.with_shell("xrdb -merge " .. themePath .. "Xresources")
    awful.spawn.with_shell("pkill compton;compton --shadow-exclude '!focused'")

    local theme = {}
    theme.main = themePath .. "theme.lua"

    beautiful.init( theme.main )

    -- {{{ For each screen 
    awful.screen.connect_for_each_screen(function(s) 
            -- Wallpaper
            require("modules.wallpaper")(s)

            -- Set tag names and settings
            require("modules.tagnames")(s)

            -- Set wibar
            require("themes.".. themeName .. ".bar")(s)
            -- Set taskbox
            require("themes.".. themeName ..".taskbox")(s)


    end)
    -- }}}
    
    return theme 
end

return mytheme
