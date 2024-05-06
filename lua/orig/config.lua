local oldfilemenu = require("orig.builtin").oldfilemenu

local M = {
	view = {
		oldfilemenu({
			config = {
				relative = "cursor",
				position = {
					row = 1,
					col = 0,
				},
				border = {
					style = "rounded",
					text = {
						top = "[Choose Item]",
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
					focus_next = { "j", "<Down>", "<Tab>" },
					focus_prev = { "k", "<Up>", "<S-Tab>" },
					close = { "<Esc>", "<C-c>" },
					submit = { "<CR>", "<Space>" },
				},
				on_close = function() end,
				on_submit = function(item)
					vim.cmd("e " .. item.path)
				end,
			},
		}),
	},
	oldfile = {
		no_execfile = { "NvimTree_1" },
	},
}

return M
