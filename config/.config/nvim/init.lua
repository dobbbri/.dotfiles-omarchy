vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.cursorline = true -- Highlight the current line
vim.opt.laststatus = 3 -- Global statusline (looks cleaner with one bar at the bottom)
vim.opt.showmode = false -- Don't show -- INSERT -- (Which-key/Statusline handle this)
-- Better Editing
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.ignorecase = true -- Ignore case in search...
vim.opt.smartcase = true -- ...unless search contains a capital letter
vim.opt.clipboard = "unnamedplus"
-- Performance & Behavior
vim.opt.updatetime = 250 -- Faster completion and diagnostic display
vim.opt.timeoutlen = 300 -- Faster Which-key popup
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true

-- Configure how diagnostics are displayed
vim.diagnostic.config({
	virtual_text = {	prefix = "●", spacing = 4 },
	signs = true,
	underline = true,
	update_in_insert = false, 
	severity_sort = true,
	-- float = {
	-- 	border = "rounded", 
	-- },
})

vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/sontungexpt/witch-line",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
})

vim.cmd("colorscheme retrobox")

local wk = require("which-key")
wk.setup({
	preset = "modern",
	-- win = { border = "single" },
})

require("witch-line").setup({})


require("blink.cmp").setup({
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { force_version = "v*", download = true },
	},
	signature = { enabled = true },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		documentation = { auto_show = true },
		menu = {
			auto_show = true,
		},
		list = {
			selection = { preselect = true, auto_insert = false },
		},
	},
	keymap = {
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"astro-language-server",
		"bash-language-server",
		"json-lsp",
		"biome",
		"prettier",
		"shfmt",
		"stylua",
		"taplo",
		"tailwindcss-language-server",
		"lua-language-server",
		"typescript-language-server",
		"yamlfmt",
		"dockerls",
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})

vim.lsp.enable({
	"astro",
	"bashls",
	"jsonls",
	"lua_ls",
	"tailwindcss",
	"ts_ls",
	"dockerls",
})

vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

require("conform").setup({
	formatters_by_ft = {
		sh = { "shfmt" },
		lua = { "stylua" },
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
		markdown = { "biome" },
		graphql = { "biome" },
	},
})

wk.add({
	{
		"<leader>cf",
		function()
			require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
		end,
		desc = "Format File",
	},
})

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		show_hidden = true, -- Always see .dotfiles
	},
	keymaps = {
		["<ESC>"] = "actions.close",
		["q"] = "actions.close",
	},
})

wk.add({
	{ "-", "<CMD>Oil<CR>", desc = "Edit Files (Oil)" },
	{ "<leader>f", group = "Find" }, -- Grouping for your fzf-lua
	{ "<leader>ff", "<CMD>FzfLua files<CR>", desc = "Find Files" },
	{ "<leader>fg", "<CMD>FzfLua live_grep<CR>", desc = "Grep Text" },
	{ "<leader>q", desc = "Quit Buffer" },
})

-- Close current buffer without closing the window
vim.keymap.set("n", "<leader>q", "<CMD>bdelete<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>?", "<CMD>WhichKey<CR>", { desc = "Show all keymaps" })

require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	-- Integrate with Which-key for easy Git actions
	on_attach = function()
		local gs = package.loaded.gitsigns

		wk.add({
			{ "<leader>g", group = "Git" },
			{ "<leader>gs", gs.stage_hunk, desc = "Stage Hunk" },
			{ "<leader>gr", gs.reset_hunk, desc = "Reset Hunk" },
			{ "<leader>gp", gs.preview_hunk, desc = "Preview Hunk" },
			{
				"<leader>gb",
				function()
					gs.blame_line({ full = true })
				end,
				desc = "Blame Line",
			},
		})
	end,
})

wk.add({
	{
		"[d",
		function()
			vim.diagnostic.jump({ count = -1, float = true })
		end,
		desc = "Previous Diagnostic",
	},
	{
		"]d",
		function()
			vim.diagnostic.jump({ count = 1, float = true })
		end,
		desc = "Next Diagnostic",
	},
	{ "<leader>d", group = "Diagnostics" },
	{ "<leader>dl", vim.diagnostic.setloclist, desc = "List Diagnostics" },
	{ "<leader>df", vim.diagnostic.open_float, desc = "Float Error" },
})

require("nvim-treesitter.config").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
	ensure_installed = {
		"astro",
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"json",
		"lua",
		"go",
		"php",
		"bash",
		"yaml",
		"toml",
	},
	sync_install = false,
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	indent = { enable = true },
	autotag = { enable = true },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "<filetype>" },
	callback = function()
		vim.treesitter.start()
	end,
})

require("nvim-ts-autotag").setup({})

wk.add({
	{ "<leader>c", group = "Code" },
	{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
	{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },
	{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
	{ "gr", vim.lsp.buf.references, desc = "Show References" },
	{ "K", vim.lsp.buf.hover, desc = "Hover Docs" },
})

local autopairs = require("nvim-autopairs")
autopairs.setup({
	check_ts = true,
	fast_wrap = {},
})

require("ibl").setup({
	indent = {
		char = "│",
		tab_char = "│",
		highlight = "IblIndent",
	},
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
		highlight = "IblScope",
	},
})
