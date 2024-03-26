------------------
-- Mini Starter --
------------------
local starter = require('mini.starter')
starter.setup({
    evaluate_single = true,
    items = {
        starter.sections.telescope(),
        starter.sections.recent_files(10, true),
        starter.sections.builtin_actions(),
    },
    content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
    },
})

