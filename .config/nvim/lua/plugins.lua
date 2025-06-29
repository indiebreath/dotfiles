return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme catppuccin-mocha")
        end,
    },

    --[[{
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme carbonfox") end
    },]]
    --[[{
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme github_dark")
        end,
    },]]

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep", "sharkdp/fd" },
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            }

            require("telescope").load_extension("ui-select")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = { "lua", "python", "bash", "html", "javascript", "php", "markdown", "java" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500,
                },
            })

            vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", {})
        end,
    },

    --[[{
        "mikavilpas/yazi.nvim",
        keys = {
            {
                "<C-n>",
                mode = { "n", "v" },
                "<cmd>Yazi<cr>",
                desc = "Open yazi in current working directory",
            },
        },
    },]]

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                direction = "float",
                shade_terminals = false,
            })

            vim.keymap.set("n", "<Leader>h", ":ToggleTerm<CR>")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "dracula",
                },
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            registries = {
                "github:nvim-java/mason-registry",
                "github:mason-org/mason-registry",
            },
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            automatic_enable = true,
        },
        dependencies = {
            "mason-org/mason.nvim", "neovim/nvim-lspconfig"
        }
    },

    {
        "mfussenegger/nvim-jdtls"
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("lua_ls")

            vim.lsp.enable("pylsp")

            vim.lsp.enable("bashls")

            vim.lsp.enable("eslint")
            vim.lsp.config("eslint", {
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                    "vue",
                    "svelte",
                    "astro",
                    "ejs",
                },
            })

            vim.lsp.enable("emmet_language_server")
            vim.lsp.config("emmet_language_server", {
                filetypes = {
                    "css",
                    "eruby",
                    "html",
                    "htmldjango",
                    "javascriptreact",
                    "less",
                    "pug",
                    "sass",
                    "scss",
                    "typescriptreact",
                    "htmlangular",
                    "ejs",
                },
            })

            vim.lsp.enable("phpactor")

            vim.lsp.enable("rust_analyzser")

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set({ "n", "v" }, "<Leader>rn", vim.lsp.buf.rename, {})
        end,
    },

    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.phpcs,
                    null_ls.builtins.diagnostics.pylint.with({
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.code = diagnostic.message_id
                        end,
                    }),
                    null_ls.builtins.diagnostics.checkstyle.with({
                        extra_args = { "-c", "/google_checks.xml" },
                    }),
                    null_ls.builtins.diagnostics.semgrep,
                    null_ls.builtins.formatting.shfmt,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.pint,
                },
            })

            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        --[[config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),

                    ["<CR>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if luasnip.expandable() then
                                luasnip.expand()
                            else
                                cmp.confirm({
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,]]
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },

    --[[{
        "hrsh7th/cmp-nvim-lsp",
    },]]

    --[[{
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "folke/neodev.nvim",
            "nvim-neotest/nvim-nio",
            "ChristianChiarulli/neovim-codicons",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("dapui").setup()
            require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true },
            })
            require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

            vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<Leader>dc", dap.continue, {})

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },]]

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "echasnovski/mini.nvim",
        },
    },

    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end,
    },

    {
        "echasnovski/mini.nvim",
        version = "*",
        config = function()
            require("mini.pairs").setup()
            require("mini.surround").setup()
            require("mini.icons").setup()
        end,
    },

    {
        "nvimdev/dashboard-nvim",
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
        event = "VimEnter",
        config = function()
            require("dashboard").setup({
                theme = "hyper",
            })
        end,
    },

    --[[{
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" }
        },
        build = "make tiktoken",
        config = function ()
            require("CopilotChat").setup()
            vim.keymap.set("n", "<Leader>ch", ":CopilotChatOpen <cr>")
        end
    },]]

    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<Leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        },
    },

    {
        "onsails/lspkind.nvim"
    },

    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
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
            keymap = { preset = 'super-tab' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'normal'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = false },
                menu = {
                    draw = {
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = ctx.kind_icon
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    else
                                        icon = require("lspkind").symbolic(ctx.kind, {
                                            mode = "symbol",
                                        })
                                    end

                                    return icon .. ctx.icon_gap
                                end,

                                -- Optionally, use the highlight groups from nvim-web-devicons
                                -- You can also add the same function for `kind.highlight` if you want to
                                -- keep the highlight groups in sync with the icons.
                                highlight = function(ctx)
                                    local hl = ctx.kind_hl
                                    if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                        local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end
                                    return hl
                                end,
                            }
                        }
                    }
                }
            },
            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function()
            require("ibl").setup()
        end,
    },

    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_refresh_slow = 1
        end,
        ft = { "markdown" },
    },
}
