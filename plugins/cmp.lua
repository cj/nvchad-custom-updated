local present, cmp = pcall(require, "cmp")

if not present then
  return
end

require("base46").load_highlight "cmp"

vim.opt.completeopt = "menu,menuone,noselect"

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local lspkind_comparator = function(conf)
  local lsp_types = require('cmp.types').lsp
  return function(entry1, entry2)
    if entry1.source.name ~= 'nvim_lsp' then
      if entry2.source.name == 'nvim_lsp' then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end

local cmp_window = require "cmp.utils.window"

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

local options = {
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border "CmpDocBorder",
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      local icons = require("nvchad_ui.icons").lspkind
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

      if entry.source.name == "copilot" then
        vim_item.kind = "  Copilot"
        vim_item.kind_hl_group = "CmpItemKindCopilot"

        return vim_item
      end

      if entry.source.name == "cmp_tabnine" then
        vim_item.kind = "  TabNine"
        vim_item.kind_hl_group = "CmpItemKindTabNine"

        return vim_item
      end

      if entry.source.name == "treesitter" then
        vim_item.kind = "  Treesitter"
        vim_item.kind_hl_group = "CmpItemKindTreesitter"

        return vim_item
      end

      return vim_item
    end,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ---@diagnostic disable-next-line: unused-local
    ['<C-e>'] = cmp.mapping(function(fallback)
      cmp.mapping.close()
      vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n',
        true)
    end),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "copilot", group_index = 2, max_item_count = 5 },
    { name = "cmp_tabnine", group_index = 2, max_item_count = 5 },
    { name = "nvim_lsp", group_index = 2, max_item_count = 10 },
    { name = "treesitter", group_index = 2, max_item_count = 5 },
    { name = "luasnip", group_index = 2, max_item_count = 5 },
    { name = "buffer", group_index = 2, max_item_count = 5 },
    { name = "nvim_lua", group_index = 2, max_item_count = 5 },
    { name = "path", group_index = 2, max_item_count = 5 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      lspkind_comparator({
        kind_priority = {
          Field = 11,
          Property = 11,
          Constant = 10,
          Enum = 10,
          EnumMember = 10,
          Event = 10,
          Function = 10,
          Method = 10,
          Operator = 10,
          Reference = 10,
          Struct = 10,
          Variable = 9,
          File = 8,
          Folder = 8,
          Class = 5,
          Color = 5,
          Module = 5,
          Keyword = 2,
          Constructor = 1,
          Interface = 1,
          Snippet = 0,
          Text = 1,
          TypeParameter = 1,
          Unit = 1,
          Value = 2,
        },
      }),
      label_comparator,
      require("copilot_cmp.comparators").prioritize,
      require("copilot_cmp.comparators").score,
      require('cmp_tabnine.compare'),

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,

      require("cmp-under-comparator").under,

      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
}

-- check for any override
options = require("core.utils").load_override(options, "hrsh7th/nvim-cmp")

cmp.setup(options)
