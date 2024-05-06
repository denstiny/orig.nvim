local M = {}
local config = require("orig.config")
local utils = require("orig.utils")

M.setup = function()
	vim.api.nvim_create_autocmd({ "VimEnter" }, {
		callback = function()
			for _, v in ipairs(config.view) do
				--v:mount()
			end
		end,
	})

	--vim.api.nvim_create_autocmd({ "BufEnter" }, {
	--	callback = function(arg)
	--		local oldfiles_path = utils.get_script_path() .. "/oldlist.lua"
	--		if vim.fn.filereadable(oldfiles_path) == 1 then
	--			if vim.fn.filereadable(arg.file) == 1 then
	--				local oldfiles = require("orig.oldlist")
	--				for i = #oldfiles, 1, -1 do
	--					if oldfiles[i] == arg.file then
	--						table.remove(require("orig.oldlist"), i)
	--					end
	--				end
	--				table.insert(require("orig.oldlist"), 1, arg.file)
	--			end
	--		else
	--			local oldfiles = {}
	--			if vim.fn.filereadable(arg.file) == 1 then
	--				table.insert(oldfiles, 1, arg.file)
	--			end
	--			local s_oldfiles = {
	--				"local M = " .. vim.inspect(oldfiles),
	--				"return M",
	--			}
	--			vim.fn.writefile(s_oldfiles, oldfiles_path)
	--		end
	--	end,
	--})
	--vim.api.nvim_create_autocmd({ "BufLeave" }, {
	--	callback = function()
	--		local oldfiles = require("orig.oldlist")
	--		local oldfiles_path = utils.get_script_path() .. "/oldlist.lua"
	--		local s_oldfiles = {
	--			"local M = " .. vim.inspect(oldfiles),
	--			"return M",
	--		}
	--		vim.fn.writefile(s_oldfiles, oldfiles_path)
	--	end,
	--})
end

return M
