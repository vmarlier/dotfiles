-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local wk = require("which-key")

-- Keybindings for Normal Mode with "<space>" for prefix
wk.register({
  b = { ":Telescope file_browser<cr>", "File Browser" },
  d = { ":Dashboard<cr>", "Dashboard" },
  e = { ":NvimTreeToggle<cr>", "File Tree" },
  h = { "<C-W>h", "Go To Left Window" },
  j = { "<C-W>j", "Go To Window Below" },
  k = { "<C-W>k", "Go To Upper Window" },
  l = { "<C-W>l", "Go To Right Window" },
  m = { ":messages<cr>", "Show neovim logs output" },
  t = { 
    name = "Terminal",
    t = { ":ToggleTerm direction=horizontal<cr>", "Toggle horizontally" },
    f = { ":ToggleTerm direction=tab<cr>", "Toggle tab" },
  },
  G = { "<cmd>lua _lazygit_toggle()<CR>", "Open LazyGit" },
  L = { ":LspInfo<cr>", "Info on active LSP" },
  M = { ":Mason<cr>", "Open Mason package manager" },
  P = { ":Lazy<cr>", "Open Lazy plugin manager" },
  T = { ":TSModuleInfo<cr>", "List TS Modules" },
}, { prefix = "<space>" })

-- Keybindings for Normal Mode with "<TAB>" for prefix
wk.register({
  b = { ":Telescope buffers<cr>", "Open Buffer Navigator" },
  c = {
    name = "Copilot",
    e = { ":Copilot enable<cr>", "Copilot Enable" },
    d = { ":Copilot disable<cr>", "Copilot Disable" },
    t = { ":CopilotChatToggle<cr>", "Toggle Copilot Chat" },
    E = { ":CopilotChatExplain<cr>", "Explain how it works" },
    T = { ":CopilotChatTests<cr>", "Briefly explain how selected code works then generate unit tests" },
    F = { ":CopilotChatFix<cr>", "There is a problem in this code. Rewrite the code to show it with the bug fixed" },
    O = { ":CopilotChatOptimize<cr>", "Optimize the selected code to improve performance and readablilty" },
    D = { ":CopilotChatDocs<cr>", "Write documentation for the selected code" },
    C = { ":CopilotChatCommit<cr>", "Write commit message for the change with commitizen convention" },
  },
  f = {
    name = "Searches",
    f = { ":Telescope find_files<cr>", "Find Files" },
    l = { ":lua require(\"telescope\").extensions.live_grep_args.live_grep_args()<cr>", "Grep" },
    g = { ":Telescope git_files<cr>", "Git Files" },
  },
  g = {
    name = "Git",
    c = { ":Telescope git_commits<cr>", "Git Commits" },
    s = { ":Telescope git_status<cr>", "Git Status" },
    b = { ":Telescope git_branches<cr>", "Git Branches" },
    u = { ":GitBlameOpenCommitUrl<cr>", "Open Commit Url" },
    f = { ":GitBlameOpenFileUrl<cr>", "Open File Url" },
    d = { ":DiffviewOpen<cr>", "Git Diff" },
  },
  l = {
    name = "LSP",
    l = { ":Trouble lsp toggle focus=true<cr>", "Definitions & References" },
    s = { ":Trouble lsp_document_symbols win.position=right focus=false<cr>", "Symbols" },
    i = { ":Trouble lsp_incoming_calls toggle focus=true<cr>", "Incoming calls" },
    o = { ":Trouble lsp_outgoing_calls toggle focus=true<cr>", "Outgoing calls" },
    t = { ":Trouble lsp_type_definitions toggle focus=true<cr>", "Type definitions" },
    D = {
      name = "Diagnostics",
      p = { ":Trouble diagnostics toggle focus=true<cr>", "Project Diagnostic" },
      d = { ":Trouble diagnostics toggle filter.buf=0 focus=true<cr>", "Buffer diagnostic" },
    },
  },
  n = { ":noh<cr>", "Disable search highlights" },
  p = { ":Telescope neoclip<cr>", "Open NVim Clipboard" },
  r = { ":set invrelativenumber<cr>", "Relative Numbering On/Off" },
  t = { ":Telescope<cr>", "Telescope" },
  R = { ":lua generate_readme()<cr>", "Generate Nvim Configuration Readme" },
}, { prefix = "<TAB>" })

-- Keybindings for Normal Mode with "<leader>" for prefix
wk.register({
  b = {
    name = "Buffer Management",
    d = { ":BufDel!<cr>", "Delete Current Buffer" },
    c = { ":BufDelAll<cr>", "Delete All Buffers" },
  },
  C = {
    name = "cwd",
    d = { ":cd %:p:h<cr>:pwd<cr>", "switch cwd to the directory of the open buffer" },
  },
  n = { ":bnext<cr>", "Next Buffer" },
  p = { ":bprevious<cr>", "Previous Buffer" },
  q = { ":quit<cr>", "Quit" },
  s = {
    name = "Horizontal Split Management",
    s = { ":split<cr>", "Split Window Horizontally" },
    j = { ":horizontal resize -5<cr>", "Resize -5" },
    k = { ":horizontal resize +5<cr>", "Resize +5" },
  },
  t = {
    name = "Tab Management",
    t = { ":tabnew<cr>", "New Tab" },
    n = { ":tabnext<cr>", "Next Tab" },
    p = { ":tabprevious<cr>", "Previous Tab" },
    c = { ":tabclose<cr>", "Close Tab" }
  },
  v = {
    name = "Vertical Split Management",
    v = { ":vsplit<cr>", "Split Window Verticaly" },
    h = { ":vertical resize -5<cr>", "Resize -5" },
    l = { ":vertical resize +5<cr>", "Resize +5" },
  },
  w = {
    name = "Trailspace",
    w = { ":lua require('mini.trailspace').trim()<cr>", "Trim trailing whitespaces" },
    l = { ":lua require('mini.trailspace').trim_last_lines()<cr>", "Trim trailing empty lines" },
  },
  M = { ":MarkdownPreviewToggle<cr>", "Preview Markdown File" },
}, { prefix = "<leader>" })


-- Keybindings for Normal Mode with "z" for prefix -- Mostly folding aptitude
wk.register({
  R = { require('ufo').openAllFolds, "Open all folds" },
  M = { require('ufo').closeAllFolds, "Close all folds" },
}, { prefix = "z" })


-- Keybindings for Visual modes with "<TAB>" for prefix
wk.register({
  c = {
    name = "Copilot",
    E = { ":CopilotChatExplain<cr>", "Explain how it works" },
    T = { ":CopilotChatTests<cr>", "Briefly explain how selected code works then generate unit tests" },
    F = { ":CopilotChatFix<cr>", "There is a problem in this code. Rewrite the code to show it with the bug fixed" },
    O = { ":CopilotChatOptimize<cr>", "Optimize the selected code to improve performance and readablilty" },
    D = { ":CopilotChatDocs<cr>", "Write documentation for the selected code" },
    C = { ":CopilotChatCommit<cr>", "Write commit message for the change with commitizen convention" },
  },
}, { prefix = "<TAB>", mode = "v" })
