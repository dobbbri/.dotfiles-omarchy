vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
	"https://github.com/mason-org/mason.nvim", -- package manager
	"https://github.com/mason-org/mason-lspconfig.nvim", -- lspconfig bridge
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer
	"https://github.com/saghen/blink.cmp",
	"https://github.com/lewis6991/gitsigns.nvim",
}, { confirm = false })

-- blink ------------------------------------------------------------------------------------------
require("blink.cmp").setup({
	completion = {
		documentation = { auto_show = true },
	},
	keymap = {
		preset = "enter",
	},
	fuzzy = {
		implementation = "lua",
	},
})

local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)

vim.lsp.enable({ "astro", "bashls", "jsonls", "lua_ls", "tailwindcss", "ts_ls" })

vim.lsp.config("*", { capabilities = capabilities })
vim.lsp.config("astro", { init_options = { typescript = { tsdk = "node_modules/typescript/lib" } } })
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
			format = { enable = false }, -- Using stylua for formatting.
			hint = { enable = true, arrayIndex = "Disable" },
			diagnostics = { globals = { "vim", "require" } },
			telemetry = { enable = false },
			runtime = { version = "LuaJIT" },
		},
	},
})

-- mason ------------------------------------------------------------------------------------------
local ensure_installed = {
	"astro-language-server",
	"bash-language-server",
	"json-lsp",
	"tailwindcss-language-server",
	"lua-language-server",
	"typescript-language-server",
	"biome",
	"prettier",
	"shfmt",
	"stylua",
	"taplo",
	"yamlfmt",
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = ensure_installed,
})

-- conform ----------------------------------------------------------------------------------------
vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
}, { confirm = false })

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		sh = { "shfmt" },
		lua = { "stylua" },
		-- cpp = { "clang-format" },
		toml = { "taplo" },
		yaml = { "yamlfmt" },
		yml = { "yamlfmt" },
		astro = { "biome" },
		javascript = { "biome" },
		javascriptreact = { "biome" },
		typescript = { "biome" },
		typescriptreact = { "biome" },
		css = { "biome" },
		html = { "biome" },
		json = { "biome" },
		jsonc = { "biome" },
		scss = { "biome" },
		markdown = { "biome" },
		graphql = { "biome" },
		-- xml = { "xmlformatter" },
		-- vue = { "biome" },
		-- svelte = { "biome" },
	},
	default_format_opts = {
		lsp_fallback = false,
		async = false,
		timeout_ms = 3000,
	},
})

vim.keymap.set({ "n", "v" }, "f", function() conform.format() end, { desc = "Format file" })

-- gitsigns ----------------------------------------------------------------------------------------
require("gitsigns").setup({
	signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
	linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
})
