local function neo_tree_feed(keys)
  local k = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(k, 'm', false)
end

_G.error311_neotree_menu_action = function(keys)
  vim.schedule(function()
    neo_tree_feed(keys)
  end)
end

local function focus_mouse_node()
  local mp = vim.fn.getmousepos()
  if not mp or mp.winid == 0 or mp.line <= 0 then
    return false
  end

  if not vim.api.nvim_win_is_valid(mp.winid) then
    return false
  end

  vim.api.nvim_set_current_win(mp.winid)

  local ok, buf = pcall(vim.api.nvim_win_get_buf, mp.winid)
  if not ok or vim.bo[buf].filetype ~= 'neo-tree' then
    return false
  end

  pcall(vim.api.nvim_win_set_cursor, mp.winid, { mp.line, 0 })
  return true
end

vim.opt.mousemodel = 'popup_setpos'

-- clear old copies on reload
vim.cmd([[silent! aunmenu ]NeoTree]])

vim.cmd([[amenu ]NeoTree.Rename            <Cmd>lua _G.error311_neotree_menu_action('r')<CR>]])
vim.cmd([[amenu ]NeoTree.Move              <Cmd>lua _G.error311_neotree_menu_action('m')<CR>]])
vim.cmd([[amenu ]NeoTree.New\ File         <Cmd>lua _G.error311_neotree_menu_action('a')<CR>]])
vim.cmd([[amenu ]NeoTree.New\ Directory    <Cmd>lua _G.error311_neotree_menu_action('A')<CR>]])
vim.cmd([[amenu ]NeoTree.Delete            <Cmd>lua _G.error311_neotree_menu_action('d')<CR>]])
vim.cmd([[amenu ]NeoTree.Copy              <Cmd>lua _G.error311_neotree_menu_action('y')<CR>]])
vim.cmd([[amenu ]NeoTree.Cut               <Cmd>lua _G.error311_neotree_menu_action('x')<CR>]])
vim.cmd([[amenu ]NeoTree.Paste\ Into\ Here <Cmd>lua _G.error311_neotree_menu_action('p')<CR>]])
vim.cmd([[amenu ]NeoTree.Refresh           <Cmd>lua _G.error311_neotree_menu_action('R')<CR>]])

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function(args)
    vim.keymap.set('n', '<RightMouse>', function()
      if not focus_mouse_node() then
        return
      end

      vim.cmd('popup! ]NeoTree')
    end, { buffer = args.buf, silent = true })
  end,
})
