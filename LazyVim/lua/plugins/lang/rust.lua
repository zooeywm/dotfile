return {
    {
        "saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        tag = "v0.4.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = function()
            local crates = require("crates")
            return {
                { "<leader>ci", crates.show_crate_popup, ft = "toml", desc = "View Info" },
                { "<leader>cv", crates.show_versions_popup, ft = "toml", desc = "Select Version" },
                { "<leader>cf", crates.show_features_popup, ft = "toml", desc = "Select Feature" },
                { "<leader>ct", crates.extract_crate_into_table, ft = "toml", desc = "Extract To Table" },
            }
        end,
        opts = {
            popup = {
                autofocus = true,
                hide_on_select = true,
            },
        },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^3",
        ft = { "rust" },
        keys = {
            { "<leader>ce", "<cmd>RustLsp expandMacro<CR>", ft = "rust", desc = "Expand Macro" },
            { "<leader>cr", "<cmd>RustLsp runnables<CR>", ft = "rust", desc = "Run" },
            { "<leader>cg", "<cmd>RustLsp openCargo<CR>", ft = "rust", desc = "Open Cargo.toml" },
            { "gp", "<cmd>RustLsp parentModule<CR>", ft = "rust", desc = "Back to super mod" },
        },
        opts = {
            tools = {
                inlay_hints = {
                    only_current_line = true,
                },
            },
            server = {
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            local project_lspconfig = vim.g.project_lspconfig
            if project_lspconfig ~= nil and project_lspconfig.rust_analyzer ~= nil then
                opts.server = vim.tbl_deep_extend("force", opts.server, project_lspconfig.rust_analyzer)
            end
            opts.server.capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )
            vim.g.rustaceanvim = opts
        end,
    },
}
