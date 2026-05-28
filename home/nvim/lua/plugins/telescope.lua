return {
    'nvim-telescope/telescope.nvim', 
    dependencies = {'nvim-lua/plenary.nvim'},
    config = true,
    keys = {
        {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file"}
    }
}
