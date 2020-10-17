local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

-- root
local binclock_root = class()

function binclock_root:init(args)
    local btf = beautiful.widget_binary_clock
    if type(args) ~= 'table' then args = {} end
    if type(btf) ~= 'table' then btf = {} end

    -- options
    --self.width = args.width or btf.width or dpi(70)
    --self.height = args.height or btf.height or dpi(10)
    self.cell_width = args.cell_width or btf.cell_width or dpi(19)
    self.cell_height = args.cell_height or btf.cell_height or dpi(10)
    self.bg = args.bg or btf.bg or 0 -- default is transparent
    self.paddings = args.paddings or btf.paddings or {left=10,right=10,top=1,bottom=1} -- table (left, right, top, bootom) or number
    self.inner_spacing_horizontal = args.inner_spacing_horizontal or btf.inner_spacing_horizontal or dpi(2)
    self.inner_spacing_vertical = args.inner_spacing_vertical or btf.inner_spacing_vertical or dpi(2)
    self.inner_spacing = args.inner_spacing or btf.inner_spacing or dpi(1)
    self.segment_spacing = args.segment_spacing or btf.segment_spacing or self.inner_spacing
    
    -- base widget
    self.widget = self:make_widget()
end

function binclock_root:single_cell()
    local c = wibox.widget {
        wibox.widget.textbox(''),
        forced_width = self.cell_width,
        forced_height = self.cell_height,
        bg = "#fc2105",
        widget = wibox.container.background,
    }
    
    return c
end

function binclock_root:single_segment(mrg)
    local segment_spacing = 0
    if mrg then
        segment_spacing = {left=self.segment_spacing, right=self.segment_spacing, top=0, bottom=0}
    end

    local s = wibox.widget {
                    {
                        self:single_cell(),
                        self:single_cell(),
                        self:single_cell(),
                        self:single_cell(),
                        self:single_cell(),
                        self:single_cell(),
                        self:single_cell(),
                        self:single_cell(),

                        --horizontal_spacing = self.inner_spacing_horizontal,
                        --vertical_spacing = self.inner_spacing_vertical,
                        spacing = self.inner_spacing,
                        forced_num_cols = 2,
                        forced_num_rows = 4,
                        homogeneous = false,
                        expand = false,
                        layout = wibox.layout.grid
                    },

                    margins = segment_spacing,
                    widget = wibox.container.margin
    }
    return s
end

function binclock_root:make_widget()
    local w = wibox.widget {
        {
            {
				{
					self:single_segment(),
					self:single_segment(true),
					self:single_segment(),
					layout = wibox.layout.align.horizontal
				}, 
				layout = wibox.layout.align.vertical
			},

            margins = self.paddings,
            widget = wibox.container.margin
        },
        --forced_width = self.width,
        --forced_height = self.height,
        layout = wibox.layout.align.vertical,
        bg = "#ffffff",
        widget = wibox.container.background
    }

    return w
end

-- herit
local binclock_widget = class(binclock_root)

function binclock_widget:init(args)
    binclock_root.init(self, args)
    return self.widget
end

return binclock_widget
