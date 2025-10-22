--[ Lua ]-------------------------------------------------------
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                },
            },
        },
    },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
})
vim.lsp.enable("lua_ls")

--[ GO ]---------------------------------------------------------
vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.mod", "go.work", ".git" },
    settings = {
        gopls = {
            gofumpt = true,
            codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = {
                "-.git",
                "-.vscode",
                "-.idea",
                "-.vscode-test",
                "-node_modules",
            },
        },
    },
})
vim.lsp.enable("gopls")

--[ Python ]-----------------------------------------------------
vim.lsp.config("basedpyright", {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { "python" },
    settings = {
        basedpyright = {
            analysis = {
                diagnosticMode = "openFilesOnly",
                extraPaths = { "third_party" },
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                diagnosticSeverityOverrides = {
                    reportUnannotatedClassAttribute = false,
                    reportUnusedCallResult = false,
                },
            },
        },
    },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
    },
})
vim.lsp.enable("basedpyright")

--[ Terraform ]-------------------------------------------------
vim.lsp.config("terraformls", {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
})
vim.lsp.enable("terraformls")

--[ YAML ]------------------------------------------------------
vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    settings = {
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
    },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
})
vim.lsp.enable("yamlls")

--[ JSON ]----------------------------------------------------
vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    root_markers = {
        ".git",
    },
})
vim.lsp.enable("jsonls")

--[ HTML ]----------------------------------------------------
vim.lsp.config("html", {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "templ" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
    root_markers = {
        ".git",
    },
})
vim.lsp.enable("html")

--[ CSS ]----------------------------------------------------
vim.lsp.config("cssls", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_markers = { "package.json", ".git" },
})
vim.lsp.enable("cssls")


--[ TypeScript ]------------------------------------------------------
vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
})
vim.lsp.enable("ts_ls")


--[ Docker ]----------------------------------------------------------
vim.lsp.config("dockerls", {
    cmd = { 'docker-langserver', '--stdio' },
    filetypes = { 'dockerfile' },
    root_markers = { 'Dockerfile' },
})
vim.lsp.enable("dockerls")

--[ Bash ]------------------------------------------------------------
vim.lsp.config("bashls", {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
    settings = {
        bashIde = {
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
        },
    },
})
vim.lsp.enable("bashls")

--[ Customizing how diagnostics are displayed ]-----------------------

vim.diagnostic.config {
    virtual_text = false,
    signs = false,
    underline = true,
    update_in_insert = false,
    float = {
        -- UI.
        header = false,
        border = "rounded",
    }
}
