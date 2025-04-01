-----------------------------------
-- Maintainer: Valentin Marlier  --
-----------------------------------
local wk = require("which-key")

-- Keybindings for Normal Mode with "<space>" for prefix
wk.add({
  { "<space>e", ":NvimTreeToggle<cr>",          desc = "File Tree" },
  { "<space>h", "<C-W>h",                       desc = "Go To Left Window" },
  { "<space>j", "<C-W>j",                       desc = "Go To Window Below" },
  { "<space>k", "<C-W>k",                       desc = "Go To Upper Window" },
  { "<space>l", "<C-W>l",                       desc = "Go To Right Window" },
  { "<space>p", require('toolbox').show_picker, desc = "Show toolbox picker" }, -- replace by custom snacks picker source
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
  { "<TAB>p",   ":lua Snacks.picker()<cr>",                                desc = "Toggle picker" },
  { "<TAB>z",   ":lua Snacks.zen()<cr>",                                   desc = "Toggle zen mode" },
  { "<TAB>b",   ":lua Snacks.picker.buffers()<cr>",                        desc = "Buffer Picker" },
  { "<TAB>g",   group = "Git" },
  { "<TAB>gf",  ":Git<cr>",                                                desc = "Vim Fugitive" },
  { "<TAB>gb",  ":lua Snacks.gitbrowse()<cr>",                             desc = "Open Selection in browser" },
  { "<TAB>gl",  ":lua Snacks.lazygit()<cr>",                               desc = "Open Lazygit" },
  { "<TAB>t",   ":lua require('snacks').terminal.toggle()<cr>",            desc = "Toggle terminal" },
  { "<TAB>M",   ":Mason<cr>",                                              desc = "Open Mason package manager" },
  { "<TAB>P",   ":Lazy<cr>",                                               desc = "Open Lazy plugin manager" },
})

-- Keybindings for Normal Mode with "<leader>" for prefix
wk.add({
  { "<leader><space>",  group = "Buffer/Tab Management" },
  { "<leader><space>c", ":lua Snacks.bufdelete.all()<cr>",    desc = "Delete All Buffers" },
  { "<leader><space>d", ":lua Snacks.bufdelete()<cr>",        desc = "Delete Current Buffer" },
  { "<leader><space>o", ":lua Snacks.bufdelete.other()<cr>",  desc = "Delete Other Buffers" },
  { "<leader><space>q", ":tabclose<cr>",                      desc = "Close Tab" },
  { "<leader><space>t", ":tabnew<cr>",                        desc = "New Tab" },
  { "<leader>k",        ":tabprevious<cr>",                   desc = "Previous Tab" },
  { "<leader>l",        ":tabnext<cr>",                       desc = "Next Tab" },
  { "<leader>n",        ":bnext<cr>",                         desc = "Next Buffer" },
  { "<leader>b",        ":bprevious<cr>",                     desc = "Previous Buffer" },
  { "<leader>s",        group = "Horizontal Split Management" },
  { "<leader>sj",       ":horizontal resize -5<cr>",          desc = "Resize -5" },
  { "<leader>sk",       ":horizontal resize +5<cr>",          desc = "Resize +5" },
  { "<leader>ss",       ":split<cr>",                         desc = "Split Window Horizontally" },
  { "<leader>v",        group = "Vertical Split Management" },
  { "<leader>vh",       ":vertical resize -5<cr>",            desc = "Resize -5" },
  { "<leader>vl",       ":vertical resize +5<cr>",            desc = "Resize +5" },
  { "<leader>vv",       ":vsplit<cr>",                        desc = "Split Window Verticaly" },
})


-- Keybindings for Normal Mode with "<leader>" for prefix
wk.add({
  { "<C-j>", "<C-d>", desc = "Smooth scroll down" },
  { "<C-k>", "<C-u>", desc = "Smooth scroll up" },
})

-- Keybindings for Normal Mode
wk.add({
  { "zM", require('ufo').closeAllFolds, desc = "Close all folds" },
  { "zR", require('ufo').openAllFolds,  desc = "Open all folds" },
  { "U",  "<C-r>",                      desc = "redo" },
})

-- Keybindings for Visual modes with "<TAB>" for prefix
wk.add({
  {
    mode = { "v" },
    { "<TAB>c",  group = "Copilot" },
    { "<TAB>cD", ":CopilotChatDocs<cr>",        desc = "Write documentation for the selected code" },
    { "<TAB>cE", ":CopilotChatExplain<cr>",     desc = "Explain how it works" },
    { "<TAB>cO", ":CopilotChatOptimize<cr>",    desc = "Optimize the selected code to improve performance and readablilty" },
    { "<TAB>cT", ":CopilotChatTests<cr>",       desc = "Briefly explain how selected code works then generate unit tests" },
    { "<TAB>g",  ":lua Snacks.gitbrowse()<cr>", desc = "Open Selection in browser" },
  },
})

wk.add({
  {
    mode = { "v" },
    { "<leader>m", ":MCstart<cr>", desc = 'Create a selection for selected text or word under the cursor' },
  }
})
