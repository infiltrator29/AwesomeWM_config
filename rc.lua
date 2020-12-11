-- {{{ Requirements
-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Custom layours and widgets
local lain = require("lain")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- }}}

-- Function to create object in lua - used globally
-- return the init function of each class
local function new(self, ...)
    local instance = setmetatable({}, { __index = self })
    return instance:init(...) or instance
end

-- Function to create objects in lua - used globally
function class(base)
    return setmetatable({ new = new }, { __call = new, __index = base })
end

-- {{{ Error handling 
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notification {
        preset  = naughty.config.presets.critical,
        title   = "Oops, there were errors during startup!",
        message = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notification {
            preset  = naughty.config.presets.critical,
            title   = "Oops, an error happened!",
            message = tostring(err)
        }

        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions 
-- Themes define colours, icons, font and wallpapers.
local xrdb = beautiful.xresources.get_current_theme()
-- Make dpi function global
dpi = beautiful.xresources.apply_dpi
-- Make xresources colors global
x = {
    --           xrdb variable
    background = xrdb.background,
    foreground = xrdb.foreground,
    color0     = xrdb.color0,
    color1     = xrdb.color1,
    color2     = xrdb.color2,
    color3     = xrdb.color3,
    color4     = xrdb.color4,
    color5     = xrdb.color5,
    color6     = xrdb.color6,
    color7     = xrdb.color7,
    color8     = xrdb.color8,
    color9     = xrdb.color9,
    color10    = xrdb.color10,
    color11    = xrdb.color11,
    color12    = xrdb.color12,
    color13    = xrdb.color13,
    color14    = xrdb.color14,
    color15    = xrdb.color15,
}

local themeName = "autumn_breath"
local theme = require("modules.theme_loader")(themeName)


-- {{{ Add some custom stuff
local env = require("modules.env-configuration")
local keys = require("modules.keys")
-- }}}

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --awful.layout.suit.corner.ne,
     --awful.layout.suit.corner.sw,
     --awful.layout.suit.corner.se,
}
-- }}}
-- {{{ Menu 
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", env.terminal .. " -e man awesome" },
   { "edit config", env.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", env.terminal }
                                  }
                        })
-- }}}
-- {{{ Rules 
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = require("modules.rules")
-- }}}
-- {{{ Signals 
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Set screen padding for each tag separatly
awful.tag.attached_connect_signal(s, "property::selected", function(t)
    awful.screen.focused().padding = tagpadding[t.name]
end)
    -- Additional: Set padding for current tag
    local current_tag = awful.screen.focused().selected_tag
    awful.screen.focused().padding = tagpadding[current_tag.name]
-- }}}

    
-- {{{ Autostart 
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
-- }}}




-- vim:foldmethod=marker:foldlevel=0
