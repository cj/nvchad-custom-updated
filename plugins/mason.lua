-- https://github.com/ahmedelgabri/dotfiles/blob/c2e2e3718e769020f1468048e33e60ad8a97edfc/config/.vim/lua/_/lsp.lua#L329-L378
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

require('neogen').setup {
  enabled = true,
  input_after_comment = true,
}

require("mason-lspconfig").setup({
  ensure_installed = {
    "prettier"
  },
})

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv via poetry in workspace directory.
  -- local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  -- if match ~= '' then
  --   local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
  --   return path.join(venv, 'bin', 'python')
  -- end
  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ '.venv', 'venv' }) do
    local match = path.join(workspace, pattern, 'pyvenv.cfg')
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  print('moo')

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

local function attach_navigator(client, bufnr)
  require("navigator.lspclient.attach").on_attach(client, bufnr)
end

local navic = require("nvim-navic")

local default_on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = true
  client.resolved_capabilities.document_range_formatting = true

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  -- nv_on_attach(client, bufnr)
  ---@diagnostic disable-next-line: empty-block
  if pcall(attach_navigator, client, bufnr) then
    -- do nothing
  end
end

local default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_attach = default_on_attach,
  capabilities = default_capabilities,
})

local python_root_files = {
  'WORKSPACE', -- added for Bazel; items below are from default config
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
}

require("mason-lspconfig").setup_handlers({
  function(server_name)
    if server_name == "denols" then
      local deno_file = io.open("./deno.json", "r")
      if deno_file ~= nil then
        io.close(deno_file)
        lspconfig[server_name].setup({
          init_options = {
            lint = true,
          },
        })
      end
    elseif server_name == "tsserver" or server_name == "eslint" then
      local packageJson = io.open("./package.json", "r")
      if packageJson ~= nil then
        io.close(packageJson)
        if server_name == "tsserver" then
          require("typescript").setup({
            server = {
              init_options = {
                preferences = {
                  importModuleSpecifierPreference = "non-relative"
                }
              },

              on_attach = function(client, bufnr)
                default_on_attach(client, bufnr)

                navic.attach(client, bufnr)

                client.resolved_capabilities.document_formatting = false
                client.resolved_capabilities.document_range_formatting = false
              end,

              capabilities = default_capabilities,

              cmd = { "/Users/cj/.asdf/shims/typescript-language-server", "--stdio" },
            }
          })

        else
          lspconfig[server_name].setup({
            init_options = {
              lint = true,
            },
          })
        end
      end
    else
      lspconfig[server_name].setup({})
    end
  end,

  ["sourcery"] = function()
    lspconfig["sourcery"].setup({
      init_options = {
        token = "user_MBPBdLmUO_nvnEkRBeZezXVCM5KND_2O0NWgPxJMLREefJptPKbLosQ0ySM"
      },
      capabilities = default_capabilities,
    })
  end,

  -- ["pylsp"] = function()
  --   lspconfig["pylsp"].setup({
  --     init_options = {
  --       lint = true,
  --       format = true,
  --     },
  --
  --     settings = {
  --       configurationSources = { "flake8" },
  --       formatCommand = { "black" }
  --     },
  --
  --     -- on_attach = default_on_attach,
  --
  --     cmd = { "/Users/cj/.asdf/shims/pylsp" },
  --     -- cmd = { "pylsp" },
  --     capabilities = default_capabilities
  --   })
  -- end,

  ["eslint"] = function()
    lspconfig["eslint"].setup({
      filetypes = {
        "javascript",
        "javascriptreact",
        "astro",
        "typescript",
        "typescriptreact",
        "html"
      },
      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)
      end,

      capabilities = default_capabilities,
      -- cmd = { "/Users/cj/.asdf/shims/vscode-json-language-server", "--stdio" },
      cmd = { "vscode-eslint-language-server", "--stdio" },
    })
  end,

  ["jsonls"] = function()
    lspconfig["jsonls"].setup({
      -- cmd = { "/Users/cj/.asdf/shims/vscode-json-language-server", "--stdio" },
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      init_options = {
        lint = true,
        format = true,
      },
      settings = {
        json = {
          format = {
            enable = true,
          },

          validate = {
            enable = true,
          },

          -- Schemas https://www.schemastore.org
          schemas = {
            {
              fileMatch = { "package.json" },
              url = "https://json.schemastore.org/package.json"
            },
            {
              fileMatch = { "tsconfig*.json" },
              url = "https://json.schemastore.org/tsconfig.json"
            },
            {
              fileMatch = {
                ".prettierrc",
                ".prettierrc.json",
                "prettier.config.json"
              },
              url = "https://json.schemastore.org/prettierrc.json"
            },
            {
              fileMatch = { ".eslintrc", ".eslintrc.json" },
              url = "https://json.schemastore.org/eslintrc.json"
            },
            {
              fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
              url = "https://json.schemastore.org/babelrc.json"
            },
            {
              fileMatch = { "lerna.json" },
              url = "https://json.schemastore.org/lerna.json"
            },
            {
              fileMatch = { "now.json", "vercel.json" },
              url = "https://json.schemastore.org/now.json"
            },
            {
              fileMatch = {
                ".stylelintrc",
                ".stylelintrc.json",
                "stylelint.config.json"
              },
              url = "http://json.schemastore.org/stylelintrc.json"
            }
          }
        }
      }
    })
  end,


  ["bashls"] = function()
    lspconfig["bashls"].setup({
      init_options = {
        lint = true,
        format = true,
      },

      cmd = { "/Users/cj/.asdf/shims/bash-language-server", "--stdio" },
      -- cmd = { "bash-language-server", "--stdio" },
    })
  end,

  ["yamlls"] = function()
    lspconfig["yamlls"].setup({
      init_options = {
        lint = true,
        format = true,
      },
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
          },
          -- Schemas https://www.schemastore.org
          schemas = {
            ["http://json.schemastore.org/gitlab-ci.json"] = { ".gitlab-ci.yml" },
            ["https://json.schemastore.org/bamboo-spec.json"] = {
              "bamboo-specs/*.{yml,yaml}"
            },
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
              "docker-compose*.{yml,yaml}"
            },
            ["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
            ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
            ["http://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
            ["http://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
            ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}"
          }
        }
      },

      cmd = { "/Users/cj/.asdf/shims/yaml-language-server", "--stdio" },
      -- cmd = { "yaml-language-server", "--stdio" },
    })
  end,

  ["cssls"] = function()
    lspconfig["cssls"].setup({
      init_options = {
        lint = false,
        format = false,
      },

      settings = {
        css = {
          lint = {
            unknownAtRules = "ignore"
          }
        }
      },

      cmd = { "/Users/cj/.asdf/shims/vscode-css-language-server", "--stdio" },
      -- cmd = { "vscode-css-language-server", "--stdio" },
      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)
      end,

      capabilities = default_capabilities,
    })
  end,

  ["stylelint_lsp"] = function()
    lspconfig["stylelint_lsp"].setup({
      filetypes = { "css", "scss", "sass" },
      settings = {
        stylelintplus = {
          autoFixOnSave = true,
          autoFixOnFormat = true,
        }
      },

      cmd = { "/Users/cj/.asdf/shims/stylelint-lsp", "--stdio" },
      -- cmd = { "stylelint-lsp", "--stdio" },
      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)
      end,

      capabilities = default_capabilities,
    })
  end,

  ["graphql"] = function()
    lspconfig["graphql"].setup({
      init_options = {
        lint = true,
        format = true,
      },
      filetypes = { "typescript", "typescriptreact", "graphql" },
      cmd = { "/Users/cj/.asdf/shims/graphql-lsp", "server", "-m", "stream" },
      root_dir = lspconfig.util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*')
    })
  end,

  ["tailwindcss"] = function()
    lspconfig["tailwindcss"].setup({
      filetypes = {
        "javascriptreact",
        "javascript.jsx",
        "typescript.tsx",
        "typescriptreact",
        "astro",
        "scss",
        "css",
        "svelte",
        "solid",
        "vue"
      },
      settings = {
        tailwindCSS = {
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },

          validate = true,

          experimental = {
            classRegex = { "tw\\.\\w+`([^`]*)" },
          },
        }
      },
      on_attach = function(client, bufnr)
        require('tailwindcss-colors').buf_attach(bufnr)

        default_on_attach(client, bufnr)
      end,

      capabilities = default_capabilities,

    })
  end,

  ["solargraph"] = function()
    lspconfig["solargraph"].setup({
      -- cmd = { "solargraph", "stdio" },
      -- cmd = { "bundle exec solargraph", "stdio" },
      -- cmd = { "bundle", "exec", "solargraph", "stdio" },
      -- cmd = { "bundle", "exec", "solargraph" },
      -- cmd = { "/Users/cj/.asdf/shims/solargraph", "stdio" },

      root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),

      settings = {
        solargraph = {
          useBundler = true,
          autoformat = true,
          completion = true,
          diagnostic = true,
          folding = true,
          references = true,
          rename = true,
          symbols = true
        }
      },

      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)

        navic.attach(client, bufnr)
      end,
      capabilities = default_capabilities,
    })
  end,

  ['jedi_language_server'] = function()
    lspconfig["jedi_language_server"].setup({
      settings = {
        jedi = {
          diagnostics = {
            enabled = true,
            didOpen = true,
            didChange = true,
            didSave = true,
          }
        }
      },

      -- root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
      on_attach = function(client, bufnr)
        attach_navigator(client, bufnr)
        default_on_attach(client, bufnr)
      end,
      capabilities = default_capabilities,
    })
  end,

  ["html"] = function()
    lspconfig["html"].setup({
      capabilities = default_capabilities,
      on_attach = default_on_attach,
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html" },
      init_options = {
        lint = true,
        format = true,
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true
        },
        provideFormatter = true
      },
      settings = {},
      single_file_support = true
    })
  end,

  ["pyright"] = function()
    lspconfig["pyright"].setup({
      root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
      on_attach = function(client, bufnr)
        attach_navigator(client, bufnr)
        default_on_attach(client, bufnr)
      end,
      on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
      end,
      capabilities = default_capabilities,
      -- settings = {
      --   python = {
      --     analysis = {
      --       autoSearchPaths = true,
      --       diagnosticMode = "workspace",
      --       useLibraryCodeForTypes = true,
      --     }
      --   }
      -- }
    })
  end,

  ["astro"] = function()
    lspconfig["astro"].setup({
      init_options = {
        typescript = {
          serverPath = "/Users/cj/.asdf/installs/nodejs/16.17.0/.npm/lib/node_modules/typescript"
        }
      },

      cmd = { "/Users/cj/.asdf/shims/astro-ls", "--stdio" },

      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)

        attach_navigator(client, bufnr)
      end,

      capabilities = default_capabilities,
    })
  end,
})

-- local eslint = {
--   -- lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
--   -- lintStdin = true,
--   -- lintFormats = { "%f:%l:%c: %m" },
--   -- lintIgnoreExitCode = true,
--   formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
--   formatStdin = true
-- }
-- local function eslint_config_exists()
--   local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)
--
--   if not vim.tbl_isempty(eslintrc) then
--     return true
--   end
--
--   local packageJson = io.open("./package.json", "r")
--   if packageJson ~= nil then
--     io.close(packageJson)
--     return true
--   end
--
--   return false
-- end
--
-- lspconfig.efm.setup {
--   on_attach = function(client, bufnr)
--     client.resolved_capabilities.document_formatting = true
--     client.resolved_capabilities.goto_definition = false
--     default_on_attach(client, bufnr)
--
--     -- navic.attach(client, bufnr)
--   end,
--   capabilities = default_capabilities,
--   root_dir = function()
--     if not eslint_config_exists() then
--       return nil
--     end
--     return vim.fn.getcwd()
--   end,
--   settings = {
--     lint = false,
--     languages = {
--       javascript = { eslint },
--       javascriptreact = { eslint },
--       ["javascript.jsx"] = { eslint },
--       typescript = { eslint },
--       ["typescript.tsx"] = { eslint },
--       typescriptreact = { eslint }
--     }
--   },
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescript.tsx",
--     "typescriptreact",
--     "astro"
--   },
-- }

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = false,
    update_in_insert = true,
  }
)

if not configs.ruby_lsp then
  local enabled_features = {
    "documentHighlights",
    "documentSymbols",
    "foldingRanges",
    "selectionRanges",
    "semanticHighlighting",
    "formatting",
    "codeActions",
    "diagnostics"
  }

  configs.ruby_lsp = {
    default_config = {
      cmd = { "bundle", "exec", "ruby-lsp" },
      filetypes = { "ruby" },
      root_dir = util.root_pattern("Gemfile", ".git"),
      capabilities = default_capabilities,
      init_options = {
        enabledFeatures = enabled_features,
      },
      settings = {},
    },
    commands = {
      FormatRuby = {
        function()
          vim.lsp.buf.format({
            name = "ruby_lsp",
            async = true,
          })
        end,
        description = "Format using ruby-lsp",
      },
    },
  }
end

lspconfig.ruby_lsp.setup({ on_attach = default_on_attach, capabilities = default_capabilities })

-- require 'py_lsp'.setup {}

lspconfig["ltex"].setup {
  cmd = { "ltex-ls" },

  capabilities = default_capabilities,

  on_attach = function(client, bufnr)
    default_on_attach(client, bufnr)

    -- your other on_attach functions.
    require("ltex_extra").setup {
      load_langs = { "en-US" }, -- table <string> : languages for witch dictionaries will be loaded
      init_check = true, -- boolean : whether to load dictionaries on startup
      path = "/Users/cj/.config/nvim/lua/custom/spell", -- string : path to store dictionaries. Relative path uses current working directory
      log_level = "none", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
    }
  end,

  settings = {
    ltex = {
      -- your settings.
    }
  }
}

local diagnosticls = require("diagnosticls")

lspconfig.diagnosticls.setup({
  filetypes = {
    "python",
    -- unpack(diagnosticls.filetypes),
  },
  init_options = {
    linters = vim.tbl_deep_extend("force", diagnosticls.linters, {
      flake8 = {
        rootPatterns = { ".flake8", "setup.cfg", "tox.ini", "pyproject.toml" },
      },
    }),
    formatters = diagnosticls.formatters,
    filetypes = {
      python = { "flake8", "dmypy" },
    },
    formatFiletypes = {
      python = { "isort", "black" },
    },
  },
})
