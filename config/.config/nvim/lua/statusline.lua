local function get_git_status()
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
  local is_head_empty = signs.head ~= ""
  return is_head_empty and string.format(" %s", signs.head) or ""
end

local function filename()
  return "%<%10.128F %m"
end

local function position()
  return "%l:%c - %3p%%"
end

function LspClients()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    return ""
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return "" .. table.concat(names, ",") .. ""
end

function StatusLine()
  local statusline = " "
  statusline = statusline .. get_git_status()
  statusline = statusline .. " "
  statusline = statusline .. filename()
  statusline = statusline .. "%="
  statusline = statusline .. " "
  statusline = statusline .. "%="
  statusline = statusline .. " "
  statusline = statusline .. LspClients()
  statusline = statusline .. " "
  statusline = statusline .. position()
  statusline = statusline .. " "

  return statusline
end

vim.o.statusline = "%!luaeval('StatusLine()')"
