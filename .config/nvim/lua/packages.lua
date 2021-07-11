return require('packer').startup(function (use)
    -- Package Manager
    use 'wbthomason/packer.nvim'

    -- Colors
    use 'fnune/base16-vim'
    use 'rktjmp/lush.nvim' -- TODO: Mess around with it

    -- Visual
    use 'folke/which-key.nvim'
    use 'tversteeg/registers.nvim'
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            vim.g.indent_blankline_char_list = {'|'} -- ┆
            vim.cmd('highlight IndentBlanklineChar guifg=#353535 gui=nocombine') -- TODO: Colorscheme
        end,
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = function ()
            require 'colorizer'.setup({
                css  = {css = true},
                html = {css = true},
            })
        end
    }
    use { 'junegunn/goyo.vim', requires = {{'junegunn/limelight.vim' }}} -- Zen Mode

    -- Misc
    use 'akinsho/nvim-toggleterm.lua' -- Terminal

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        config = function () require('gitsigns').setup() end,
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- General Text Editing
    use 'machakann/vim-sandwich'
    use 'tpope/vim-commentary'
    -- use 'jiangmiao/auto-pairs'
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
            require('nvim-autopairs.completion.compe').setup {
                map_cr = true, --  map <CR> on insert mode
                map_complete = true -- it will auto insert `(` after select function or method item
            }
        end
    }
    -- Language
    use 'Vimjas/vim-python-pep8-indent'
    use 'iamcco/markdown-preview.nvim' -- Markdown Live Preview
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = 'maintained',
                highlight = { enable = true }
            })
        end
    }
    use 'simrat39/rust-tools.nvim'
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use {
        'SirVer/ultisnips',
        config = function ()
            vim.g.UltiSnipsExpandTrigger = '<NUL>'
            vim.g.UltiSnipsJumpForwardTrigger = '<NUL>'
            vim.g.UltiSnipsJumpBackwardTrigger = '<NUL>'
        end,
        requires = {{'honza/vim-snippets'}}
    }
    use {
        'lervag/vimtex',
        config = function ()
            vim.g.tex_flavor='latex'
            vim.g.vimtex_view_method='zathura'
            vim.g.vimtex_quickfix_mode=0
        end,
    }

    -- Completion
    use {
        'hrsh7th/nvim-compe',
        config = function ()
            require'compe'.setup {
                enabled = true;
                source = {
                    path = true;
                    buffer = true;
                    calc = true;
                    nvim_lsp = true;
                    nvim_lua = true;
                    vsnip = false;
                    orgmode = true;
                    ultisnips = true;
                    luasnip = false;
                };
            }

        end
    }
    use 'ahmedkhalf/lsp-rooter.nvim'
    ---- Org Mode
    use {
        'kristijanhusak/orgmode.nvim',
        config = function()
            require('orgmode').setup{}
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = function ()
            require('telescope').setup({
                defaults = {
                    color_devicons = false,
                },
                extensions = {
                    project = {
                        base_dirs = {'~/main/src'},
                        max_depth = 4
                    },
                }
            })
            require('telescope').load_extension('project')
            require('telescope').load_extension('ultisnips')
        end,
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
            {'fhill2/telescope-ultisnips.nvim'},
            {'nvim-telescope/telescope-project.nvim'},
        }
    }
end)
