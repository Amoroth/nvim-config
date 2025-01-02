return {
    -- {
    --     "rose-pine/neovim",
    --     as = "rose-pine",
    --     config = function()
    --         require("rose-pine").setup({
    --             variant = "moon",
    --             dark_variant = "moon"
    --         })
	--     end
    -- },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    "tpope/vim-sensible",
    "tpope/vim-repeat",
    "tpope/vim-surround",
    {
        "ggandor/leap.nvim",
        config = function ()
            require('leap').create_default_mappings()
        end

    },
    "nvim-lua/plenary.nvim",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
--	{
--		"nvim-tree/nvim-tree.lua",
--		lazy = false,
--		dependencies = { "nvim-tree/nvim-web-devicons" },
--		config = function()
--			require("nvim-tree").setup {}
--		end,
--	},
	{
		"L3MON4D3/LuaSnip",
                version = "v2.*",
		build = "make install_jsregexp",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require('cmp')

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-Space>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    })
                }),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}, {
					{ name = 'buffer' },
				})
			})

			-- Set configuration for specific filetype
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'git' },
				}, {
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for '/' and '?'
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' },
				}
			})

			-- Use cmdline & path source for ':'
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' },
				}, {
					{ name = 'cmdline' }
				})
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				height = 0.8,
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_installation = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local lsp = require 'lspconfig'

            if vim.fn.executable('php') == 1 then
    			lsp.intelephense.setup({
	    			capabilities = capabilities
		    	})
            end

			lsp.ts_ls.setup({})
            lsp.basedpyright.setup({})

            if vim.fn.executable('go') == 1 then
                lsp.gopls.setup({})
            end

            if vim.fn.executable('opam') == 1 then
                lsp.ocamllsp.setup({})
            end
		end
	},
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile"
        },
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    }
}
