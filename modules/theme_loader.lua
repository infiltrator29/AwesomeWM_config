local awful = require("awful")
local gears = require("gears")

local mytheme = class()

function mytheme:init()
    local themePath = gears.filesystem.get_configuration_dir() .. "themes/solarized/" 
    awful.spawn.with_shell("xrdb -merge " .. themePath .. "dotfiles/Xresources")
    awful.spawn.with_shell("pkill compton;compton --shadow-exclude '!focused'")

    return themePath .. "theme.lua" 
end

return mytheme
