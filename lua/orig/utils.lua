local M = {}

function M.get_extension(fn)
	local match = fn:match("^.+(%..+)$")
	local ext = ""
	if match ~= nil then
		ext = match:sub(2)
	end
	return ext
end

function M.icon(fn)
	local nwd = require("nvim-web-devicons")
	local ext = M.get_extension(fn)
	return nwd.get_icon(fn, ext, { default = true })
end

function M.get_script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end

function M.check_by_no_execfiles(no_extfilet, file)
	for i = 1, #no_extfilet do
		if no_extfilet[i] == file then
			return true
		end
	end
	return false
end

function M.get_old_list()
	local oldlistpath = M.get_script_path() .. "oldlist.lua"
	if vim.fn.filereadable(oldlistpath) == 1 then
		return require("orig.oldlist")
	else
		return {}
	end
end

function M.vim_level_get_oldlist(maxitem, names)
	local oldfiles = {}
	for _, v in pairs(vim.v.oldfiles) do
		if #oldfiles == maxitem then
			break
		end

		local name = string.match(v, ".*/(.*)")
		if not M.check_by_no_execfiles(names, name) then
			table.insert(oldfiles, v)
		end
	end
	return oldfiles
end

--- 缩写文件路径
---@param path
---@return
function M.abbreviate_path(path)
	local home = os.getenv("HOME")
	if home then
		path = path:gsub("^" .. home, "~")
	end

	local parts = {}
	for part in path:gmatch("[^/]+") do
		table.insert(parts, part)
	end

	if #parts > 2 then
		for i = 1, #parts - 2 do
			parts[i] = parts[i]:sub(1, 1)
		end
	end

	return table.concat(parts, "/")
end

return M
