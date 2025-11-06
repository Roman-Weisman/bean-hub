-- Keep unused variable text visually normal; do not dim or change color.
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
	callback = function()
		vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = nil, bg = nil })
	end,
})

-- Config override.
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					hide_gitignored = false, -- unhides files/directories mentioned in .gitignore
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig", -- Disable inlay hints for go
		opts = {
			servers = {
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = false,
								compositeLiteralFields = false,
								compositeLiteralTypes = false,
								constantValues = false,
								functionTypeParameters = false,
								parameterNames = false,
								rangeVariableTypes = false,
							},
							analyses = {
								ST1000 = false, -- Disable package comment diagnostic.
								ST1003 = false, -- Allow ALL_CAPS names.
							},
						},
					},
				},
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
      -- stylua: ignore start
      { "<F6>", function() require("dap").step_over() end, desc = "DAP: Step Over" },
      { "<F7>", function() require("dap").step_into() end, desc = "DAP: Step Into" },
      { "<F8>", function() require("dap").step_out() end, desc = "DAP: Step Out" },
      { "<F9>", function() require("dap").run_last() end, desc = "DAP: Run Last" },
      { "<F10>", function() require("dap").restart() end, desc = "DAP: Restart" },
      { "<Space>dd", function() require("dap-go").debug_test() end, desc = "Debug nearest Go test" },
			-- stylua: ignore end
		},
	},
	{ "theHamsta/nvim-dap-virtual-text", enabled = false }, -- Prevents noise on debug where inlay text displays values and messes the code.
	{
		-- Without this, sql formatter doesn't work.
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				sql = { "sql_formatter" }, -- After Mason formatter install, this line is required for it to format.
			},
		},
	},
}
