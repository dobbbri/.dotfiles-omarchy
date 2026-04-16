---@diagnostic disable: missing-fields

-- set <space> as the leader key
-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- OPTIONS
-- ============================================================================

vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }

vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline


vim.opt.autocomplete = true
-- vim.opt.pumborder = 'rounded'
vim.opt.pummaxwidth = 40
vim.opt.completeopt = 'menu,menuone,noselect,nearest'
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency

vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 500 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- cursor blinking and settings

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

vim.diagnostic.config({
  virtual_text = true, -- show inline diagnostics
})

-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- INFO: colorscheme
vim.cmd.colorscheme("catppuccin")

-- INFO: plugins

-- INFO: formatting and syntax highlighting
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })
-- equivalent to :TSUpdate
require("nvim-treesitter.install").update("all")
-- autoinstall languages that are not installed yet
require("nvim-treesitter.config").setup({ auto_install = true })

-- INFO: completion engine
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })

require("blink.cmp").setup({
  completion = { documentation = { auto_show = true } },
  keymap = { preset = "enter" },
  fuzzy = { implementation = "lua" },
})

-- INFO: lsp server installation and configuration

-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
vim.lsp.enable({ "astro", "bashls", "jsonls", "lua_ls", "tailwindcss", "ts_ls" })

vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
vim.lsp.config("astro", { init_options = { typescript = { tsdk = "node_modules/typescript/lib" } } })
vim.lsp.config("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim", "require" } } } } })


vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
  "https://github.com/mason-org/mason.nvim",                     -- package manager
  "https://github.com/mason-org/mason-lspconfig.nvim",           -- lspconfig bridge
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" -- auto installer
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "astro-language-server", "bash-language-server", "json-lsp", "tailwindcss-language-server",
    "lua-language-server", "typescript-language-server",
    "biome", "prettier", "shfmt", "stylua",  "taplo", "yamlfmt",
  },
})



-- ~/.config/nvim-new/lua/plugins.lua
vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons" ,
  "https://github.com/refractalize/oil-git-status.nvim"
}, { confirm = false })


require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
        win_options = {
          wrap = true,
        }
      })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- fzf-lua --
local fzflua = require('fzf-lua')
fzflua.register_ui_select()
fzflua.setup({
    defaults = {
        winopts = {
            border = "rounded",
            width = 0.6,
            height = 0.5,
        },
    },
    files = {
        previewer = false,
        winopts = { width = 0.5, height = 0.5 },
    },
    grep = {
        winopts = {
            width = 0.7,
            preview = {
                layout = "horizontal",
                horizontal = "right:40%",
            },
        },
    },
})
vim.keymap.set('n', '<leader>ff', fzflua.files)
vim.keymap.set('n', '<leader>fe', fzflua.diagnostics_workspace)
vim.keymap.set('n', '<leader>fg', fzflua.live_grep)
vim.keymap.set('n', '<leader>fb', fzflua.buffers)
vim.keymap.set('n', '<leader>fh', fzflua.help_tags)
vim.keymap.set({ 'n', 'v' }, '<leader>fc', fzflua.commands)
-- uncomment to enable automatic plugin updates
-- vim.pack.update()
