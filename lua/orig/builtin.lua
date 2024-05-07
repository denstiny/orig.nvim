local Popup = require("nui.popup")
local Layout = require("nui.layout")
local Menu = require("nui.menu")
local utils = require("orig.utils")
local old = require("orig.oldfiles")
local NuiText = require("nui.text")
local event = require("nui.utils.autocmd").event

local M = {}

function M.oldfilemenu(arg)
	local lines = {
		Menu.separator("Recent files", {
			char = " ",
			text_align = "center",
		}),
	}
	local odlfiles = old.get()
	for _, v in pairs(odlfiles) do
		local icon = utils.icon(v)
		local picon = icon .. "  " .. utils.abbreviate_path(v)
		local menu = Menu.item(picon, { path = v })
		table.insert(lines, menu)
	end

	local opts = {
		lines = lines,
		on_close = function() end,
		on_submit = function(item)
			vim.cmd("doautocmd User " .. "OrgClosed")
			vim.cmd("e " .. item.path)
		end,
	}
	opts = vim.tbl_deep_extend("force", opts, arg.prg)
	local menu = Menu(arg.config, opts)
	menu:on({ event.BufDelete }, function()
		vim.cmd("doautocmd User " .. "OrgClosed")
	end)
	--vim.g.Menu = vim.inspect(menu)
	--vim.api.nvim_buf_set_keymap(menu.buf, "n", "q", ":quit<cr>", { silent = true, noremap = true })
	menu:map("n", "q", function()
		vim.cmd("quitall")
	end, { noremap = true })
	return menu
end

function M.term(arg, cmd)
	local opt = {
		config = {
			enter = false,
			focusable = false,
			zindex = 10,
			border = {
				style = "rounded",
			},
			position = "0%",
			size = {
				width = "100%",
				height = "100%",
			},
		},
	}
	opt = vim.tbl_deep_extend("force", opt, arg)
	local popup = Popup(opt.config)
	popup:on({
		event.BufAdd,
		event.BufWinEnter,
		event.MenuPopup,
	}, function(arg)
		vim.api.nvim_buf_call(arg.buf, function()
			vim.cmd("terminal " .. cmd)
		end)
	end)
	return popup
end

return M
