-- INFO: formatting and syntax highlighting
vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
}, { confirm = false })

local filetypes = { "astro", "javascript", "typescript", "tsx", "html", "css", "json", "lua", "php", "bash" }

-- equivalent to :TSUpdate
require("nvim-treesitter.install").update(filetypes)

-- autoinstall languages that are not installed yet
require("nvim-treesitter.config").setup({ auto_install = true })
