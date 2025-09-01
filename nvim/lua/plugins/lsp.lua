local mason_lspconfig = require("mason-lspconfig")

require("lspconfig").clangd.setup({
    format = {
        Enable = true,
        IndentWidth = 4,
        TabWidth = 4,
    },
})
require("lspconfig").lua_ls.setup({
    Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = {
            globals = { "vim" },
        },
    },
})

require("lspconfig").postgres_lsp.setup({})
require("lspconfig").csharp_ls.setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
    capabilities = capabilities
})

local servers = { "lua_ls", "pyright", "clangd", "ts_ls", "tailwindcss", "emmet_ls", "cssls", "gopls", "csharp_ls" }

mason_lspconfig.setup({
    automatic_enable = servers,
    ensure_installed = servers,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("sdhrt-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        map("<leader>rr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("<leader>ri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        map("<leader>h", vim.lsp.buf.hover, "[H]over")

        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
            if vim.fn.has("nvim-0.11") == 1 then
                return client:supports_method(method, bufnr)
            else
                return client.supports_method(method, { bufnr = bufnr })
            end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
            local highlight_augroup = vim.api.nvim_create_augroup("sdhrt-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("sdhrt-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "sdhrt-lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})
