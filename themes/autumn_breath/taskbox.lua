local wibox = require("wibox")
local awful = require("awful")

local mybar = class()

function mybar:init(s)

    -- Create tasklist widget
    s.mytasklist = require("widgets.tasklist")(s) 

    -- Create the wibox
    s.taskbox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.taskbox:setup {
        expand = "none",
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
        },
    }

    s.taskbox.visible = not s.taskbox.visible
end

return mybar
