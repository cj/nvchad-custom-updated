local lspconfig = require("lspconfig")

require("mason-lspconfig").setup({
  ensure_installed = {
    "prettier"
  },
})

local function attach_navigator(client, bufnr)
  require("navigator.lspclient.attach").on_attach(client, bufnr)
end

local navic = require("nvim-navic")

local default_on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = true
  client.resolved_capabilities.document_range_formatting = true

  -- if client.server_capabilities.documentSymbolProvider then
  --   navic.attach(client, bufnr)
  -- end
  -- nv_on_attach(client, bufnr)
  ---@diagnostic disable-next-line: empty-block
  if pcall(attach_navigator, client, bufnr) then
    -- do nothing
  end
end

local default_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  on_attach = default_on_attach,
  capabilities = default_capabilities,
})

-- We don't want linting in node_modules
vim.cmd [[
  autocmd BufRead,BufNewFile */node_modules/* lua vim.diagnostic.disable(0)
  autocmd BufRead,BufNewFile */tmp/* lua vim.diagnostic.disable(0)
]]

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
      local deno_file = io.open("./package.json", "r")
      if deno_file ~= nil then
        io.close(deno_file)
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

              cmd = { "typescript-language-server", "--stdio" },
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
      }
    })
  end,

  ["pylsp"] = function()
    lspconfig["pylsp"].setup({
      init_options = {
        lint = true,
        format = true,
      },

      cmd = { "/Users/cj/.asdf/shims/pylsp" },
      -- cmd = { "pylsp" },
    })
  end,

  ["eslint"] = function()
    lspconfig["eslint"].setup({
      -- cmd = { "/Users/cj/.asdf/shims/vscode-json-language-server", "--stdio" },
      cmd = { "vscode-eslint-language-server", "--stdio" },
    })
  end,

  ["jsonls"] = function()
    lspconfig["jsonls"].setup({
      -- cmd = { "/Users/cj/.asdf/shims/vscode-json-language-server", "--stdio" },
      cmd = { "vscode-json-language-server", "--stdio" },
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

      -- cmd = { "/Users/cj/.asdf/shims/vscode-css-language-server", "--stdio" },
      cmd = { "vscode-css-language-server", "--stdio" },
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
      }

    })
  end,

  ["solargraph"] = function()
    lspconfig["solargraph"].setup({
      -- cmd = { "solargraph", "stdio" },
      cmd = { "/Users/cj/.asdf/shims/solargraph", "stdio" },
      -- cmd = { "solargraph", "stdio" },

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
    })
  end,

  ["pyright"] = function()
    lspconfig["pyright"].setup({
      on_attach = function(client, bufnr)
        default_on_attach(client, bufnr)

        navic.attach(client, bufnr)
      end,
    })
  end,
})

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
