local wilder = require('wilder')
wilder.setup({
    modes = { ':', '/', '?' },
    next_key = '<C-n>',
    previous_key = '<C-p>',
})
wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline(),
        wilder.search_pipeline()
    ),
})
wilder.set_option('renderer', wilder.popupmenu_renderer({
    pumblend = 20,
    highlighter = wilder.basic_highlighter(),
    left = { ' ', wilder.popupmenu_devicons() },
    right = { ' ', wilder.popupmenu_scrollbar() },
}))
