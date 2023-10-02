local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

lsp_zero.set_sign_icons({
  error = "✘",
  warn = "▲",
  hint = "⚑",
  info = "»",
})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
require("mason-lspconfig").setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {
    "tsserver",
    "pyright",
    "cssls",
    "html",
    "lua_ls",
    "emmet_ls",
  },
  handlers = {
    lsp_zero.default_setup,
  },
})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local cmp_format = require("lsp-zero").cmp_format()

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  window = {
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
    },
  },
  formatting = {
    -- changing the order of fields so the icon is the first
    fields = { "menu", "abbr", "kind" },
    format = require("lspkind").cmp_format({
      mode = "symbol", -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters
      ellipsis_char = "", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
    { name = "emoji" },
  },
  preselect = "item",
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

require("mason-lspconfig").setup({
  handlers = {
    lsp_zero.default_setup,
    tsserver = function()
      require("lspconfig").tsserver.setup({
        on_init = function(client)
          client.server_capabilites.disableSuggestions = true
        end,
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
          },
        },
        capabilities = capabilities,
      })
    end,
    emmet_ls = function()
      require("lspconfig").emmet_ls.setup({
        capabilities = capabilities,
      })
    end,
    cssls = function()
      require("lspconfig").cssls.setup({
        capabilities = capabilities,
      })
    end,
    pyright = function()
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
      })
    end,
    html = function()
      require("lspconfig").html.setup({
        capabilities = capabilities,
      })
    end,
  },
})
