-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local wk = require("which-key")

-- Keybindings for Normal Mode with "<space>" for prefix
wk.add({
  { "<space>M",  ":Mason<cr>",                    desc = "Open Mason package manager" },
  { "<space>P",  ":Lazy<cr>",                     desc = "Open Lazy plugin manager" },
  { "<space>e",  ":NvimTreeToggle<cr>",           desc = "File Tree" },
  { "<space>h",  "<C-W>h",                        desc = "Go To Left Window" },
  { "<space>j",  "<C-W>j",                        desc = "Go To Window Below" },
  { "<space>k",  "<C-W>k",                        desc = "Go To Upper Window" },
  { "<space>l",  "<C-W>l",                        desc = "Go To Right Window" },
  { "<space>p",  require('toolbox').show_picker,  desc = "Show toolbox picker" },
  { "<space>t",  group = "Terminal" },
  { "<space>tb", ":ToggleTerm direction=tab<cr>", desc = "Open terminal tab" },
  { "<space>G",  ":Git<cr>",                      desc = "Vim Fugitive" },
  { "<space>g",  group = "Other Git Actions" },
  { "<space>gf", ":GitBlameOpenFileURL<cr>",      desc = "Open file in browser" },
  { "<space>gu", ":GitBlameOpenCommitUrl<cr>",    desc = "Open Commit in browser" },
})

-- Keybindings for Normal Mode with "<TAB>" for prefix
wk.add({
  { "<TAB>c",   group = "Copilot" },
  { "<TAB>cC",  ":CopilotChatCommit<cr>",                                  desc = "Write commit message for the change with commitizen convention" },
  { "<TAB>ct",  ":CopilotChatToggle<cr>",                                  desc = "Toggle Copilot Chat" },
  { "<TAB>l",   group = "LSP" },
  { "<TAB>li",  ":Trouble lsp_incoming_calls toggle focus=true<cr>",       desc = "Incoming calls" },
  { "<TAB>ll",  ":Trouble lsp toggle focus=true<cr>",                      desc = "Definitions & References" },
  { "<TAB>lo",  ":Trouble lsp_outgoing_calls toggle focus=true<cr>",       desc = "Outgoing calls" },
  { "<TAB>lt",  ":Trouble lsp_type_definitions toggle focus=true<cr>",     desc = "Type definitions" },
  { "<TAB>lD",  group = "Diagnostics" },
  { "<TAB>lDd", ":Trouble diagnostics toggle filter.buf=0 focus=true<cr>", desc = "Buffer diagnostic" },
  { "<TAB>lDp", ":Trouble diagnostics toggle focus=true<cr>",              desc = "Project Diagnostic" },
  { "<TAB>s",   require("namu.namu_symbols").show,                         desc = "Symbols picker" },
  { "<TAB>p",   ":lua Snacks.picker()<cr>",                                desc = "Toggle picker" }
})

-- Keybindings for Normal Mode with "<leader>" for prefix
wk.add({
  { "<leader><space>",  group = "Buffer/Tab Management" },
  { "<leader><space>c", ":BufDelAll<cr>",                     desc = "Delete All Buffers" },
  { "<leader><space>d", ":BufDel!<cr>",                       desc = "Delete Current Buffer" },
  { "<leader><space>o", ":BufDelOthers<cr>",                  desc = "Delete Other Buffers" },
  { "<leader><space>q", ":tabclose<cr>",                      desc = "Close Tab" },
  { "<leader><space>t", ":tabnew<cr>",                        desc = "New Tab" },
  { "<leader>b",        ":bprevious<cr>",                     desc = "Previous Buffer" },
  { "<leader>k",        ":tabprevious<cr>",                   desc = "Previous Tab" },
  { "<leader>l",        ":tabnext<cr>",                       desc = "Next Tab" },
  { "<leader>n",        ":bnext<cr>",                         desc = "Next Buffer" },
  { "<leader>s",        group = "Horizontal Split Management" },
  { "<leader>sj",       ":horizontal resize -5<cr>",          desc = "Resize -5" },
  { "<leader>sk",       ":horizontal resize +5<cr>",          desc = "Resize +5" },
  { "<leader>ss",       ":split<cr>",                         desc = "Split Window Horizontally" },
  { "<leader>v",        group = "Vertical Split Management" },
  { "<leader>vh",       ":vertical resize -5<cr>",            desc = "Resize -5" },
  { "<leader>vl",       ":vertical resize +5<cr>",            desc = "Resize +5" },
  { "<leader>vv",       ":vsplit<cr>",                        desc = "Split Window Verticaly" },
  { "<leader>m",        ":MCstart<cr>",                       desc = 'Create a selection for selected text or word under the cursor' }
})

-- Keybindings for Normal Mode with "z" for prefix -- Mostly folding aptitude
wk.add({
  { "zM", require('ufo').closeAllFolds, desc = "Close all folds" },
  { "zR", require('ufo').openAllFolds,  desc = "Open all folds" },
})

-- Keybindings for Visual modes with "<TAB>" for prefix
wk.add({
  {
    mode = { "v" },
    { "<TAB>c",  group = "Copilot" },
    { "<TAB>cD", ":CopilotChatDocs<cr>",     desc = "Write documentation for the selected code" },
    { "<TAB>cE", ":CopilotChatExplain<cr>",  desc = "Explain how it works" },
    { "<TAB>cO", ":CopilotChatOptimize<cr>", desc = "Optimize the selected code to improve performance and readablilty" },
    { "<TAB>cT", ":CopilotChatTests<cr>",    desc = "Briefly explain how selected code works then generate unit tests" },
    { "<TAB>g",  ":GitBlameOpenFileURL<cr>", desc = "Open Selection in browser" },
  },
})

wk.add({
  {
    mode = { "v" },
    { "<leader>m", ":MCstart<cr>", desc = 'Create a selection for selected text or word under the cursor' },
  }
})
