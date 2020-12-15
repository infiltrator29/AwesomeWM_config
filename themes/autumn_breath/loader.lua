local gears = require("gears")
local awful = require("awful")

local loader = class()

local relative_path = (...):match("(.-)[^%.]+$") 


function loader:init()
  local themePath = gears.filesystem.get_configuration_dir() .. "themes/autumn_breath/" 
  awful.spawn.with_shell("python ".. themePath .. "scripts/loader.py '".. themePath .."'")

  -- For each client
  for _, c in ipairs(client.get()) do
    -- Set focus bar
    require(relative_path .. "focus_bar")(c)
  end
end

return loader
