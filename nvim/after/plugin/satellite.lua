require('satellite').setup {
    winblend = 50,
    handlers = {
        cursor = { enable = true },
        search = { enable = true, symbols = { '━', '━', '━' } },
        diagnostic = { enable = true },
        gitsigns = { enable = true },
        marks = { enable = true },
    },
}

-- Make the scrollbar handle visible against dark backgrounds
vim.api.nvim_set_hl(0, 'ScrollView', { bg = '#555555' })
