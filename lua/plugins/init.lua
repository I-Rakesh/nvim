return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Color Scheme's
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "navarasu/onedark.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },

	--Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	"nvim-treesitter/nvim-treesitter-refactor",

	-- Harpoon
	"ThePrimeagen/harpoon",

	--Lsp config
	------------------
	--Package manager
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"neovim/nvim-lspconfig",

	--Auto Complete
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"f3fora/cmp-spell",
	"saadparwaiz1/cmp_luasnip",
	"onsails/lspkind.nvim",

	-- Snippets
	"rafamadriz/friendly-snippets",
	"L3MON4D3/LuaSnip",

	--Formatting
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
	},
	-------------------

	-- Tabbing
	"abecodes/tabout.nvim",

	--Code runner
	{ "CRAG666/code_runner.nvim", config = true },

	--oil nvim
	"stevearc/oil.nvim",

	-- Repeat (.)
	"tpope/vim-repeat",

	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- nvim-tree
	"nvim-tree/nvim-tree.lua",

	--Cmd auto complete
	{
		"gelguy/wilder.nvim",
		config = function() end,
	},

	-- nvim-tree
	"nvim-tree/nvim-tree.lua",

	--Notification ui
	"rcarriga/nvim-notify",

	--Git Integration
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	"tpope/vim-fugitive",

	--Autopair braces
	{
		"windwp/nvim-autopairs",
		event = { "InsertEnter" },
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	--Surround
	{
		"tpope/vim-surround",
		event = { "BufReadPre", "BufNewFile" },
	},

	-- tmux navigator
	"christoomey/vim-tmux-navigator",

	--indent lines
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	--Terminal
	"akinsho/toggleterm.nvim",

	--Commenting lines
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		event = { "BufReadPre", "BufNewFile" },
	},

	-- Dressing for better input
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
