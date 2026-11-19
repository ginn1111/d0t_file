-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

-- fcitx5 auto-switch (Vietnamese typing via unikey).
-- Problem: normal-mode keys (hjkl, dd, ciw, ...) get composed by unikey when it
-- is active, so motions and commands break.
-- Behaviour:
--   * Leaving insert mode -> remember whether unikey was on, then switch to EN.
--   * Entering insert mode -> switch back to unikey only if it was on before,
--     so plain-English editing sessions are never forced into Vietnamese.
-- Requires kitty to be connected to fcitx5 (GLFW_IM_MODULE=ibus, see .xinitrc).
-- The guard skips all of this on machines without the rootless fcitx5 install.
local fcitx = vim.fn.expand("~/.local/bin/fcitx5-remote")
if vim.fn.executable(fcitx) == 1 then
  -- State carried from InsertLeave to the next InsertEnter (shared across buffers).
  local was_active = false
  -- Named augroup with clear = true: re-sourcing this file won't stack duplicates.
  local group = vim.api.nvim_create_augroup("fcitx5_auto", { clear = true })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    callback = function()
      -- `fcitx5-remote` with no args prints the state:
      --   2 = active (unikey), 1 = inactive (keyboard-us), 0 = not running.
      -- Synchronous call on purpose: we must read the state before switching.
      was_active = vim.trim(vim.fn.system({ fcitx })) == "2"
      if was_active then
        -- -c = deactivate (back to keyboard-us). Async: don't block the UI.
        vim.system({ fcitx, "-c" })
      end
    end,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    group = group,
    callback = function()
      if was_active then
        -- -o = activate (unikey). Async for the same reason as above.
        vim.system({ fcitx, "-o" })
      end
    end,
  })
end
