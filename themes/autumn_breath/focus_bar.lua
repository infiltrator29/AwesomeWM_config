local awful = require("awful")
-- Create a titlebar for the client.
-- By default, ruled.client will create one, but all it does is to call this
-- function.


local focus_bar = class()

function focus_bar:init(c)
    if (c) then
      local size = dpi(13) 
        -- awful.titlebar(c, {size = size, position = "left"})
        -- awful.titlebar(c, {size = size, position = "right"})
        awful.titlebar(c, {size = size, position = "bottom"})
        awful.titlebar.hide(c)
    end

    local bar = {}
    bar.show = function (client)
      -- awful.titlebar.show(client, "right")
      -- awful.titlebar.show(client, "left")
      awful.titlebar.show(client, "bottom")
    end
    bar.hide = function (client)
      awful.titlebar.hide(client)
      -- awful.titlebar.hide(client, "right")
      -- awful.titlebar.hide(client, "left")
      awful.titlebar.hide(client, "bottom")
    end

    return bar
end


return focus_bar
