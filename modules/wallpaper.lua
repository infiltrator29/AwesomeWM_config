local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local mywallpaper = class()

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        if beautiful.animated_wallpaper then
            local animate = "pkill xwinwrap; sleep 0.1; xwinwrap -ni -fs -un -s -st -sp -nf -ov -- mpv -wid WID --loop=inf --mute=yes " .. wallpaper .. " &"
            awful.spawn.with_shell(animate)
        else
            local stopAnimate = "pkill xwinwrap &"
            awful.spawn.with_shell(stopAnimate)
            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            -- Setting wallpaper
            -- (and check if solid color)
            if beautiful.solid_background then
               gears.wallpaper.set(wallpaper) 
           else
               gears.wallpaper.maximized(wallpaper, s, true)
           end
        end
    end
end

function mywallpaper:init(s)
  set_wallpaper(s)

  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  screen.connect_signal("property::geometry", set_wallpaper)
end

return mywallpaper
