local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "nvim-treesitter/nvim-treesitter",
  {
    "wakatime/vim-wakatime",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    "voldikss/vim-floaterm",
    lazy = false,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = BufEnter,
    opts = function()
      return require("core.plugin_config.null-ls")
    end,
  },
  {
    { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
    --- Comment these if you don't want to manage LSP servers from neovim
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- LSP Support
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
      },
    },
    -- Autocompletion
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "L3MON4D3/LuaSnip" },
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      -- options
    },
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        -- your config goes here
        -- or leave it empty :)
      })
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("core.plugin_config.lint")
    end,
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
