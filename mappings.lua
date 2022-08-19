local M = {}

M.disabled = {
  i = {
    ["<C-e>"] = "",
    ["<C-h>"] = "",
    ["<C-l>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },

  n = {
    ["<leader>fÞ"] = "",
    ["<leader>f"] = "",
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

    ["<leader>D"] = "",
    ["<leader>n"] = "",
    ["<leader>t"] = "",
    ["<leader>u"] = "",
    ["<leader>r"] = "",
    ["<leader>x"] = "",
    ["<leader>rn"] = "",
  }
}

-- truezen
M._general = {
  n = {
    ["<leader>D"] = { "<cmd> :TroubleToggle document_diagnostics<CR>", "Diagnostics" },
    ["D"] = { ":lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
    ["K"] = { ":lua vim.lsp.buf.hover() <CR>", "Show definition" },
    ["U"] = { "<C-r>", "Undo" },
    ["W"] = { "<cmd> :write<CR>", "Write" },
    ["Q"] = { "<cmd> :bd<CR>", "Quit" },
    ["Y"] = { "yy", "Yank" },
    ["sv"] = { "<cmd> :split<CR>", "Split vertically" },
    ["sg"] = { "<cmd> :vsplit<CR>", "Split horizontally" },
  },
  i = {
    ["<C-p>"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
  }
}

M._truzen = {
  -- plugin = true,

  n = {
    ["<leader>Z"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
    -- ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
    ["<leader>z"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
  },
}

M._hop = {
  -- plugin = true,

  n = {
    ["<C-Space>"] = { "<cmd>:HopPattern<cr>", "Hop" },
    ["<Space>"] = { "<cmd>lua require'hop'.hint_words()<cr>", "Hop" },
  },
}

M._comment = {
  -- plugin = true,

  n = {
    ["<leader> "] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader> "] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M._telescope = {
  -- plugin = true,

  n = {
    ["<leader>f"] = { "<cmd> Telescope find_files <CR>", "  find files" },
    ["<leader>F"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "  find all" },
    ["<leader>t"] = { "<cmd> Telescope live_grep <CR>", "  live grep" },
    ["<leader>T"] = { "<cmd> lua require'telescope.builtin'.grep_string{} <CR>", "  live grep word" },
    ["<leader>r"] = { "<cmd> Telescope oldfiles <CR>", "  find oldfiles" },
    ["<leader>R"] = { "<cmd> lua require'telescope.builtin'.resume{}<CR>", "  find resume" },
    ["<leader>c"] = { "<cmd> :TodoTelescope<CR>", "  Todo's" },
    ["<leader>gs"] = { "<cmd> :Telescope git_status<CR>", "  Git status" },
    ["<leader>y"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
    ["<C-p>"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
  },

  i = {
    ["<C-p>"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
  }
}

M._gitsigns = {
  -- plugin = true,

  n = {
    ["<leader>gl"] = { "<cmd> :Gitsigns blame_line<CR>", "   Git Blame Line" },
  },
}

M._nvimtree = {
  -- plugin = true,
  n = {
    -- toggle
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
    -- focus
    ["<leader>E"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
  },
  i = {
    ["<C-p>"] = { "<cmd> :Telescope neoclip<CR>", "  Neoclip" },
  }
}

M._lspconfig = {
  -- plugin = true,

  n = {
    ["<leader>D"] = { "<cmd> :TroubleToggle document_diagnostics<CR>", "Diagnostics" },
    ["D"] = { ":lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
  },
}

M._navigator = {
  -- plugin = true,

  n = {
    ["gr"] = { "<cmd> lua require('navigator.reference').async_ref() <CR>", "Reference" },
    ["g0"] = { "<cmd> lua require('navigator.treesitter').buf_ts() <CR>", "Document" },
    -- { key = "<leader>gt", func = "require('navigator.treesitter').buf_ts()" },
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
    ["<leader>ca"] = { "<cmd> lua require('navigator.codeAction').code_action() <CR>", "Code Action" },
    ["<leader>cA"] = { "<cmd> range_code_action() <CR>", "Range Code Action" },
    ["<leader>lr"] = { "<cmd> lua require('navigator.rename').rename() <CR>", "Rename" },
    -- ["<leader>D"] = { "<cmd> type_definition() <CR>", "Type Definition" },
    ["<leader>wa"] = {
      "<cmd> lua require('navigator.workspace').add_workspace_folder() <CR>",
      "Add Workspace Folder",
    },
    ["<leader>wr"] = {
      "<cmd> lua require('navigator.workspace').remove_workspace_folder() <CR>",
      "Remove Workspace Folder",
    },
    ["<leader>wl"] = {
      "<cmd> lua require('navigator.workspace').list_workspace_folders() <CR>",
      "List Workspace Folders",
    },
    ["<leader>la"] = { "<cmd> lua require('navigator.codelens').run_action()<CR>", "Codelens" },
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

--[[ M.gh = { ]]
--[[   n = { ]]
--[[     ["<leader>gh"] = { "" } ]]
--[[   } ]]
--[[ } ]]

-- M.copilot = {
--    i = {
--       ["<C-e>"] = { '<cmd> copilot#Accept("<CR>") <CR>', "Copilot Accept" },
--    },
-- }

return M
