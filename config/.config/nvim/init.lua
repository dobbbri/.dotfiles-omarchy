-- ============================================================================
-- Leader Keys
vim.g.mapleader = " " -- Set space as the leader key for custom mappings
vim.g.maplocalleader = " " -- Set space as the local leader key for buffer-local mappings

require("core.options")

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
  virtual_text = { prefix = "●", spacing = 4 },
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
  "https://github.com/3rd/image.nvim",
  "https://github.com/luukvbaal/statuscol.nvim",
  "https://github.com/mg979/vim-visual-multi",
}, { confirm = false })

-- =============================================================================
-- colorscheme
-- vim.cmd("colorscheme catppuccin")
vim.cmd("colorscheme retrobox")
-- vim.cmd("colorscheme unokai")

-- =============================================================================
-- Folds
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldmethod = "expr"

local builtin = require("statuscol.builtin")

require("statuscol").setup({
  relculright = true,
  segments = {
    { text = { builtin.foldfunc, "" }, click = "v:lua.ScFa" },
    { text = { builtin.lnumfunc, "" }, click = "v:lua.ScLa" },
    { text = { "%s" }, click = "v:lua.ScSa" },
  },
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
    markdown = { "prettier" },
    graphql = { "prettier" },
  },
  default_format_opts = { lsp_fallback = true, async = false, timeout_ms = 500 },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- =============================================================================
require("fzf-lua").setup({
  winopts = { split = "belowright new" },
})

-- =============================================================================
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

-- =============================================================================
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
require("nvim-autopairs").setup({
  check_ts = true,
  fast_wrap = {},
})

-- ===========================================================================
--
-- require("ibl").setup({
--   indent = {
--     char = "│",
--     tab_char = "│",
--     highlight = "IblIndent",
--   },
-- })

-- ===========================================================================
-- Searc and replace in project files
require("grug-far").setup({
  headerMaxWidth = 80,
  showCompactInputs = true,
})

-- =============================================================================
require("image").setup({
  backend = "kitty",
})

-- =============================================================================
-- which-key
require("config.which-key")
