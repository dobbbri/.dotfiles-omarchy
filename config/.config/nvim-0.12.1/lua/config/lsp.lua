vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
	"https://github.com/mason-org/mason.nvim", -- package manager
	"https://github.com/mason-org/mason-lspconfig.nvim", -- lspconfig bridge
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer
	"https://github.com/saghen/blink.cmp",
	"https://github.com/lewis6991/gitsigns.nvim",
}, { confirm = false })

-- this mean that when you open a file, you will be at the last position


require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"jsonls",
		"bashls",
		"stylua",
		"prettier",
		"shfmt",
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			telemetry = { enable = false },
		},
	},
})

vim.lsp.config("ts_ls", {
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
})

require("mason-lspconfig").setup({
	automatic_enable = {
		exclude = { "ts_ls" },
	},
})

vim.lsp.enable("ts_ls")

vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "if_many",
	},
	underline = true,
	virtual_text = {
		spacing = 2,
		source = "if_many",
		prefix = "●",
	},
	-- signs = {
	-- 	text = {
	-- 		[vim.diagnostic.severity.ERROR] = "E",
	-- 		[vim.diagnostic.severity.WARN] = "W",
	-- 		[vim.diagnostic.severity.INFO] = "I",
	-- 		[vim.diagnostic.severity.HINT] = "H",
	-- 	},
	-- },
})
