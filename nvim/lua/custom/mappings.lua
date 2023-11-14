local M = {}

M.nvterm = {
  plugin = true,

  n = {
    -- FUCKING REBINDING OF FUCKING TERMINAL THAT COULD NOT BE CLOSED
    ["<leader>h"] = {""},

    ["<leader>v"] = {""},
  }
}

-- LALALA CHECKING A GIT
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<leader>1"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    -- focus
    ["<leader>e"] = {""},
  },
}

M.nvterm = {
  plugin = true,
  n = {
      ["<leader>v"] = {""},
  }
}

M.lspconfig = {
  plugin = true,
  n = {
    ["<leader>e"] = {"<cmd>lua vim.diagnostic.open_float()<CR>"}
  },
}

vim.api.nvim_set_keymap('n', '<S-j>', '<Nop>', { noremap = true, silent = true })

return M
