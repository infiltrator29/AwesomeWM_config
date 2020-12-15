local awful = require("awful")
local gears = require("gears")
-- Theme handling library
local beautiful = require("beautiful")
local helpers = require("modules.helpers")

local mytheme = class()

function mytheme:init(themeName)
    local theme = {}

    local themePath = gears.filesystem.get_configuration_dir() .. "themes/" .. themeName .. "/" 
    local themeImPath = "themes." .. themeName .. "."
    awful.spawn.with_shell("xrdb -merge " .. themePath .. "dotfiles/Xresources")

    beautiful.init( themePath .. "theme.lua" )
    
    -- {{{ For each screen 
    awful.screen.connect_for_each_screen(function(s) 
            -- Wallpaper
            require("modules.wallpaper")(s)

            -- Set tag names and settings
            require("modules.tagnames")(s)

            -- Set wibar
            require(themeImPath .. "bar")(s)
            -- Set taskbox
            require(themeImPath .. "taskbox")(s)

    end)
    -- }}}

    require("modules.round-client")

    local loader = "themes.".. themeName ..".loader"
    if helpers.isModule(loader) then
        require(loader)()
    end
    
    -- awful.spawn.with_shell("pkill compton;compton --shadow-exclude '!focused'")
    awful.spawn.with_shell("pkill compton;compton ")

    theme.signals = require(themeImPath .. "signals")

    return theme 
end

return mytheme
