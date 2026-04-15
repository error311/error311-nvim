local function menu(cmd)
  vim.cmd(cmd)
end

-- avoid duplicates on reload
menu([[silent! aunmenu PopUp.Undo]])
menu([[silent! aunmenu PopUp.Redo]])
menu([[silent! aunmenu PopUp.Format\ Buffer]])
menu([[silent! aunmenu PopUp.Toggle\ Breakpoint]])
menu([[silent! aunmenu PopUp.-LocalActions-]])

-- remove the built-in mouse help item + its separator
menu([[silent! aunmenu PopUp.How-to\ disable\ mouse]])
menu([[silent! aunmenu PopUp.-2-]])

menu([[amenu PopUp.-LocalActions- <Nop>]])

menu([[nnoremenu PopUp.Undo<Tab>u <Cmd>undo<CR>]])
menu([[inoremenu PopUp.Undo<Tab>u <C-O>:undo<CR>]])
menu([[vnoremenu PopUp.Undo<Tab>u <Esc>u]])

menu([[nnoremenu PopUp.Redo<Tab><C-r> <Cmd>redo<CR>]])
menu([[inoremenu PopUp.Redo<Tab><C-r> <C-O>:redo<CR>]])
menu([[vnoremenu PopUp.Redo<Tab><C-r> <Esc><C-r>]])

menu(
  [[amenu PopUp.Format\ Buffer<Tab><leader>f <Cmd>lua require("conform").format({ async = true, lsp_format = "fallback" })<CR>]]
)
menu([[amenu PopUp.Toggle\ Breakpoint<Tab><leader>b <Cmd>lua require("dap").toggle_breakpoint()<CR>]])
