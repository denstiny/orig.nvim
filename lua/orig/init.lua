local M = {}
local old = require("orig.oldfiles")
local utils = require("orig.utils")
local oldfiles_path = utils.get_script_path() .. "oldlist"
local layout = require("orig.view")
old.load_cache(oldfiles_path)
local config = require("orig.config")

M.setup = function()
	local lay = layout.create()

	vim.api.nvim_create_autocmd({ "UiEnter" }, {
		callback = function()
			for _, v in ipairs(config.view) do
				v:mount()
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = "OrgClosed",
		callback = function()
			for _, v in ipairs(config.view) do
				v:unmount()
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		callback = function(arg)
			old.add(arg.file)
		end,
	})

	vim.api.nvim_create_autocmd({ "QuitPre" }, {
		callback = function()
			old.save_cache(oldfiles_path)
		end,
	})
end

return M
