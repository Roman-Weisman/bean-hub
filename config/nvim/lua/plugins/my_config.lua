-- Disable inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
	end,
})

-- Keep unused variable text visually normal; do not dim or change color.
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = nil, bg = nil, bold = false, italic = false, underline = false })

-- Config override
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
	-- Noice.nvim is placing a popup when i press :
	-- Since I don't exactly remeber when I turned it off, I'll leave it. I think it was something with not seeing the : or /.
	-- { "folke/noice.nvim", enabled = false }, -- I prefer messages to be printed below
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
							},
						},
					},
				},
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		require("nvim-dap-virtual-text").setup({ enabled = false }),
		keys = {
      -- stylua: ignore start
      { "<F6>", function() require("dap").step_over() end, desc = "DAP: Step Over" },
      { "<F7>", function() require("dap").step_into() end, desc = "DAP: Step Into" },
      { "<F8>", function() require("dap").step_out() end, desc = "DAP: Step Out" },
      { "<F9>", function() require("dap").run_last() end, desc = "DAP: Run Last" }, -- Delve step back is not supported
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
