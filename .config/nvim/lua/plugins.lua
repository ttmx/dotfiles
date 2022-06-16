return {
  {"wbthomason/packer.nvim"},
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha"
      vim.cmd("colorscheme catppuccin")
    end
  },
  {
    "rrethy/vim-hexokinase",
    run = "make hexokinase"
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup()
    end
  },
  {
    'ethanholz/nvim-lastplace'
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "c", "javascript", "rust", "lua", "python","html","json","bash","css" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          --disable = { "c", "rust" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
  {
    "williamboman/nvim-lsp-installer",
    config = function()
      require("nvim-lsp-installer").setup()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    as="luasnip"
  },
  {'saadparwaiz1/cmp_luasnip'},
  { "hrsh7th/nvim-cmp",
  config = function()
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

    local lspconfig = require('lspconfig')

    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    local function installed_servers()
      local servers = {}
      for _,v in pairs(require("nvim-lsp-installer").get_installed_servers()) do
        table.insert(servers, v.name)
      end
      return servers
    end
    local servers = installed_servers()
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
      }
    end

    -- luasnip setup
    local luasnip = require 'luasnip'

    -- nvim-cmp setup
    local cmp = require 'cmp'
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'nvim_lsp' },
      },
    }
  end
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function()
         require("Comment").setup()
      end,
   },
   {
     "windwp/nvim-autopairs",
     config = function() require("nvim-autopairs").setup {} end
   },
   {
     "rcarriga/nvim-notify",
     config = function()
       require'notify'.setup {
         -- Animation style (see below for details)
         stages = "slide",

         -- Function called when a new window is opened, use for changing win settings/config
         on_open = nil,

         -- Function called when a window is closed
         on_close = nil,

         -- Render function for notifications. See notify-render()
         render = "default",

         -- Default timeout for notifications
         timeout = 5000,

         -- Max number of columns for messages
         max_width = nil,
         -- Max number of lines for a message
         max_height = nil,

         -- For stages that change opacity this is treated as the highlight behind the window
         -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
         background_colour = "Normal",

         -- Minimum width for notification windows
         minimum_width = 50,

         -- Icons for the different levels
         icons = {
           ERROR = "",
           WARN = "",
           INFO = "",
           DEBUG = "",
           TRACE = "✎",
         },
       }
      end,
      event = "BufRead",
   },
   {
     "onsails/lspkind-nvim",
     requires = "nvim-cmp",
     config = function()
       require("cmp").setup {
         formatting = {
           format = require("lspkind").cmp_format({
             mode = 'symbol', -- show only symbol annotations
             maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
         })
       }
     }
   end
   },

}
