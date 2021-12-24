-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local wk = require("which-key")

wk.register({
    t = { ":ToggleTerm<cr>", "Toggle Terminal" }, -- open a term
    e = { ":NvimTreeToggle<cr>", "Toggle Tree" }, -- toggle tree
    d = { ":DiffviewOpen<cr>", "Open Git Diff" }, -- open a git diff view
    a = { ":Align=<cr>", "Align on equal" }, -- align elements on "="
    j = { "<C-W>j", "Go To Window Below" }, -- move to window below
    k = { "<C-W>k", "Go To Upper Window" }, -- move to window on top
    h = { "<C-W>h", "Go To Left Window" }, -- move to left window
    l = { "<C-W>l", "Go To Right Window" }, -- move to right window
    P = {
        name = "Packer",
        c = { ":PackerCompile<cr>", "Regenerate compiled loader file" }, -- Regenerate compiled loader file
        r = { ":PackerClean<cr>", "Remove any disabled or unused plugins" }, -- Remove any disabled or unused plugins
        i = { ":PackerInstall<cr>", "Clean, then install missing plugins" }, -- Clean, then install missing plugins
        u = { ":PackerUpdate<cr>", "Clean, then update and install plugins" }, -- Clean, then update and install plugins
        s = { ":PackerSync<cr>", "Perform `PackerUpdate` and then `PackerCompile`" }, -- Perform `PackerUpdate` and then `PackerCompile`
        l = { "echo 'eg. :PackerLoad completion-nvim ale'", "Loads opt plugin immediately" }, -- How to loads opt plugin immediately
    },
    T = {
        name = "TS",
        i = { ":TSModuleInfo<cr>", "List TS Modules" }, -- show installed TS Modules
    },
    L = {
        name = "LSP",
        i = { ":LspInfo<cr>", "Info on active LSP" }, -- show active LSP
    },
}, { prefix = "<space>" })

wk.register({
    t = { ":Telescope<cr>", "Telescope" }, -- open telescope
    s = {
        name = "Searches",
        f = { ":Telescope fd<cr>", "Find Files" }, -- find file - telescope feature
        g = { ":Telescope live_grep<cr>", "Grep" }, -- grep - telescope + ripgrep feature
    },
    f = { 
        name = "Files",
        b = { ":Telescope file_browser<cr>", "File Browser" }, -- browse file - telescope feature
        g = { ":Telescope git_files<cr>", "Git Files" }, -- see all files link to the repo - telescope feature
    },
    g = {
        name = "Git",
        c = { ":Telescope git_commits<cr>", "Git Commits" }, -- see all commits - telescope feature
        s = { ":Telescope git_status<cr>", "Git Status" }, -- see actual status - telescope feature
        b = { ":Telescope git_branches<cr>", "Git Branches" }, -- see all branches - telescope feature
    },
    d = {
        name = "Debug",
        t = { ":TroubleToggle<cr>", "Toggle Trouble" } -- toggle trouble console - trouble feature
    },
}, { prefix = "<TAB>" })

wk.register({
    t = { ":tabnew<cr>", "New Tab" }, -- open new tab
    n = { ":bnext<cr>", "Next Buffer" }, -- switch to next buffer
    b = { ":bprevious<cr>", "Previous Buffer" },  -- switch to previous buffer
    d = { ":bdelete<cr>", "Delete Current Buffer" }, -- delete current buffer
    s = { ":split<cr>", "Split Window Horizontaly" }, -- split the window horizontaly
    v = { ":vsplit<cr>", "Split Window Verticaly" }, -- split the window verticaly
    q = { ":quit<cr>", "Quit" }, -- quit window/vim
    M = { ":MarkdownPreviewToggle<cr>", "Preview Markdown File" }, -- call markdown preview
    c = {
        name = "CWD / Comments",
        d = { ":cd %:p:h<cr>:pwd<cr>", "Switch CWD to the directory of the open buffer" }, --
        c = { ":CommentToggle<cr>", "(Un)Comment Line" } -- comment/uncomment line
    },
    p = {
        name = "Yankstack",
        n = { "<Plug>yankstack_substitute_newer_paste", "Substitute with newer paste" }, -- substitute with newer paste
        p = { "<Plug>yankstack_substitute_older_paste", "Substitute with older paste" }, -- substitute with older paste
    },
}, { prefix = "<leader>" })
