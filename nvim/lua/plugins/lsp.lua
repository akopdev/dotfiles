local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
  return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  return
end

local lsp_signature_status_ok, lsp_signature = pcall(require, "lsp_signature")
if not lsp_signature_status_ok then
  return
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true }
  local function buf_set_keymap(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
  end
  -- Disable highlighting from LSP as TreeSitter takes care of it
  client.server_capabilities.semanticTokensProvider = nil

  -- Show function signature when you type
  lsp_signature.on_attach(client, bufnr)
end

local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
  return vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, _config or {})
end


mason.setup {
  ensure_installed = { "basedpyright", "ts_ls" },
  automatic_installation = true
}

mason_lspconfig.setup {
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

mason_lspconfig.setup_handlers {
  function(server_name)
    nvim_lsp[server_name].setup(config())
  end,
  ["lua_ls"] = function()
    nvim_lsp.lua_ls.setup(config({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
        },
      },
    }))
  end,
  ["yamlls"] = function()
    nvim_lsp.yamlls.setup(config({
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
            "/.gitlab-ci.yml",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
            "/docker-compose*.yml",
            kubernetes = "globPattern",
          },
        }
      }
    }))
  end,
  ["gopls"] = function()
    nvim_lsp.gopls.setup(config({
      cmd = {
        "gopls",
        "serve"
      },
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        }
      }
    }))
  end,
  ["ts_ls"] = function()
    nvim_lsp.ts_ls.setup(config({
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      cmd = { "typescript-language-server", "--stdio" },
    }))
  end,
  ["basedpyright"] = function()
    nvim_lsp.basedpyright.setup(config({
      settings = {
        basedpyright = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            extraPaths = { "third_party" },
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
            diagnosticSeverityOverrides = {
              reportUnannotatedClassAttribute = false,
              reportUnusedCallResult = false
            }
          },
        },
      },
    }))
  end,
}

nvim_lsp.dockerls.setup(config())
nvim_lsp.jsonls.setup(config())
nvim_lsp.bashls.setup(config())
nvim_lsp.sqlls.setup(config())
nvim_lsp.cssls.setup(config())

-- Customizing how diagnostics are displayed
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = false,
})


vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = false,
  float = {
    -- UI.
    header = false,
    border = "rounded",
  }
}
