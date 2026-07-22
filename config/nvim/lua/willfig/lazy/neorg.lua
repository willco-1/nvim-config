return {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.completion"] = {
                    config = { engine = "nvim-cmp" },
                },
            },
        })

        vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<CR>", { desc = "Notes index" })
        vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<CR>", { desc = "Return from neorg" })
    end,
}
