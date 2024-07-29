local deps_ok, dap_virtual_text, dapui, dapui_widgets, dap = pcall(function()
  return require "nvim-dap-virtual-text", require "dapui", require "dap.ui.widgets", require "dap"
end)
if not deps_ok then
  return
end
require("neodev").setup {
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...,
}
dap_virtual_text.setup()

dapui.setup {

  icons = {
    collapsed = "›",
    current_frame = "›",
    expanded = "",
  },
}

local map = vim.keymap.set

local function c(func, opts)
  return function()
    func(opts)
  end
end

map("n", "<leader>d.", c(dap.run_to_cursor))
map("n", "<leader>dJ", c(dap.down))
map("n", "<leader>dK", c(dap.up))
map("n", "<leader>dL", function()
  dap.list_breakpoints()
  vim.cmd.copen()
end)
map("n", "<leader>dX", function()
  dap.terminate()
  dapui.close()
end)
map("n", "<leader>da", c(dap.toggle_breakpoint))
map("n", "<leader>dc", c(dap.continue))
map("n", "<leader>dh", c(dap.step_back))
map("n", "<leader>dj", c(dap.step_into))
map("n", "<leader>dk", c(dap.step_out))
map("n", "<leader>dl", c(dap.step_over))
map("n", "<leader>dr", c(dap.run_last))
map("n", "<leader>dx", c(dap.clear_breakpoints))

map("v", "<M-e>", c(dapui.eval))
map("n", "<leader>d?", c(dapui_widgets.hover))

dap.listeners.after.event_initialized["dapui_config"] = c(dapui.open)
dap.listeners.after.event_loadedSource["dapui_config"] = c(dapui.open)

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "WarningMsg" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "MatchParen", linehl = "CursorLine" })

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}", --let both ports be the same for now...
  executable = {
    command = "node",
    -- -- 💀 Make sure to update this path to point to your installation
    args = { vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
    -- command = "js-debug-adapter",
    -- args = { "${port}" },
  },
}

for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (pwa-node)",
      cwd = "${workspaceFolder}", -- vim.fn.getcwd(),
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch Current File (Typescript)",
      cwd = "${workspaceFolder}",
      runtimeArgs = { "--loader=ts-node/esm" },
      program = "${file}",
      runtimeExecutable = "node",
      -- args = { '${file}' },
      sourceMaps = true,
      protocol = "inspector",
      outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
  }
end
