return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = "markdown",
        keys = {
            { "<leader>cp", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Preview" },
        },
        config = function()
            vim.g.mkdp_auto_start = 1
        end,
    },
}
