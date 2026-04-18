return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("plugins.configs.treesitter").setup()
		end,
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
			-- Loaded eagerly with mason-lspconfig so `require("cmp_nvim_lsp")`
			-- is available by the time we set up LSP capabilities.
			{ "hrsh7th/cmp-nvim-lsp" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	-- Autocompletion
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.1.9",
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
		cmd = { "Trouble" },
		opts = {},
		keys = {
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
			{ "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Document symbols" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP definitions / references" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
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
	-- {
	-- 	"tidalcycles/vim-tidal",
	-- 	lazy = false,
	-- },
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			terminal_cmd = "/home/axtr/.local/bin/claude", -- Point to local installation
		},
		config = true,
		keys = {
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude terminal" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus/toggle Claude terminal" },
			{
				"<leader>cs",
				"<cmd>ClaudeCodeSend<cr>",
				mode = { "n", "v" },
				desc = "Send selection to Claude",
			},
			{
				"<leader>ca",
				function()
					vim.cmd("ClaudeCodeAdd " .. vim.fn.expand("%:p"))
				end,
				desc = "Add current file to Claude context",
			},
			{ "<leader>cda", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
			{ "<leader>cdd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
		},
        lazy=false
	},
}
