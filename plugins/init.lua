-- then load your mappings
local jsfiles = { "javascript", "typescript", "javascriptreact", "typescriptreact", "graphql" }

local override = require "custom.override"

return {
  ["lithammer/nvim-diagnosticls"] = {},

  ["HallerPatrick/py_lsp.nvim"] = {},

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = override.nvimtree
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = override.treesitter
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    override_options = override.indent
  },

  ["lewis6991/gitsigns.nvim"] = {
    override_options = override.gitsigns
  },

  ["wbthomason/packer.nvim"] = {
    override_options = override.packer

  },

  ["NvChad/ui"] = {
    override_options = {
      statusline = {
        overriden_modules = function()
          return require "custom.plugins.statusline"
        end,
      },
    }
  },

  ["whiteinge/diffconflicts"] = {},

  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("custom.plugins.luasnip")
    end,
  },

  ["farmergreg/vim-lastplace"] = {},

  ["quangnguyen30192/cmp-nvim-tags"] = {},

  ["p00f/nvim-ts-rainbow"] = {
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = {
          -- ...
        },
        -- ...
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        }
      }
    end
  },

  ["neoclide/jsonc.vim"] = {},

  ["danymat/neogen"] = {
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('neogen').setup {
        enabled = true,
        input_after_comment = true,
      }
    end,
  },

  ['lukas-reineke/cmp-under-comparator'] = {},

  ['nvim-telescope/telescope-z.nvim'] = {
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
  },

  ["nvim-treesitter/playground"] = {},
  -- https://www.reddit.com/r/neovim/comments/woyyrz/documentcolornvim_lspbased_colorizer_for_neovim/
  ["themaxmarchuk/tailwindcss-colors.nvim"] = {
    -- load only on require("tailwindcss-colors")
    module = "tailwindcss-colors",
    -- run the setup function after plugin is loaded
    config = function()
      -- pass config options here (or nothing to use defaults)
      require("tailwindcss-colors").setup()
    end
  },

  ["prettier/vim-prettier"] = {
    ft = {},
    config = function()
      -- vim.cmd [[
      --   autocmd BufWritePre *.graphql,*.gql Prettier
      -- ]]
    end
  },

  ["jose-elias-alvarez/typescript.nvim"] = {
    requires = { "nvim-lspconfig", "mason.nvim" },
    -- config = function()
    --   vim.cmd [[
    --     augroup typescript
    --       autocmd BufWritePost *.ts,*.tsx :TypescriptRemoveUnused!
    --       autocmd BufWritePost *.ts,*.tsx :TypescriptAddMissingImports!
    --       " autocmd BufWritePre *.ts,*.tsx :TypescriptOrganizeImports!
    --     augroup END
    --   ]]
    -- end
  },

  ["folke/which-key.nvim"] = {
    disable = false,
    keys = "<leader>",
    module = "which-key",
    config = function()
      local wk = require("which-key")
      wk.register({
        g = {
          name = "+Git",
          h = {
            name = "+Github",
            c = {
              name = "+Commits",
              c = { "<cmd>GHCloseCommit<cr>", "Close" },
              e = { "<cmd>GHExpandCommit<cr>", "Expand" },
              o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
              p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
              z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
            },
            n = {
              name = "+Notifications",
              n = { "<cmd>GHNotifications<cr>", "Notifications" },
              r = { "<cmd>GHRefreshNotifications<cr>", "Refresh Notifications" },
            },
            i = {
              name = "+Issues",
              p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
            },
            -- l = {
            --   name = "+Litee",
            --   t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
            -- },
            l = { "<cmd>LTPanel<cr>", "Toggle Panel" },
            r = {
              name = "+Review",
              a = { "<cmd>GHApproveReview<cr>", "Approve" },
              b = { "<cmd>GHStartReview<cr>", "Begin" },
              c = { "<cmd>GHCloseReview<cr>", "Close" },
              d = { "<cmd>GHDeleteReview<cr>", "Delete" },
              e = { "<cmd>GHExpandReview<cr>", "Expand" },
              s = { "<cmd>GHSubmitReview<cr>", "Submit" },
              z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
            },
            p = {
              name = "+Pull Request",
              c = { "<cmd>GHClosePR<cr>", "Close" },
              d = { "<cmd>GHPRDetails<cr>", "Details" },
              e = { "<cmd>GHExpandPR<cr>", "Expand" },
              o = { "<cmd>GHOpenPR<cr>", "Open" },
              p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
              r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
              t = { "<cmd>GHOpenToPR<cr>", "Open To" },
              z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
            },
            t = {
              name = "+Threads",
              c = { "<cmd>GHCreateThread<cr>", "Create" },
              n = { "<cmd>GHNextThread<cr>", "Next" },
              t = { "<cmd>GHToggleThread<cr>", "Toggle" },
            },
          },
        },
      }, { prefix = "<leader>" })

      require "plugins.configs.whichkey"
    end,

    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },

  ["ldelossa/gh.nvim"] = {
    requires = { 'ldelossa/litee.nvim' },
    config = function()
      require('litee.lib').setup({})

      require('litee.gh').setup({
        -- deprecated, around for compatability for now.
        jump_mode             = "invoking",
        -- remap the arrow keys to resize any litee.nvim windows.
        map_resize_keys       = true,
        -- do not map any keys inside any gh.nvim buffers.
        disable_keymaps       = false,
        -- the icon set to use.
        icon_set              = "nerd",
        -- any custom icons to use.
        icon_set_custom       = nil,
        -- whether to register the @username and #issue_number omnifunc completion
        -- in buffers which start with .git/
        git_buffer_completion = true,
        -- defines keymaps in gh.nvim buffers.
        keymaps               = {
          -- when inside a gh.nvim panel, this key will open a node if it has
          -- any futher functionality. for example, hitting <CR> on a commit node
          -- will open the commit's changed files in a new gh.nvim panel.
          open = "<CR>",
          -- when inside a gh.nvim panel, expand a collapsed node
          expand = "zo",
          -- when inside a gh.nvim panel, collpased and expanded node
          collapse = "zc",
          -- when cursor is over a "#1234" formatted issue or PR, open its details
          -- and comments in a new tab.
          goto_issue = "gd",
          -- show any details about a node, typically, this reveals commit messages
          -- and submitted review bodys.
          details = "d",
          -- inside a convo buffer, submit a comment
          submit_comment = "<C-s>",
          -- inside a convo buffer, when your cursor is ontop of a comment, open
          -- up a set of actions that can be performed.
          actions = "<C-a>",
          -- inside a thread convo buffer, resolve the thread.
          resolve_thread = "<C-r>",
          -- inside a gh.nvim panel, if possible, open the node's web URL in your
          -- browser. useful particularily for digging into external failed CI
          -- checks.
          goto_web = "gx"
        }
      })

      vim.cmd [[
        hi LTSymbol gui=NONE guifg=#87afd7
      ]]
    end
  },

  ["barreiroleo/ltex_extra.nvim"] = {},

  ["SmiteshP/nvim-navic"] = {
    requires = "nvim-lspconfig",
    -- branch = "symbolinformation-support",
    config = function()
      require("nvim-navic").setup {
        highlight = true
      }
    end
  },

  ["github/copilot.vim"] = {},

  ["tpope/vim-dotenv"] = {},

  ["zorab47/procfile.vim"] = {},

  ["nvim-lua/plenary.nvim"] = {
    rm_default_opts = true
  },

  ["sindrets/diffview.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
  },


  ["tpope/vim-abolish"] = {},

  ["isobit/vim-caddyfile"] = {},

  ["nvim-treesitter/nvim-treesitter-refactor"] = {},

  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gc", "gb" },

    config = function()
      local present, nvim_comment = pcall(require, "Comment")

      if not present then
        return
      end

      nvim_comment.setup {
        pre_hook = function(ctx)
          -- Only calculate commentstring for tsx filetypes
          if vim.bo.filetype == 'typescriptreact' then
            local U = require('Comment.utils')

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
              location = require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require('ts_context_commentstring.utils').get_visual_start_location()
            end

            return require('ts_context_commentstring.internal').calculate_commentstring({
              key = type,
              location = location,
            })
          end
        end,
      }
    end,
    setup = function()
      require("core.utils").load_mappings "comment"
    end,
  },

  ["JoosepAlviste/nvim-ts-context-commentstring"] = {},

  ["AckslD/nvim-neoclip.lua"] = {
    -- after = "telescope.nvim",
    requires = {
      { "tami5/sqlite.lua", module = "sqlite" },
    },
    config = function()
      require("neoclip").setup {
        history = 1000,
        enable_persistent_history = true,
        db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
        filter = nil,
        preview = true,
        default_register = '"',
        content_spec_column = false,
        dynamic_preview_title = true,
        on_paste = {
          set_reg = false,
        },
        keys = {
          telescope = {
            i = {
              select = "<cr>",
              paste = "<c-p>",
              paste_behind = "<c-P>",
              custom = {},
            },
            n = {
              select = "<cr>",
              paste = "p",
              paste_behind = "P",
              custom = {},
            },
          },
          fzf = {
            select = "default",
            paste = "ctrl-p",
            paste_behind = "ctrl-k",
            custom = {},
          },
        },
      }
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require "custom.plugins.telescope"
    end,
    setup = function()
      -- load extensions
      local extensions = { "neoclip", "z" }

      local present, telescope = pcall(require, "telescope")

      if not present then
        return
      end

      pcall(function()
        for _, ext in ipairs(extensions) do
          telescope.load_extension(ext)
        end
      end)
    end,
  },

  -- ["andymass/vim-matchup"] = {},

  ["xiyaowong/nvim-cursorword"] = {},

  -- ["RRethy/vim-illuminate"] = {
  --   config = function()
  --     require('illuminate').configure({
  --       -- providers: provider used to get references in the buffer, ordered by priority
  --       providers = {
  --         'lsp',
  --         'treesitter',
  --         'regex',
  --       },
  --       -- delay: delay in milliseconds
  --       delay = 100,
  --       -- filetype_overrides: filetype specific overrides.
  --       -- The keys are strings to represent the filetype while the values are tables that
  --       -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
  --       filetype_overrides = {},
  --       -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
  --       filetypes_denylist = {
  --         'dirvish',
  --         'fugitive',
  --         'telescope',
  --         'nvimtree',
  --         'graphql',
  --         'GraphQL',
  --         'NvimTree',
  --       },
  --       -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
  --       -- filetypes_allowlist = {},
  --       -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
  --       modes_denylist = { 'i' },
  --       -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
  --       modes_allowlist = { 'n' },
  --       -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
  --       -- Only applies to the 'regex' provider
  --       -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  --       providers_regex_syntax_denylist = { 'graphql', 'graphqlparameter', 'graphqlkeyword', 'GraphQL' },
  --       -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
  --       -- Only applies to the 'regex' provider
  --       -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  --       -- providers_regex_syntax_allowlist = {},
  --       -- under_cursor: whether or not to illuminate under the cursor
  --       under_cursor = true,
  --     })
  --   end
  -- },

  ["Pocco81/TrueZen.nvim"] = {
    cmd = {
      "TZAtaraxis",
      "TZMinimalist",
      "TZFocus",
    },
    config = function()
      require "custom.plugins.truezen"
    end,
  },

  ["christoomey/vim-tmux-navigator"] = {},

  -- ["hrsh7th/cmp-copilot"] = {},

  ["zbirenbaum/copilot.lua"] = {
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  },

  ["zbirenbaum/copilot-cmp"] = {
    after = { "copilot.lua" },
    module = "copilot_cmp",
    config = function()
      require("copilot_cmp").setup {
        method = "getCompletionsCycling",
      }
    end
  },


  ["ray-x/guihua.lua"] = {
    run = "cd lua/fzy && make",
    before = { "ray-x/navigator.lua" },
    config = function()
      require("guihua.maps").setup {
        maps = {
          prev = "<C-k>",
          next = "<C-j>",
        },
      }
    end,
  },

  ["jose-elias-alvarez/nvim-lsp-ts-utils"] = {},

  ["phaazon/hop.nvim"] = {
    event = "BufEnter",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup {}
    end,
  },

  ["brooth/far.vim"] = {},

  ["editorconfig/editorconfig"] = { event = "InsertEnter" },

  ["slim-template/vim-slim"] = { ft = { "slim" } },

  ["mg979/vim-visual-multi"] = { branch = "master", event = "InsertEnter" },

  ["jparise/vim-graphql"] = { event = "InsertEnter", ft = jsfiles },

  ["windwp/nvim-ts-autotag"] = { ft = jsfiles, after = "nvim-treesitter" },

  ["kchmck/vim-coffee-script"] = { ft = "coffee" },

  ["folke/trouble.nvim"] = {
    event = "BufEnter",
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
      }
    end,
  },

  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "custom.plugins.cmp" -- must be right path
    end,
  },

  ["ray-x/cmp-treesitter"] = {
    after = "nvim-cmp",
  },

  ["tzachar/cmp-tabnine"] = {
    run = "./install.sh",
    -- config = function()
    --   local tabnine = require "cmp_tabnine.config"
    --   tabnine:setup {
    --     max_lines = 1000,
    --     max_num_results = 5,
    --     sort = true,
    --     run_on_every_keystroke = true,
    --     snippet_placeholder = "..",
    --   }
    -- end,
  },

  ["mbbill/undotree"] = {},

  ["easymotion/vim-easymotion"] = {
    event = "BufEnter",
    config = function() end,
  },

  ["rcarriga/nvim-notify"] = {
    config = function()
      vim.notify = require "notify"
    end,
  },

  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to the default settings
        -- refer to the configuration section below
      }
    end,
  },

  ["williamboman/mason-lspconfig.nvim"] = {},

  ["williamboman/mason.nvim"] = {
    after = "nvim-lspconfig",
    cmd = require("core.lazy_load").mason_cmds,
    requires = "SmiteshP/nvim-navic",
    config = function()
      require "plugins.configs.mason"
      require "custom.plugins.mason"
    end,
  },

  ["ray-x/navigator.lua"] = {
    after = "nvim-lspconfig",
    requires = { "cj/guihua.lua", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("navigator").setup {
        default_mapping = false,
        -- mason = true,
        icons = {
          code_action_icon = '💡'
        },
        lsp = {
          disable_lsp = { "denols", "tsserver", "astro", "pyright" },
          disply_diagnostic_qf = false,
          enable = true, -- skip lsp setup if disabled make sure add require('navigator.lspclient.mapping').setup() in you
          -- own on_attach
          diagnostic = {
            underline = true,
            virtual_text = false, -- show virtual for diagnostic message
            update_in_insert = false, -- update diagnostic message in insert mode
          },
          format_on_save = false,
          diagnostic_virtual_text = false,
          code_action = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = false,
          },
          code_lens_action = {
            enable = true,
            sign = true,
            sign_priority = 20,
            virtual_text = false,
          },
        },
      }
    end,
  },
}
