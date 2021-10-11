-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local wk = require("which-key")

wk.register({
    t = { ":ToggleTerm size=16 dir=~/ direction=horizontal<cr>", "Toggle Terminal" },
    e = { ":NvimTreeToggle<cr>", "Toggle Tree"},
    d = { ":DiffviewOpen<cr>", "Open Git Diff"},
    a = { ":Align=<cr>", "Align on equal"},
    j = { "<C-W>j", "Go To Window Below"},
    k = { "<C-W>k", "Go To Upper Window"},
    h = { "<C-W>h", "Go To Left Window"},
    l = { "<C-W>l", "Go To Right Window"},
}, { prefix = "<space>" })

wk.register({
    t = { ":Telescope", "Telescope" },
}, { prefix = "<TAB>" })

wk.register({
    t = { ":tabnew<cr>", "New Tab"},
    n = { ":bnext<cr>", "Next Buffer"},
    b = { ":bprevious<cr>", "Previous Buffer"},
    d = { ":bdelete<cr>", "Delete Current Buffer"},
    s = { ":split<cr>", "Split Window Horizontaly"},
    v = { ":vsplit<cr>", "Split Window Verticaly"},
    q = { ":bdelete<cr>", "Delete Current Buffer"},
    c = {
        name = "CWD / Comments",
        d = { ":cd %:p:h<cr>:pwd<cr>", "Switch CWD to the directory of the open buffer" },
        c = { ":CommentToggle<cr>", "(Un)Comment Line"}
    },
    p = {
        name = "Yankstack",
        n = { "<Plug>yankstack_substitute_newer_paste", "Substitute with newer paste"},
        p = { "<Plug>yankstack_substitute_older_paste", "Substitute with older paste"},
    },
}, { prefix = "<leader>" })
