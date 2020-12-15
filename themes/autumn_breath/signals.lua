local relative_path = (...):match("(.-)[^%.]+$") 
local focus_bar = require(relative_path .. "focus_bar")

local signals = {}

signals.client = {
  focus = function(c) focus_bar().show(c) end,
  unfocus = function(c) focus_bar().hide(c) end,
  manage = function(c) focus_bar(c) end
}

return signals
