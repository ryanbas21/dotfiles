local telescope_config = require("configs.telescope_config").telescope
return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "aznhe21/actions-preview.nvim",
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
    {
      "piersolenski/telescope-import.nvim",
      dependencies = "nvim-telescope/telescope.nvim",
      keys = {
        {
          "<LEADER>ti",
          ":Telescope import<CR>",
          { desc = "Telescope import" },
        },
      },
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
  },
  config = function()
    require("telescope").setup(telescope_config)

    -- Properly load each extension with error handling
    for _, extension in ipairs(telescope_config.extensions_list) do
      local status, err = pcall(function()
        require("telescope").load_extension(extension)
      end)
    end
  end,
  keys = {
    {
      "<leader>ca",
      function()
        require("actions-preview").code_actions {}
      end,
      desc = "Code Actions",
    },
    {
      "<leader>th",
      "<cmd>Telescope colorscheme<CR>",
      "Telescope themes",
    },
  },
}
