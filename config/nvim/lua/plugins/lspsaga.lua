return {
    'nvimdev/lspsaga.nvim',
    config = {

    },
    keys = {
        { 'K', '<cmd>Lspsaga hover_doc<CR>', desc = 'LSP Saga Hover Doc'},
    },
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
}
