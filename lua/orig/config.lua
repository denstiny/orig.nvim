local oldfilemenu = require("orig.builtin").oldfilemenu
local term = require("orig.builtin").term

local M = {
	view = {
		oldfilemenu({
			config = {
				--relative = "cursor",
				size = {
					width = "35%",
					height = "60%",
				},
				position = {
					row = 41,
					col = "50%",
				},
				border = {
					style = { "╭", " ", "╮", "│", "╯", " ", "╰", "│" },
					text = {
						top = "",
						top_align = "center",
					},
				},
				win_options = {
					winhighlight = "Normal:Normal",
				},
			},
			prg = {
				max_width = 50,
				keymap = {
					focus_next = { "j", "<Down>" },
					focus_prev = { "k", "<Up>" },
					close = { "<Esc>", "<C-c>", "q" },
					submit = { "<CR>", "<Space>" },
				},
				on_close = function()
					vim.cmd("doautocmd User " .. "OrgClosed")
				end,
				on_submit = function(item)
					vim.cmd("doautocmd User " .. "OrgClosed")
					vim.cmd("e " .. item.path)
				end,
			},
		}),
		term({
			config = {
				zindex = 50,
				border = {
					style = "none",
				},
				size = {
					width = "40%",
					height = "100%",
				},
				position = "0%",
			},
		}, "cbonsai -l"),
		term({
			config = {
				zindex = 50,
				border = {
					style = "none",
				},
				size = {
					width = "20%",
					height = "20%",
				},
				position = {
					row = "91%",
					col = "98%",
				},
			},
		}, "cava"),
		term({
			config = {
				zindex = 50,
				border = {
					style = "none",
				},
				size = {
					width = "22%",
					height = "40%",
				},
				position = {
					row = "0%",
					col = "98%",
				},
			},
		}, "cowsay Orig"),
		term({
			config = {
				zindex = 58,
				size = {
					width = "40%",
					height = "36%",
				},
				border = {
					style = "none",
				},
				position = {
					row = 0,
					col = "50%",
				},
			},
		}, "tty-clock -t -s"),
	},
	oldfile = {
		no_execfile = { "NvimTree_1" },
	},
}

return M
