local capabilities = require("plugins.configs.lspconfig").capabilities

-- ADD FOR FUCKING KEYS TO WORK
local on_attach = require("plugins.configs.lspconfig").on_attach

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

--GOLANG
lspconfig.gopls.setup {

  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      }
    }
  }
}

-- DART
lspconfig.dartls.setup {
  capabilities = capabilities,
  cmd = {
    "dart",
    "language-server",
    "--protocol=lsp",
    -- "--port=8123",
    -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
  },
  filetypes = { "dart" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = false,
    flutterOutline = true,
  },
  settings = {
    dart = {
      updateImportsOnRename = true,
      completeFunctionCalls = true,
      showTodos = true,
      lineLength = 120,
    },
  },
  on_attach = on_attach
  -- Include other configurations as needed
}

-- FRONT END SHIT
--
lspconfig.html.setup {
  filetypes = { "html", "htmldjango" },
  on_attach = function(client, _)
    -- Formatting on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspAutocommands", { clear = true }),
        buffer = 0,
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 2000 }) -- Use format instead of formatting_syn
        end
      })
    end
  end,
  settings = {
    html = {
      validate = {
        scripts = true, -- Validate JavaScript
      }
    }
  }
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
  cmd = { "typescript-language-server", "--stdio" }
}

lspconfig.eslint.setup({
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  settings = {
    codeActionOnSave = { enable = true, mode = "all" },
    format = true,
  }
})

lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  -- filetypes = {"gohtml"}
})

lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.sqlls.setup {}
