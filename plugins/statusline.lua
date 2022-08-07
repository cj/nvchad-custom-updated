local st_modules = require "nvchad_ui.statusline.modules"

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local navic = require("nvim-navic")

-- mode component = mode component + " hi "
-- print 'hi' next to mode component
local LSP_status = function()
  local clients = vim.lsp.get_active_clients()
  local names = {}

  for _, client in ipairs(clients) do
    if client.attached_buffers[vim.api.nvim_get_current_buf()] then
      local client_name = client.name:sub(0, 2)

      if not has_value(names, client_name) then
        table.insert(names, client_name)
      end
    end
  end

  local name = ''

  if names ~= {} then
    name = table.concat(names, "|")
  end

  return (vim.o.columns > 70 and "%#St_LspStatus#" .. "   LSP ~ " .. name .. " ") or "   LSP "
end

return {
  LSP_status = LSP_status,

  LSP_progress = function()
    if navic.is_available() then
      return st_modules.LSP_progress() .. navic.get_location()
    else
      return st_modules.LSP_progress()
    end
  end,
}
