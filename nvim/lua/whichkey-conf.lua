local wk = require("which-key")
wk.register({
    a = { ":Align=<cr>", "Align on equal"},
    t = { ":ToggleTerm size=16 dir=~/ direction=horizontal<cr>", "Toggle Terminal" },
    e = { ":NvimTreeToggle<cr>", "Toggle Tree"},
    d = { ":DiffviewOpen<cr>", "Open Git Diff"},
    c = {  
        name = "Comments",
        c = { ":CommentToggle<cr>", "(Un)Comment Line"}
    },
}, { prefix = "<space>" })

require("which-key").setup {
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
}
