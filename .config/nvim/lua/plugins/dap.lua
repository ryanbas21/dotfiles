return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "nvim-neotest/nvim-nio",
    {
      "mfussenegger/nvim-dap",
      keys = {
        {
          "<F5>",
          "<cmd>lua require'dap'.continue()<CR>",
          { noremap = true, silent = true, desc = "Start/Continue debugging" },
        },
        { "<F10>", "<cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true, desc = "Step over" } },
        { "<F11>", "<cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true, desc = "Step into" } },
        { "<F12>", "<cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true, desc = "Step out" } },
        {
          "<leader>b",
          "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
          noremap = true,
          silent = true,
          desc = "Toggle breakpoint",
        },
        {
          "<leader>B",
          "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
          noremap = true,
          silent = true,
          desc = "Conditional breakpoint",
        },
        {
          "<leader>lp",
          "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
          noremap = true,
          silent = true,
          desc = "Log point",
        },
        { "<leader>r", "<cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true, desc = "Open REPL" } },
        {
          "<leader>h",
          "<cmd>lua require'dap.ui.variables'.hover()<CR>",
          noremap = true,
          silent = true,
          desc = "Hover variables",
        },
        {
          "<leader>v",
          "<cmd>lua require'dap.ui.variables'.visual_hover()<CR>",
          noremap = true,
          silent = true,
          desc = "Visual hover",
        },
        {
          "<leader>du",
          "<cmd>lua require'dapui'.toggle()<CR>",
          noremap = true,
          silent = true,
          desc = "Toggle DAP UI",
        },
      },
    },
    keys = {
      {
        "<leader>du",
        "<cmd>lua require'dapui'.toggle()<CR>",
        { noremap = true, silent = true, desc = "Toggle DAP UI" },
      },
    },
  },
}
