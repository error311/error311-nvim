local function menu(cmd)
  vim.cmd(cmd)
end

-- avoid duplicates on reload
menu([[silent! aunmenu PopUp.Format\ Buffer]])
menu([[silent! aunmenu PopUp.Toggle\ Breakpoint]])
menu([[silent! aunmenu PopUp.-LocalActions-]])

menu([[amenu PopUp.-LocalActions- <Nop>]])
menu(
  [[amenu PopUp.Format\ Buffer<Tab><leader>f :lua require("conform").format({ async = true, lsp_format = "fallback" })<CR>]]
)
menu([[amenu PopUp.Toggle\ Breakpoint<Tab><leader>b :lua require("dap").toggle_breakpoint()<CR>]])
