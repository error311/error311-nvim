local function check_version()
  local verstr = tostring(vim.version())

  if not vim.version.ge then
    vim.health.error(("Neovim out of date: '%s'. Upgrade to latest stable."):format(verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.11') then
    vim.health.ok(("Neovim version is: '%s'"):format(verstr))
  else
    vim.health.error(("Neovim out of date: '%s'. Upgrade to latest stable."):format(verstr))
  end
end

local function check_exec(name, opts)
  opts = opts or {}
  local ok = vim.fn.executable(name) == 1
  local label = opts.label or name

  if ok then
    vim.health.ok(("Found executable: '%s'"):format(label))
  elseif opts.required then
    vim.health.error(("Missing required executable: '%s'"):format(label))
  else
    vim.health.warn(("Missing optional executable: '%s'"):format(label))
  end
end

return {
  check = function()
    vim.health.start 'error311.nvim'
    vim.health.info 'Checks core tools used by this config and workflow.'

    local uv = vim.uv or vim.loop
    vim.health.info('System Information: ' .. vim.inspect(uv.os_uname()))

    check_version()

    check_exec('git', { required = true })
    check_exec('make', { required = true })
    check_exec('unzip', { required = true })
    check_exec('rg', { required = true })

    check_exec 'fd'
    check_exec 'tmux'
    check_exec 'node'
    check_exec 'npm'
    check_exec('markdownlint-cli2', { label = 'markdownlint-cli2' })
    check_exec('markdownlint', { label = 'markdownlint' })
    check_exec 'kitty'
  end,
}
