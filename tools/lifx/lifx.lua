local function runCommand()
	local scripts_path = vim.fn.stdpath("config") .. "/scripts/toggleLifx.sh"
	local handle = io.popen("bash " .. scripts_path .. " 2>&1")
	if handle == nil then
		vim.api.nvim_echo({ { "Error: io.open resulted in nil, please check\nAborting.", "Errormsg" } }, false, {})
	else
		local result = handle:read("*a")
		handle:close()
		vim.api.nvim_echo({ { result, "Errormsg" } }, false, {})
	end
end

vim.keymap.set("n", "<leader>m", "", { desc = "myConfig", silent = true })
vim.keymap.set("n", "<leader>ml", "", { desc = "Toggle Lifx", silent = true })
vim.keymap.set("n", "<leader>ml1", runCommand, { desc = "Lifx Neon", silent = true })

return {}
