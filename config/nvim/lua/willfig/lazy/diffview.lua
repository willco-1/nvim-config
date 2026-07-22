return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diff view" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",  desc = "File history" },
        { "<leader>gx", "<cmd>DiffviewClose<cr>",          desc = "Close diff view" },
    },
}
