local awful = require("awful")
 
-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height



local helpers = {}

local function in_percent(size, coord)
  local value = 0
  -- if x , use width screen
  if coord == 'x' then
    value = screen_width / 100 * size
  -- if y, use height screen
  else
    value = screen_height / 100 * size
  end
  return value
end

-- Create the gravity system like subtlewm
function helpers.gravity(gravities) -- args: x, y, width, height
  local x = in_percent(gravities[1], 'x')
  local y = in_percent(gravities[2], 'y')
  local width = in_percent(gravities[3], 'x')
  local height = in_percent(gravities[4], 'y')
  return  { floating = true, width = width, height = height, x = x, y = y }
end

return helpers


