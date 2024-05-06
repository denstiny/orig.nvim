local Popup = require("nui.popup")
local Layout = require("nui.layout")
local Menu = require("nui.menu")
local utils = require("orig.utils")
local NuiText = require("nui.text")

local M = {}
function M.oldfilemenu(arg)
	local lines = {}

	for _, v in pairs(utils.get_old_list()) do
		local icon = utils.icon(v)
		local picon = icon .. " " .. utils.abbreviate_path(v)
		local menu = Menu.item(picon, { path = v })
		table.insert(lines, menu)
	end

	local opts = {
		lines = lines,
		on_close = function() end,
		on_submit = function(item)
			vim.cmd("e " .. item.path)
		end,
	}
	opts = vim.tbl_deep_extend("force", opts, arg.prg)
	local menu = Menu(arg.config, opts)
	return menu
end
return M
