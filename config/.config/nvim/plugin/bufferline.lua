vim.pack.add({
	{ src = "https://github.com/akinsho/nvim-bufferline.lua" },
	-- Optional, but recommended for file icons
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

require("bufferline").setup({
	options = {
		mode = "buffers",
		separator_style = "thin",
		show_buffer_close_icons = true,
		show_close_icon = true,
	}
})
--:
