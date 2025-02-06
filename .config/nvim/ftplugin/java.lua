local home = os.getenv('HOME')
local jdtls = require('jdtls')
--local dap = require("dap")

-- File types that signify a Java project's root directory. This will be
-- used by eclipse to determine what constitutes a workspace
local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)

-- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- with multiple different projects, each project must use a dedicated data directory.
-- This variable is used to configure eclipse to use the directory name of the
-- current project found using the root_marker as the folder for project specific data.
local workspace_folder = "/home/indiebreath/Documents/Software/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Helper function for creating keymaps
function nnoremap(rhs, lhs, bufopts, desc)
    --bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach function is used to set key maps after the language server
-- attaches to the current buffer
local on_attach = function(client, bufnr)
    --jdtls.setup_dap({ hotcodereplace = 'auto' })
    --jdtls.setup.add_commands()

    -- Regular Neovim LSP client keymappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    nnoremap('<Leader>tD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
    nnoremap('<Leader>td', vim.lsp.buf.definition, bufopts, "Go to definition")
    nnoremap('<Leader>ti', vim.lsp.buf.implementation, bufopts, "Go to implementation")
    nnoremap('<Leader>tk', vim.lsp.buf.hover, bufopts, "Hover text")
    --nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
    nnoremap('<Leader>twa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
    nnoremap('<Leader>twr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
    nnoremap('<Leader>twl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts, "List workspace folders")
    --nnoremap('<Leader>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
    nnoremap('<Leader>tn', vim.lsp.buf.rename, bufopts, "Rename")
    nnoremap('<Leader>ta', vim.lsp.buf.code_action, bufopts, "Code actions")
    --[[vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
        { noremap = true, silent = true, buffer = bufnr, desc = "Code actions" })]]
    nnoremap('<Leader>tf', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")

    -- Java extensions provided by jdtls
    nnoremap("<Leader>ta", jdtls.organize_imports, bufopts, "Organize imports")
    nnoremap("<Leader>tv", jdtls.extract_variable, bufopts, "Extract variable")
    nnoremap("<Leader>tc", jdtls.extract_constant, bufopts, "Extract constant")
    --[[vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>,
        { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })]]

    -- nvim-dap
    --[[noremap("<C-b>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Set breakpoint")
    nnoremap("<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
        "Set conditional breakpoint")
    nnoremap("<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
        "Set log point")
    nnoremap('<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints")
    nnoremap('<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', "List breakpoints")

    nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
    nnoremap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
    nnoremap("<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
    nnoremap("<leader>do", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
    nnoremap('<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect")
    nnoremap('<leader>dt', "<cmd>lua require'dap'.terminate()<cr>", "Terminate")
    nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Open REPL")
    nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Run last")
    nnoremap('<leader>di', function() require "dap.ui.widgets".hover() end, "Variables")
    nnoremap('<leader>d?', function()
        local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
    end, "Scopes")
    nnoremap('<leader>df', '<cmd>Telescope dap frames<cr>', "List frames")
    nnoremap('<leader>dh', '<cmd>Telescope dap commands<cr>', "List commands")]]
end

--[[local bundles = {
    vim.fn.glob(
        "/home/indiebreath/java/java-debug/com.microsoft.java.debug.repository/target/repository/plugins/com.microsoft.java.debug.plugin_0.53.1.jar")
}]]

local config = {
    flags = {
        debounce_text_changes = 80,
    },
    on_attach = on_attach, -- We pass our on_attach keybindings to the configuration map
    --[[init_options = {
        bundles = bundles
    },]]
    root_dir = root_dir, -- Set the root directory to our found root_marker
    -- Here you can configure eclipse.jdt.ls specific settings
    -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            format = {
                settings = {
                    -- Use Google Java style guidelines for formatting
                    -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
                    -- and place it in the ~/.local/share/eclipse directory
                    url =
                    "~/java/eclipse.jdt.ls/org.eclipse.jdt.ls.tests/formatter resources/eclipse-java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
            -- Specify any completion options
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*", "sun.*",
                },
            },
            -- Specify any options for organizing imports
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            -- How code generation should act
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            },
            -- If you are developing in projects with different Java versions, you need
            -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-23",
                        path = "/usr/lib/jvm/java-23-openjdk"
                    },
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk"
                    },
                }
            }
        }
    },
    -- cmd is the command that starts the language server. Whatever is placed
    -- here is what is passed to the command line to execute jdtls.
    -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    -- for the full list of options
    cmd = {
        'java', -- or '/path/to/java21_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '--add-opens', 'jdk.incubator.vector/jdk.incubator.vector=ALL-UNNAMED',
        '--add-exports', 'jdk.incubator.vector/jdk.incubator.vector=ALL-UNNAMED',
        -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
        -- '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',

        -- The jar file is located where jdtls was installed. This will need to be updated
        '-jar',
        '/home/indiebreath/java/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.1000.v20250131-0606.jar',

        -- The configuration for jdtls is also placed where jdtls was installed. This will
        -- need to be updated depending on your environment
        '-configuration',
        '/home/indiebreath/java/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux',

        -- Use the workspace_folder defined above to store data for this project
        '-data', workspace_folder,
    },
}

-- Finally, start jdtls. This will run the language server using the configuration we specified,
-- setup the keymappings, and attach the LSP client to the current buffer
jdtls.start_or_attach(config)
