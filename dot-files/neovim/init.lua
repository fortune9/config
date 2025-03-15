vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")
require("lazy").setup({
  -- "sheerun/vim-polyglot",  -- A collection of language packs for Vim
  --"nvim-treesitter/nvim-treesitter",  -- Example: Treesitter plugin
  "nvim-lua/plenary.nvim",  -- Required for many plugins
  {
      "github/copilot.vim",  -- GitHub Copilot plugin
      config = function()
        -- Optional: Add custom configurations here
        vim.g.copilot_enabled = true  -- Enable Copilot by default
        vim.g.copilot_filetypes = {  -- Enable Copilot for specific filetypes
          ["*"] = true,
        }

        -- Map Copilot suggestions to a keybinding
        vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
      end,
  },
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },  -- Optional: for icons
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },  -- Optional: for icons
    config = function()
      require("lualine").setup()
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
        },
        pickers = {
            colorscheme = {
                enable_preview = true
            }
        }
      })
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "lua", "javascript", "typescript", "bash", "json" },  -- Add your languages
        highlight = { enable = true },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- Configure ts_ls (TypeScript Language Server)
      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          -- Custom on_attach function (optional)
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),  -- Add capabilities for nvim-cmp
        settings = {
          tsserver = {
            -- Add any custom settings here
          },
        },
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP source
      "hrsh7th/cmp-buffer",     -- Buffer source
      "hrsh7th/cmp-path",       -- Path source
      "hrsh7th/cmp-cmdline",    -- Command line source
      "L3MON4D3/LuaSnip",       -- Snippet engine
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").setup()
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    config = function()
      vim.cmd("colorscheme dracula")
    end,
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Choose from: latte, frappe, macchiato, mocha
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- Choose from: soft, medium, hard
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },

  -- Onedark
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker", -- Choose from: dark, darker, cool, deep, warm, warmer, light
      })
      vim.cmd("colorscheme onedark")
    end,
  },

  -- Tokyonight
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "storm", -- Choose from: night, storm, day, moon
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
})

-- Basic settings
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.autowrite = true
vim.opt.showmatch = true
vim.opt.shiftwidth = 4
vim.opt.showmode = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.textwidth = 70
vim.opt.ruler = true
vim.opt.background = "dark"
vim.opt.smartindent = true
vim.opt.termguicolors = true
-- vim.opt.mouse = "a" -- Enable mouse support, interferes with
-- copy-paste using the system clipboard

-- Enable syntax highlighting
vim.cmd("syntax on")

-- Enable filetype detection, plugins, and indentation
vim.cmd("filetype plugin indent on")

-- Set colorscheme
vim.cmd("colorscheme industry")
vim.cmd("colorscheme catppuccin-mocha")

-- Automatically copy selected text to clipboard
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
      vim.fn.setreg("+", vim.fn.getreg("@+"))
    end
  end,
})

-- Key mappings
vim.g.mapleader = ","  -- Set the leader key to comma, default is backslash \
-- Keybindings for Telescope
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>cs", "<cmd>Telescope colorscheme<CR>", { noremap = true, silent = true })
-- Keybindings for nvim-tree
vim.api.nvim_set_keymap("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
-- Keybindings for Copilot
vim.api.nvim_set_keymap("i", "<C-J>", "copilot#Accept('<CR>')", { expr = true, silent = true })
-- Keybindings for LSP
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
-- Keybindings for nvim-treesitter
vim.api.nvim_set_keymap("n", "<Leader>tt", "<cmd>TSBufToggle highlight<CR>", { noremap = true, silent = true })

