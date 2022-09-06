local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
  fn.system({ "git", "clone", "--depth", "1", "git@github.com:wbthomason/packer.nvim.git", install_path })
  vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  use({
    "junegunn/fzf",
    run = function()
      vim.fn["fzf#install"]()
    end,
  })


  -- Testing
  use({ "mfussenegger/nvim-dap" })
  use({
    "nvim-neotest/neotest",
    requires = {
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-plenary",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-vim-test",
      "nvim-neotest/neotest-python",
      "vim-test/vim-test",
      "haydenmeade/neotest-jest",
      'marilari88/neotest-vitest',
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
  })

  -- Navigation
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "kevinhwang91/nvim-bqf" })
  use({ "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-project.nvim" })
  use({ "karb94/neoscroll.nvim" })
  use "kevinhwang91/nvim-hlslens"
  use({ "nvim-telescope/telescope-media-files.nvim" })
  use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })

  -- Themeing
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "glepnir/dashboard-nvim" })
  use({
    "glepnir/galaxyline.nvim",
    branch = "main",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({ "catppuccin/nvim" })
  use({ "EdenEast/nightfox.nvim" })
  use({ "folke/tokyonight.nvim", branch = "main" })
  use({ "projekt0n/github-nvim-theme" })

  -- UTILS 	--
  use({ "antoinemadec/FixCursorHold.nvim" })
  use({ "lukas-reineke/indent-blankline.nvim" })
  use({ "purescript-contrib/purescript-vim", ft = { "purs", "purescript" } })
  use({ "windwp/nvim-autopairs" })
  use({ "folke/lua-dev.nvim" })
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "folke/trouble.nvim" })
  use({ "simrat39/rust-tools.nvim" })
  use({ "stevearc/aerial.nvim" })
  use({
    "bennypowers/nvim-regexplainer",
    config = function()
      require("regexplainer").setup({})
    end,
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  })
  use({ "tpope/vim-surround" })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-eunuch" })
  use({ "b0o/SchemaStore.nvim" })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
  use("rcarriga/nvim-notify")
  use({ "folke/which-key.nvim" })

  -- LSP --
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })
  use({ "neovim/nvim-lspconfig" })
  use({ "jose-elias-alvarez/null-ls.nvim" })
  use({
    "kosayoda/nvim-lightbulb",
    requires = "antoinemadec/FixCursorHold.nvim",
  })
  use({ "jose-elias-alvarez/typescript.nvim", ft = { "ts", "tsx" } })
  use({ "lukas-reineke/lsp-format.nvim" })
  use({ "lvimuser/lsp-inlayhints.nvim" })
  use({ "Maan2003/lsp_lines.nvim" })
  use({ "onsails/lspkind-nvim" })

  -- Completion--
  use { 'L3MON4D3/LuaSnip', tag = "v1.0.0", wants = "friendly-snippets" } -- Snippet Engine and Snippet Expansion
  use { "rafamadriz/friendly-snippets" }
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
  })
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "hrsh7th/cmp-nvim-lsp" })
  use { 'saadparwaiz1/cmp_luasnip', after = "LuaSnip" }
  use({ "lukas-reineke/cmp-rg" })
  use({ "rcarriga/cmp-dap" })
  use({ "petertriho/cmp-git" })
  use({ "hrsh7th/cmp-buffer" })
  use({ "hrsh7th/cmp-path" })
  use({ "hrsh7th/cmp-cmdline" })
  use({
    'kkharji/lspsaga.nvim', -- nightly
    branch = "main",
    config = function()
      local saga = require("lspsaga")

      saga.setup {}
    end,
  })
  -- GIT
  use({ "rhysd/git-messenger.vim" })
  use({ "sindrets/diffview.nvim" })
  use({ "TimUntersberger/neogit" })
  use({ "lewis6991/gitsigns.nvim" })



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
