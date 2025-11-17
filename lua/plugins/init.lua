return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require "plugins.configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
        -- dependencies = {
        --     "nvim-treesitter/nvim-treesitter-context"
        -- }
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        'VonHeikemen/lsp-zero.nvim',
        lazy = false,
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'mason-org/mason.nvim',
                cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
                build = ":MasonUpdate",
                opts = function()
                    return require "plugins.configs.mason"
                end,
            },
            { 'mason-org/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        },
        config = function()
            require("plugins.configs.lsp-zero")
            require 'lspconfig'.sqlls.setup {
                filetypes = { 'sql' },
                root_dir = function(_)
                    return vim.loop.cwd()
                end,
            }
        end,
    },
    -- {
    --     "Hoffs/omnisharp-extended-lsp.nvim",
    --     ft = "cs",
    --     keys = {
    --         {
    --             "gd",
    --             function() require("omnisharp_extended").lsp_definition() end,
    --             desc = "Go to definition cs"
    --         },
    --     },
    -- },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            {
                "<leader>pf",
                function() require("telescope.builtin").find_files() end,
                desc =
                "Find files"
            },
            {
                "<C-p>",
                "<cmd>Telescope git_files<cr>",
                desc =
                "Git files"
            },
            {
                "<leader>ps",
                function() require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") }) end,
                desc =
                "Grep string"
            },
            {
                "<leader>vh",
                "<cmd>Telescope help_tags<cr>",
                desc =
                "Vim help tags"
            },
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("lualine").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
        keys = {
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Toggle trouble qf", silent = true, noremap = true },
        }
    },
    {
        "theprimeagen/harpoon",
        lazy = false,
        keys = {
            { "<leader>a", function() require("harpoon.mark").add_file() end,        desc = "Add file to harpoon" },
            { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle harpoon menu" },
            { "<C-h>",     function() require("harpoon.ui").nav_file(1) end,         desc = "Go to harpoon file 1" },
            { "<C-t>",     function() require("harpoon.ui").nav_file(2) end,         desc = "Go to harpoon file 2" },
            { "<C-n>",     function() require("harpoon.ui").nav_file(3) end,         desc = "Go to harpoon file 3" },
            { "<C-s>",     function() require("harpoon.ui").nav_file(4) end,         desc = "Go to harpoon file 4" },
        },
    },
    {
        "mbbill/undotree",
        cmd = { "Undotree", "UndotreeToggle" },
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
        },
    },
    {
        "folke/zen-mode.nvim",
        lazy = false,
        keys = {
            {
                "<leader>zz",
                function()
                    require("zen-mode").toggle({
                        window = {
                            width = 90,
                            options = {}
                        },
                    })
                    vim.wo.wrap = false
                    vim.wo.number = true
                    vim.wo.rnu = true
                end,
                desc = "Toggle Zen-mode"
            },
            {
                "<leader>zZ",
                function()
                    require("zen-mode").toggle({
                        window = {
                            width = 80,
                            options = {}
                        },
                    })
                    vim.wo.wrap = false
                    vim.wo.number = false
                    vim.wo.rnu = false
                    vim.opt.colorcolumn = "0"
                end,
                desc = "Toggle Zen-mode"
            },
        }
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Check Git status" },
        }
    },
    {
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaWrite", "SudaRead" },
    },
    {
        'eandrju/cellular-automaton.nvim',
        cmd = { "CellularAutomaton" },
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = function(_, opts)
            require("gopher").setup(opts)
        end,
        build = function()
            vim.cmd [[silent! GoInstallDeps]]
        end,
        keys = {
            { "<leader>ge", "<cmd>GoIfErr<cr>", desc = "Go if err" },
        },
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
        config = function()
            require('Comment').setup()
        end
    },
    {
        "seblj/roslyn.nvim",
        ft = "cs",
        opts = {
            -- your configuration comes here; leave empty for default settings
        }
    },
        {
        "vim-denops/denops.vim",
        dependencies = {
            "uga-rosa/scorpeon.vim",
            config = function()
            vim.g.scorpeon_highlight = {
                enable = {"bsv"},
                disable = function()
                return vim.fn.getfsize(vim.fn.expand('%')) > 1 * 1024 * 1024
                end
            }
            end,
        },
        ft = "bsv",
    },
    {
        "mtikekar/vim-bsv",
        ft = "bsv"
    },

    {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = function(client, bufnr)
      -- your on_attach function
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
},
{
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end
},
{
  "tidalcycles/vim-tidal",
  lazy = false,
},
}
