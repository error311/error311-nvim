local function is_real_buffer(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return false end

  local bo = vim.bo[buf]
  return bo.buflisted and bo.buftype == '' and bo.filetype ~= 'neo-tree'
end

local function listed_real_buffers()
  local out = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if is_real_buffer(buf) then table.insert(out, buf) end
  end
  return out
end

local function next_real_buffer(current)
  for _, buf in ipairs(listed_real_buffers()) do
    if buf ~= current then return buf end
  end
  return nil
end

local function smart_quit()
  local current = vim.api.nvim_get_current_buf()
  local ft = vim.bo[current].filetype
  local real = listed_real_buffers()

  -- if you're focused in neo-tree
  if ft == 'neo-tree' then
    if #real <= 1 then
      vim.cmd 'confirm qall'
    else
      vim.cmd 'Neotree close'
    end
    return
  end

  -- if this is the last real editor buffer, quit nvim completely
  if #real <= 1 then
    vim.cmd 'confirm qall'
    return
  end

  -- otherwise keep the editor pane alive by switching it first
  local target = next_real_buffer(current)
  if target then
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, target)
  end

  -- now delete the old buffer without wrecking layout
  vim.cmd('confirm Bdelete ' .. current)
end

vim.api.nvim_create_user_command('SmartQuit', smart_quit, {})

-- Rewrite only exact :q into :SmartQuit
vim.cmd [[
  cnoreabbrev <expr> q getcmdtype() == ':' && getcmdline() ==# 'q' ? 'SmartQuit' : 'q'
]]
