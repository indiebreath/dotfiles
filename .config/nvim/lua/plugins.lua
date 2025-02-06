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
        tag = "0.1.8",
        required = { { "nvim-lua/plenary.nvim" } },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            require("telescope").load_extension("ui-select")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = { "lua", "python", "bash", "html", "javascript", "php", "markdown" },
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

            vim.keymap.set("n", "<Leader>h", ":ToggleTerm <cr>")
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
        "mfussenegger/nvim-jdtls",
        dependencies = { "mfussenegger/nvim-dap"}
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
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pylsp",
                    "bashls",
                    "eslint",
                    "emmet_language_server",
                    "phpactor",
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.pylsp.setup({
                capabilities = capabilities,
            })
            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
            lspconfig.eslint.setup({
                capabilities = capabilities,
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
            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
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
            lspconfig.phpactor.setup({
                capabilities = capabilities,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
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
                    null_ls.builtins.diagnostics.stylelint,
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
        config = function()
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
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },

    {
        "hrsh7th/cmp-nvim-lsp",
    },

    {
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

            dap.configurations.cpp = {
                type = "executable",
                command = "/usr/bin/lldb",
                name = "lldb",
            }
            dap.configurations.c = dap.configurations.cpp

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
    },

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
}
