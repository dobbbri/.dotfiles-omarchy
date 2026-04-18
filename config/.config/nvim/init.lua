-- ============================================================================
-- Leader Keys
vim.g.mapleader = " " -- Set space as the leader key for custom mappings
vim.g.maplocalleader = " " -- Set space as the local leader key for buffer-local mappings

-- Disable Built-in Plugins
vim.g.loaded_netrw = 1 -- Disable netrw file explorer (using a different file explorer)
vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin component

-- Disable Providers (silence health check warnings)
vim.g.loaded_node_provider = 0 -- Disable Node.js provider
vim.g.loaded_perl_provider = 0 -- Disable Perl provider
vim.g.loaded_python3_provider = 0 -- Disable Python 3 provider
vim.g.loaded_ruby_provider = 0 -- Disable Ruby provider

-- Editor Behavior
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for all yank/paste operations
vim.opt.undofile = true -- Persist undo history to disk between sessions
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Directory to store undo files
vim.opt.updatetime = 100 -- Time in ms before CursorHold event triggers (affects plugins)
vim.opt.timeoutlen = 1000 -- Time in ms to wait for a mapped key sequence to complete
vim.opt.confirm = true -- Prompt for confirmation instead of failing on unsaved changes
vim.opt.autoread = true -- Automatically reload files changed outside of Neovim

-- UI/Display
vim.opt.termguicolors = true -- Enable 24-bit RGB colors in the terminal
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers (hybrid with number=true)
vim.opt.numberwidth = 2 -- Minimum width of number column
vim.opt.signcolumn = "yes:1" -- Always show sign column with width of 1
vim.opt.cursorline = false -- Don't highlight the current line
vim.opt.wrap = false -- Don't wrap long lines
vim.opt.breakindent = false -- Wrapped lines preserve indentation
vim.opt.showmode = false -- Don't show mode in command line (shown in statusline)
vim.opt.showcmd = false -- Don't show partial command in command line
vim.opt.ruler = true -- Show cursor position in command line
vim.opt.showtabline = 0 -- Never show the tab line
vim.opt.cmdheight = 1 -- Height of command line area
vim.opt.pumheight = 10 -- Maximum height of popup menu
vim.o.winborder = "none" -- Use rounded borders for floating windows
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = "-" } -- Hide ~ characters on empty lines

-- Search
vim.opt.hlsearch = true -- Highlight all search matches
vim.opt.incsearch = true -- Show search matches as you type
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if pattern contains uppercase

-- Indentation
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.shiftwidth = 2 -- Number of spaces for each indentation level
vim.opt.smartindent = true -- Auto-indent new lines based on syntax

-- Splits
vim.opt.splitbelow = true -- Open horizontal splits below current window
vim.opt.splitright = true -- Open vertical splits to the right of current window

-- Files
vim.opt.fileencoding = "utf-8" -- File encoding for new files
vim.opt.backup = false -- Don't create backup files before overwriting
vim.opt.writebackup = false -- Don't create backup while editing
vim.opt.swapfile = false -- Don't create swap files

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Completion menu options
vim.opt.conceallevel = 0 -- Show all text normally (no concealment)

-- disable enter
require("vim._core.ui2").enable()

-- =============================================================================
-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- =============================================================================
-- Configure how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 6 },
  float = { focusable = true, style = "minimal" },
})

-- =============================================================================
-- packages
vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
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
  "https://github.com/MagicDuck/grug-far.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/3rd/image.nvim"
})

-- =============================================================================
-- colorscheme
vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme retrobox")
-- vim.cmd("colorscheme unokai")



-- =============================================================================
-- image
require("image").setup({
  backend = "kitty"
})

-- =============================================================================
-- cheatsheet
local wk = require("which-key")
wk.setup()

wk.add({
  { "<leader>d", group = "Diagnostics" },
  { "<leader>dl", vim.diagnostic.setloclist, desc = "List Diagnostics" },
  { "<leader>df", vim.diagnostic.open_float, desc = "Float Error" },
})

-- =============================================================================
-- autocomplete
require("blink.cmp").setup({
  fuzzy = {
    implementation = "prefer_rust",
    prebuilt_binaries = { force_version = "v*", download = true },
  },
  signature = { enabled = true },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
  completion = {
    documentation = { auto_show = true },
    menu = { auto_show = true },
    list = { selection = { preselect = true, auto_insert = false } },
  },
  keymap = {
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
  },
})

-- =============================================================================
-- LSP
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
    Lua = { diagnostics = { globals = { "vim" } }, telemetry = { enable = false } },
  },
})

vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

vim.lsp.enable({ "astro", "bashls", "jsonls", "lua_ls", "tailwindcss", "ts_ls", "dockerls" })

-- =============================================================================
-- format
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
  default_format_opts = { lsp_fallback = true, async = false, timeout_ms = 500 },
})

wk.add({
  { "<leader>cf", function() require("conform").format() end, desc = "Format File" },
})

-- =============================================================================
-- file explorer
require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _) return name == ".git/" end,
  },
  keymaps = {
    ["<ESC>"] = "actions.close",
    ["q"] = "actions.close",
  },
})

wk.add({
  { "-", "<CMD>Oil<CR>", desc = "Edit Files (Oil)" },
})

-- =============================================================================
-- find
require("fzf-lua").setup({
  winopts = { split = "belowright new" },
})

wk.add({
  { "<leader>f", group = "Find" }, -- Grouping for your fzf-lua
  { "<leader>ff", "<CMD>FzfLua files<CR>", desc = "Find Files" },
  { "<leader>fg", "<CMD>FzfLua live_grep<CR>", desc = "Grep Text" },
  { "<leader><space>", "<CMD>FzfLua buffers<CR>", desc = "Opened Buffers" },
})

-- =============================================================================
-- git
require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "│" },
    topdelete = { text = "│" },
    changedelete = { text = "│" },
    untracked = { text = "┆" },
  },
})

wk.add({
  { "<leader>g", group = "Git" },
  { "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>", desc = "Stage Hunk" },
  { "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>", desc = "Reset Hunk" },
  { "<leader>gp", "<CMD>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },
  { "<leader>gb", "<CMD>Gitsigns blame_line --full'<CR>", desc = "Blame Line" },
})

require("nvim-treesitter.config").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
  ensure_installed = { "astro", "javascript", "typescript", "tsx", "html", "css", "json", "lua", "toml" },
  sync_install = false,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
  autotag = { enable = true },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "<filetype>" },
  callback = function() vim.treesitter.start() end,
})

-- ===========================================================================
--
require("nvim-ts-autotag").setup({})

-- ===========================================================================
--
wk.add({
  { "<leader>c", group = "Code" },
  { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
  { "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },
  { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "gr", vim.lsp.buf.references, desc = "Show References" },
  { "K", vim.lsp.buf.hover, desc = "Hover Docs" },
})

-- ===========================================================================
--
require("nvim-autopairs").setup({
  check_ts = true,
  fast_wrap = {},
})

-- ===========================================================================
--
require("ibl").setup({
  indent = {
    char = "│",
    tab_char = "│",
    highlight = "IblIndent",
  },
})

-- ===========================================================================
-- Searc and replace in project files
require("grug-far").setup({
  headerMaxWidth = 80,
  showCompactInputs = true,
})

wk.add({
  { "<leader>r", group = "Replace" },
  {
    "<leader>ra",
    function()
      local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      require("grug-far").open({
        transient = true,
        prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
      })
    end,
    desc = "Replace in projec",
    mode = { "n", "v" },
  },
})

-- ===========================================================================
-- keymaps

-- Close current buffer without closing the window
vim.keymap.set("n", "<leader>x", "<CMD>bdelete<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>?", "<CMD>WhichKey<CR>", { desc = "Show all keymaps" })

-- Save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set({ "i", "x" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save File" })

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight", silent = true })

-- Window Navigation (no prefix for speed)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go Right" })

-- Window resizing
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

-- Line Movement (Visual Mode)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })

-- Better Navigation
-- Wrapped line navigation
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (wrapped)" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (wrapped)" })

-- Start/End of line (easier than ^ and $)
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Start of Line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "End of Line" })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Better Editing
-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- Paste over selection without yanking
vim.keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })

-- Yank block
vim.keymap.set("n", "YY", "va{Vy", { desc = "Yank Block {}" })

-- Split line (opposite of J)
vim.keymap.set("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { desc = "Split Line", silent = true })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- Insert Mode Escapes
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert" })

-- Terminal Mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go Left" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go Down" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go Up" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go Right" })

-- require("statusbar")
