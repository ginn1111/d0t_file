local keymap = vim.keymap

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'fn', ':tabedit<Return>', { silent = true })
keymap.set('n', 'fw', ':tabclose<Return>', { silent = true })
--keymap.set('n', '<Tab>', ':tabnext<Return>', { silent = true })
--keymap.set('n', '<S-Tab>', ':tabprev<Return>', { silent = true })

-- Split window
keymap.set('n', 'fs', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'fv', ':vsplit<Return><C-w>w', { silent = true })

-- Move window
keymap.set('n', 'fo', '<C-w>w', { silent = true })
keymap.set('', 'fh', '<C-w>h', { silent = true })
keymap.set('', 'fk', '<C-w>k', { silent = true })
keymap.set('', 'fj', '<C-w>j', { silent = true })
keymap.set('', 'fl', '<C-w>l', { silent = true })

-- Resize window
keymap.set('n', '<', '<C-w><', { silent = true })
keymap.set('n', '>', '<C-w>>', { silent = true })
keymap.set('n', '=', '<C-w>+', { silent = true })
keymap.set('n', '_', '<C-w>-', { silent = true })

-- NERDTree
keymap.set('n', '<C-b>', ':NERDTreeToggle<Return>', { silent = true })
