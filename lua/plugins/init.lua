return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		lazy = false,
		dependencies = {
			{ -- Optional
				"mason-org/mason.nvim",
				cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
				build = ":MasonUpdate",
				opts = function()
					return require("plugins.configs.mason")
				end,
			},
			{ "neovim/nvim-lspconfig" },
			{
				"saghen/blink.cmp",
				-- optional: provides snippets for the snippet source
				dependencies = { "rafamadriz/friendly-snippets" },

				-- use a release tag to download pre-built binaries
				version = "1.*",
				-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
				-- build = 'cargo build --release',
				-- If you use nix, you can build from source using latest nightly rust with:
				-- build = 'nix run .#build-plugin',

				---@module 'blink.cmp'
				---@type blink.cmp.Config
				opts = {
					-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
					-- 'super-tab' for mappings similar to vscode (tab to accept)
					-- 'enter' for enter to accept
					-- 'none' for no mappings
					--
					-- All presets have the following mappings:
					-- C-space: Open menu or open docs if already open
					-- C-n/C-p or Up/Down: Select next/previous item
					-- C-e: Hide menu
					-- C-k: Toggle signature help (if signature.enabled = true)
					--
					-- See :h blink-cmp-config-keymap for defining your own keymap
					keymap = { preset = "default" },

					appearance = {
						-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
						-- Adjusts spacing to ensure icons are aligned
						nerd_font_variant = "mono",
					},

					-- (Default) Only show the documentation popup when manually triggered
					completion = { documentation = { auto_show = false } },

					-- Default list of enabled providers defined so that you can extend it
					-- elsewhere in your config, without redefining it, due to `opts_extend`
					sources = {
						default = { "lsp", "path", "snippets", "buffer" },
					},

					-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
					-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
					-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
					--
					-- See the fuzzy documentation for more information
					fuzzy = { implementation = "prefer_rust_with_warning" },
				},
				opts_extend = { "sources.default" },
			},
			-- { 'hrsh7th/nvim-cmp' },     -- Required
			-- { 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	},
	-- Autocompletion
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>pf",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<C-p>",
				"<cmd>Telescope git_files<cr>",
				desc = "Git files",
			},
			{
				"<leader>ps",
				function()
					require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
				end,
				desc = "Grep string",
			},
			{
				"<leader>vh",
				"<cmd>Telescope help_tags<cr>",
				desc = "Vim help tags",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		config = function()
			require("trouble").setup({
				icons = false,
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
		keys = {
			{
				"<leader>xq",
				"<cmd>TroubleToggle quickfix<cr>",
				desc = "Toggle trouble qf",
				silent = true,
				noremap = true,
			},
		},
	},
	{
		"theprimeagen/harpoon",
		lazy = false,
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add file to harpoon",
			},
			{
				"<C-e>",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "Toggle harpoon menu",
			},
			{
				"<C-h>",
				function()
					require("harpoon.ui").nav_file(1)
				end,
				desc = "Go to harpoon file 1",
			},
			{
				"<C-t>",
				function()
					require("harpoon.ui").nav_file(2)
				end,
				desc = "Go to harpoon file 2",
			},
			{
				"<C-n>",
				function()
					require("harpoon.ui").nav_file(3)
				end,
				desc = "Go to harpoon file 3",
			},
			{
				"<C-s>",
				function()
					require("harpoon.ui").nav_file(4)
				end,
				desc = "Go to harpoon file 4",
			},
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
							options = {},
						},
					})
					vim.wo.wrap = false
					vim.wo.number = true
					vim.wo.rnu = true
				end,
				desc = "Toggle Zen-mode",
			},
			{
				"<leader>zZ",
				function()
					require("zen-mode").toggle({
						window = {
							width = 80,
							options = {},
						},
					})
					vim.wo.wrap = false
					vim.wo.number = false
					vim.wo.rnu = false
					vim.opt.colorcolumn = "0"
				end,
				desc = "Toggle Zen-mode",
			},
		},
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "<leader>gs", "<cmd>Git<cr>", desc = "Check Git status" },
		},
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
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
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = false,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaWrite", "SudaRead" },
	},
	{
		"eandrju/cellular-automaton.nvim",
		cmd = { "CellularAutomaton" },
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
		keys = {
			{ "<leader>ge", "<cmd>GoIfErr<cr>", desc = "Go if err" },
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"seblj/roslyn.nvim",
		ft = "cs",
		opts = {
			-- your configuration comes here; leave empty for default settings
		},
	},
	{
		"vim-denops/denops.vim",
		dependencies = {
			"uga-rosa/scorpeon.vim",
			config = function()
				vim.g.scorpeon_highlight = {
					enable = { "bsv" },
					disable = function()
						return vim.fn.getfsize(vim.fn.expand("%")) > 1 * 1024 * 1024
					end,
				}
			end,
		},
		ft = "bsv",
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
		end,
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"tidalcycles/vim-tidal",
		lazy = false,
	},
}
