local gears = require("gears")
local awful = require("awful")

local loader = class()

function loader:init()
  local themePath = gears.filesystem.get_configuration_dir() .. "themes/autumn_breath/" 
  awful.spawn.with_shell("python ".. themePath .. "scripts/loader.py '".. themePath .."'")
end

return loader
