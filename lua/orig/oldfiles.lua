local M = {
	oldfiles = {},
	max = 20,
}

local utils = require("orig.utils")

function M.load_cache(file_path)
	local content = vim.fn.readfile(file_path, "b")[1]
	local upack_obj = vim.mpack.decode(content)
	M.oldfiles = upack_obj

	for i = 1, #M.oldfiles do
		if vim.fn.filereadable(M.oldfiles[i]) == 0 then
			table.remove(M.oldfiles, i)
		end
	end

	return M.oldfiles
end

function M.save_cache(file_path)
	--vim.notify("save cache: " .. vim.inspect(M.oldfiles))
	vim.fn.writefile({ vim.mpack.encode(M.oldfiles) }, file_path, "b")
end

function M.create_cache(file_path)
	local pack_obj = vim.mpack.encode({})
	vim.fn.writefile({ pack_obj }, file_path, "b")
end

function M.setmax(max)
	M.max = max
end

function M.add(file_name)
	if vim.fn.filereadable(file_name) == 0 then
		return
	end

	for i = 1, #M.oldfiles do
		if M.oldfiles[i] == file_name then
			table.remove(M.oldfiles, i)
		end
	end
	if #M.oldfiles > M.max then
		table.remove(M.oldfiles, M.max)
	end

	table.insert(M.oldfiles, 1, file_name)
end

function M.get()
	return M.oldfiles
end

return M
