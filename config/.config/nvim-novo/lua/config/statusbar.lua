-- ============================================================================
-- STATUSLINE
-- ============================================================================
local function get_mode()
	local modes = {
		["n"] = "NORMAL",
		["i"] = "INSERT",
		["v"] = "VISUAL",
		["V"] = "V-LINE",
		["c"] = "COMMAND",
		["R"] = "REPLACE",
		["t"] = "TERMINAL",
		[" "] = "V-BLOCK",
	}
	return modes[vim.api.nvim_get_mode().mode] or "UNKNOWN"
end

local function get_lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	return "  " .. clients[1].name
end

function MyStatusLine()
	local mode = string.format("%%#StatusLineAccent#  %s  %%*", get_mode())
	local file = "- %f %m"
	local diag = " %{v:lua.vim.diagnostic.status()}"
	local git = "  %{get(b:,'gitsigns_head','')}"
	local align = "%="
	local lsp_info = string.format("%s %%{v:lua.vim.lsp.status()}", get_lsp_status())
	local location = " 󰆤 %l:%c - %p%% "

	return table.concat({ mode, file, git, diag, align, lsp_info, location })
end

vim.opt.laststatus = 3
vim.opt.statusline = "%!v:lua.MyStatusLine()"
-- vim.api.nvim_set_hl(0, "StatusLineAccent", { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
