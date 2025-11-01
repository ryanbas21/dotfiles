local M = {}

local schemastore

local function get_schemastore()
  if schemastore then
    return schemastore
  end

  local ok, store = pcall(require, "schemastore")
  if not ok then
    local lazy_ok, lazy = pcall(require, "lazy")
    if lazy_ok then
      lazy.load { plugins = { "schemastore.nvim" } }
      ok, store = pcall(require, "schemastore")
    end
  end

  if ok then
    schemastore = store
    return schemastore
  end

  return nil
end

local schemastore_module = get_schemastore()

M.servers = {
  -- Language servers with default settings
  eslint = {},
  angularls = {},
  bashls = {},
  clojure_lsp = {},
  ocamllsp = {},
  cssls = {},
  -- cssmodules_ls = {},
  diagnosticls = {},
  html = {},
  jdtls = {},
  marksman = {},
  prismals = {},
  -- removed servers (no default configs in current nvim-lspconfig release)
  -- purescriptls = {},
  -- rescriptls = {},
  hls = {
    haskell = {
      cmd = { "haskell-language-server-wrapper", "--lsp" },
      formattingProvider = "ormolu",
      ghcide = { enable = true },
      hls_hlint = { enable = true },
      plugin = {
        stan = { globalOn = false },
      },
    },
  },
  tailwindcss = {},
  svelte = {},
  -- gleam = {},
  -- biome = {},
  -- zls = {}, -- removed upstream as of nvim-lspconfig v0.2.0
  -- grammarly = {},
  -- dockerls = {},
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  elixirls = {
    cmd = { "$HOME/.local/share/nvim/mason/packages/elixir-ls/language_server.sh" },
  },

  jsonls = {
    settings = {
      json = {
        schemas = schemastore_module and schemastore_module.json.schemas() or {},
        validate = { enable = true },
      },
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "require" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data
        telemetry = {
          enable = false,
        },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          -- Disable built-in schemaStore support for this plugin
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
        schemas = schemastore_module and schemastore_module.yaml.schemas() or {},
      },
    },
  },
}

return M
