local M = {}

M.disabled = {
  i = {
    ["<C-e>"] = "",
  },

  n = {
    ["<leader>fÞ"] = "",
    ["<leader>f"] = "",
    ["<leader>fm"] = "",
    ["<leader>tt"] = "",
    ["<leader>rn"] = "",
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",

    -- find
    ["<leader>ff"] = "",
    ["<leader>fa"] = "",
    ["<leader>fw"] = "",
    ["<leader>fb"] = "",
    ["<leader>fh"] = "",
    ["<leader>fo"] = "",

    -- git
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",

    -- pick a hidden term
    ["<leader>pt"] = "",

    ["<C-n>"] = "",
  }
}

-- truezen
M.truzen = {
  n = {
    ["<leader>Z"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
    -- ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
    ["<leader>z"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
  },
}

M.general = {
  n = {
    ["<leader>D"] = { "<cmd> :e!<CR> :TroubleToggle document_diagnostics<CR>", "Diagnostics" },
    ["D"] = { ":lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
    ["K"] = { ":lua vim.lsp.buf.hover() <CR>", "Show definition" },
    ["U"] = { "<C-r>", "Undo" },
    ["W"] = { "<cmd> :write<CR>", "Write" },
    ["Q"] = { "<cmd> :bd<CR>", "Quit" },
    ["Y"] = { "yy", "Yank" },
    ["sv"] = { "<cmd> :split<CR>", "Split vertically" },
    ["sg"] = { "<cmd> :vsplit<CR>", "Split horizontally" },

    -- switch between windows

    -- switch themes

  },
}

M.diagnostic = {
  n = {},
}

M.hop = {
  n = {
    ["<C-Space>"] = { "<cmd>:HopPattern<cr>", "Hop" },
    ["<Space>"] = { "<cmd>lua require'hop'.hint_words()<cr>", "Hop" },
  },
}

M.comment = {
  n = {
    ["<leader> "] = { "<cmd> :lua require('Comment.api').toggle_current_linewise()<CR>", "Comment" },
  },

  v = {
    ["<leader> "] = {
      "<esc><cmd> :lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
      "Comment",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>f"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>F"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>t"] = { "<cmd> Telescope live_grep <CR>", "  live grep" },
    ["<leader>T"] = { "<cmd> lua require'telescope.builtin'.grep_string{} <CR>", "  live grep word" },
    ["<leader>r"] = { "<cmd> Telescope oldfiles <CR>", "  find oldfiles" },
    ["<leader>R"] = { "<cmd> lua require'telescope.builtin'.resume{}<CR>", "  find resume" },
    ["<leader>c"] = { "<cmd> :TodoTelescope<CR>", "  Todo's" },
    ["<leader>gs"] = { "<cmd> :Telescope git_status<CR>", "  Git status" },
    ["<leader>y"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
    ["<C-p>"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
  },
  i = {
    ["<C-p>"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
  }
}

M.gitsigns = {
  n = {
    ["<leader>gl"] = { "<cmd> :Gitsigns blame_line<CR>", "   Git Blame Line" },
  },
}

M.nvimtree = {
  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
    -- focus
    ["<leader>E"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
  },
}

M.lspconfig = {
  n = {
    ["<leader>D"] = { "<cmd> :TroubleToggle document_diagnostics<CR>", "Diagnostics" },
    ["D"] = { ":lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
  },
}

-- { key = "gr", func = "require('navigator.reference').async_ref()" },
-- { key = "<Leader>gr", func = "require('navigator.reference').reference()" }, -- reference deprecated
-- { mode = "i", key = "<M-k>", func = "signature_help()" },
-- { key = "<c-k>", func = "signature_help()" },
-- { key = "g0", func = "require('navigator.symbols').document_symbols()" },
-- { key = "gW", func = "require('navigator.workspace').workspace_symbol()" },
-- { key = "<c-]>", func = "require('navigator.definition').definition()" },
-- { key = "gd", func = "require('navigator.definition').definition()" },
-- { key = "gD", func = "declaration({ border = 'rounded', max_width = 80 })" },
-- { key = "gp", func = "require('navigator.definition').definition_preview()" },
-- { key = "<Leader>gt", func = "require('navigator.treesitter').buf_ts()" },
-- { key = "<Leader>gT", func = "require('navigator.treesitter').bufs_ts()" },
-- { key = "K", func = "hover({ popup_opts = { border = single, max_width = 80 }})" },
-- { key = "<Space>ca", mode = "n", func = "require('navigator.codeAction').code_action()" },
-- { key = "<Space>cA", mode = "v", func = "range_code_action()" },
-- -- { key = '<Leader>re', func = 'rename()' },
-- { key = "<Space>rn", func = "require('navigator.rename').rename()" },
-- { key = "<Leader>gi", func = "incoming_calls()" },
-- { key = "<Leader>go", func = "outgoing_calls()" },
-- { key = "gi", func = "implementation()" },
-- { key = "<Space>D", func = "type_definition()" },
-- { key = "gL", func = "require('navigator.diagnostics').show_diagnostics()" },
-- { key = "gG", func = "require('navigator.diagnostics').show_buf_diagnostics()" },
-- { key = "<Leader>dt", func = "require('navigator.diagnostics').toggle_diagnostics()" },
-- { key = "]d", func = "diagnostic.goto_next({ border = 'rounded', max_width = 80})" },
-- { key = "[d", func = "diagnostic.goto_prev({ border = 'rounded', max_width = 80})" },
-- { key = "]O", func = "diagnostic.set_loclist()" },
-- { key = "]r", func = "require('navigator.treesitter').goto_next_usage()" },
-- { key = "[r", func = "require('navigator.treesitter').goto_previous_usage()" },
-- { key = "<C-LeftMouse>", func = "definition()" },
-- { key = "g<LeftMouse>", func = "implementation()" },
-- { key = "<Leader>k", func = "require('navigator.dochighlight').hi_symbol()" },
-- { key = "<Space>wa", func = "require('navigator.workspace').add_workspace_folder()" },
-- { key = "<Space>wr", func = "require('navigator.workspace').remove_workspace_folder()" },
-- { key = "<Space>ff", func = "formatting()", mode = "n" },
-- { key = "<Space>ff", func = "range_formatting()", mode = "v" },
-- { key = "<Space>wl", func = "require('navigator.workspace').list_workspace_folders()" },
-- { key = "<Space>la", mode = "n", func = "require('navigator.codelens').run_action()" },

M.navigator = {
  n = {
    ["gr"] = { "<cmd> lua require('navigator.reference').async_ref() <CR>", "Reference" },
    ["g0"] = { "<cmd> lua require('navigator.treesitter').buf_ts() <CR>", "Document" },
    -- { key = "<Leader>gt", func = "require('navigator.treesitter').buf_ts()" },
    ["gW"] = { "<cmd> lua require('navigator.workspace').workspace_symbol() <CR>", "Workspace" },
    ["gd"] = { "<cmd> silent! lua require('navigator.definition').definition() <CR>", "Definition" },
    ["gD"] = { "<cmd> declaration({ border = 'rounded', max_width = 80 }) <CR>", "Declaration" },
    ["gp"] = { "<cmd> lua require('navigator.definition').definition_preview() <CR>", "Definition Preview" },
    ["gL"] = { "<cmd> lua require('navigator.diagnostics').show_diagnostics() <CR>", "Diagnostics" },
    ["gG"] = { "<cmd> lua require('navigator.diagnostics').show_buf_diagnostics() <CR>", "Buffer Diagnostics" },
    ["gi"] = { "<cmd> lua require('navigator.diagnostics').implementation() <CR>", "Implementation" },
    ["gb"] = { "<cmd> Gitsigns blame_line <CR>", "blame_line" },
    ["gn"] = { "<cmd> TSLspRenameFile <CR>", "Rename File" },
    ["g<LeftMouse>"] = { "<cmd> implementation() <CR>", "Implementation" },
    ["<Leader>ca"] = { "<cmd> lua require('navigator.codeAction').code_action() <CR>", "Code Action" },
    ["<Leader>cA"] = { "<cmd> range_code_action() <CR>", "Range Code Action" },
    ["<Leader>lr"] = { "<cmd> lua require('navigator.rename').rename() <CR>", "Rename" },
    -- ["<Leader>D"] = { "<cmd> type_definition() <CR>", "Type Definition" },
    ["<Leader>wa"] = {
      "<cmd> lua require('navigator.workspace').add_workspace_folder() <CR>",
      "Add Workspace Folder",
    },
    ["<Leader>wr"] = {
      "<cmd> lua require('navigator.workspace').remove_workspace_folder() <CR>",
      "Remove Workspace Folder",
    },
    ["<Leader>wl"] = {
      "<cmd> lua require('navigator.workspace').list_workspace_folders() <CR>",
      "List Workspace Folders",
    },
    ["<Leader>la"] = { "<cmd> lua require('navigator.codelens').run_action()<CR>", "Codelens" },
    -- { key = "]r", func = "require('navigator.treesitter').goto_next_usage()" },
    -- { key = "[r", func = "require('navigator.treesitter').goto_previous_usage()" },
    ["]r"] = { "<cmd> lua require('navigator.treesitter').goto_next_usage()<CR>", "Goto Next Usage" },
    ["[r"] = { "<cmd> lua require('navigator.treesitter').goto_previous_usage()<CR>", "Goto Previous Usage" },
    -- { key = "]d", func = "diagnostic.goto_next({ border = 'rounded', max_width = 80})" },
    -- { key = "[d", func = "diagnostic.goto_prev({ border = 'rounded', max_width = 80})" },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "   goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "   goto_next",
    },
    ["<leader>d"] = { "<cmd> lua require('navigator.treesitter').buf_ts()<CR>", "Show methods" },
    ["M"] = { "<cmd> lua require('navigator.codeAction').code_action()<CR>", "Code action" },
  },
}

-- M.copilot = {
--    i = {
--       ["<C-e>"] = { '<cmd> copilot#Accept("<CR>") <CR>', "Copilot Accept" },
--    },
-- }

return M
