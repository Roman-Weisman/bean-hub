-- Clears debug configuration default, and replaces with below.
-- Note: Since my_config.lua loads before plugins,
-- the items were added first, and I wasn't able to delete the defaults cleanly.
vim.schedule(function()
  local ok, dap = pcall(require, "dap")
  if not ok then
    return
  end

  -- Only keep these two Go configurations
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Attach to headless TUI on 40000",
      request = "attach",
      mode = "remote",
      host = "127.0.0.1",
      port = 40000,
    },
  }
end)
