-- INFO: completion engine
vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"rafamadriz/friendly-snippets",
}, { confirm = false })

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
