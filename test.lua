local Popup = require("nui.popup")
local Layout = require("nui.layout")

local popup_one, popup_two =
	Popup({
		enter = true,
		border = "single",
		position = {
			row = "20%",
			col = "50%",
		},
	}), Popup({
		border = "double",
	})

local layout = Layout(
	{
		position = {
			row = "30%",
			col = "0%",
		},
		size = {
			width = 80,
			height = "60%",
		},
	},
	Layout.Box({
		Layout.Box(popup_one, { size = "40%" }),
		--Layout.Box(popup_two, { size = "60%" }),
	}, { dir = "row" })
)

local current_dir = "row"

popup_one:map("n", "r", function()
	if current_dir == "col" then
		layout:update(Layout.Box({
			Layout.Box(popup_one, { size = "40%" }),
			--Layout.Box(popup_two, { size = "60%" }),
		}, { dir = "row" }))

		current_dir = "row"
	else
		layout:update(Layout.Box({
			Layout.Box(popup_two, { size = "60%" }),
			--Layout.Box(popup_one, { size = "40%" }),
		}, { dir = "col" }))

		current_dir = "col"
	end
end, {})

layout:mount()
