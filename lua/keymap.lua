local map = vim.keymap.set
vim.g.mapleader = " "

map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>ss', ':mksession! .session.vim<CR>')
map('n', '<leader>sr', ':source .session.vim<CR>')
-- Comment line
map('n', '<C-/>', 'gcc', { remap = true })
map('v', '<C-/>', 'gc', { remap = true })
-- Comment block
map('v', '<C-S-/>', 'gcb', { remap = true })
map('v', '<C-S-/>', 'gcb', { remap = true })

-- Duplicate line
map('n', '<C-d>', function()
	local col = vim.fn.col('.')
	vim.cmd('co.')
	vim.cmd('normal! ' .. col .. '|')
end)

-- Move line
map('n', '<A-S-k>', ':m .-2<CR>==')
map('n', '<A-S-j>', ':m .+1<CR>==')
map('v', '<A-S-k>', ":m '<-2<CR>gv=gv")
map('v', '<A-S-j>', ":m '>+1<CR>gv=gv")

-- Redo
map('n', '<S-u>', '<C-r>')
