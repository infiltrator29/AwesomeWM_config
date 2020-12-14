local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")
local helpers = require("modules.helpers")
local beautiful = require("beautiful")

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

local mybar = class()

function mybar:init(s)

    -- Promptbox widget
    s.mypromptbox = awful.widget.prompt()

    -- Create tasklist widget
    s.mytasklist = require("widgets.tasklist")(s) 

    -- Create taglist widget
    s.mytaglist = require("widgets.taglist")(s)

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    -- Create the wibox
    local wibox_gravity = helpers.gravity({2.5, 2, 95, 3.1})

    s.bar = wibox {
            visible = true,
            x = wibox_gravity.x,
            y = wibox_gravity.y,
            width = wibox_gravity.width,
            height = wibox_gravity.height,
            shape = gears.shape.rounded_rect,
    }

    local top_strut = wibox_gravity.y + wibox_gravity.height
    local struts = {left = 0, right = 0, top = top_strut, bottom = 0}
    s.bar:struts(struts)

    -- Add widgets to the wibox
    s.bar:setup {
        bg = beautiful.wibar_bg,
        widget = wibox.container.background,
        {
            top = dpi(2),
            bottom = dpi(2),
            left = dpi(13),
            right = dpi(13),
            widget = wibox.container.margin,
            {
                expand = "none",
                layout = wibox.layout.align.horizontal,
                { -- Left widgets
                    layout = wibox.layout.fixed.horizontal,
                    --mylauncher, -- It's a awesomewm icon with menu
                    s.mytaglist,
                    s.mypromptbox,
                },
                --s.mytasklist, -- Middle widget
                awful.widget.watch('corona', 900),
                { -- Right widgets
                    --mybinaryclock,
                    layout = wibox.layout.fixed.horizontal,
                    mykeyboardlayout,
                    wibox.widget.systray(),
                    mytextclock,
                    s.mylayoutbox,
                },
            }
        }
    }
end

return mybar
