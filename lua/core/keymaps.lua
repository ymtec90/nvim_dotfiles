-- Settings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = nil

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- Mappings
-- Normal Mode
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', 'o', 'o<ESC>')
vim.keymap.set('n', 'O', 'O<ESC>')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'Y', 'y$')
-- Navigation mappings
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
-- Resizing mappings
vim.keymap.set('n', '<C-Up>', '<C-w>+')
vim.keymap.set('n', '<C-Down>', '<C-w>-')
vim.keymap.set('n', '<C-Right>', '<C-w><')
vim.keymap.set('n', '<C-Left>', '<C-w>>')
-- Disable keys
vim.keymap.set('n', '<Up>', '<Nop>')
vim.keymap.set('n', '<Down>', '<Nop>')
vim.keymap.set('n', '<Right>', '<Nop>')
vim.keymap.set('n', '<Left>', '<Nop>')
vim.keymap.set('n', 'Q', '<Nop>')
-- Insert Mode
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')
-- Visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Vimscript
function createAutoCommands()
  vim.cmd([[
    augroup cursor_off
      autocmd!
      autocmd WinLeave * set nocursorline
      autocmd WinEnter * set cursorline
    augroup END
    augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
      autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
    augroup END
  ]])
end

createAutoCommands()
