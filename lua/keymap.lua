local map = vim.keymap.set
vim.g.mapleader = " "

-- Buffer stuffs
map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':qa<CR>')
map('n', '<leader>ss', ':mksession! .session.vim<CR>')
map('n', '<leader>sr', ':source .session.vim<CR>')

-- Comment line
map('n', '<C-/>', 'gcc', { remap = true })
map('v', '<C-/>', 'gc', { remap = true })
-- Comment block - TODO: Figure out why this doesn't give a block.
map('n', '<C-S-/>', 'gcb', { remap = true })
map('v', '<C-S-/>', 'gcb', { remap = true })

-- Duplicate line
map('n', '<C-d>', function()
	local col = vim.fn.col('.')
	vim.cmd('co.')
	vim.cmd('normal! ' .. col .. '|')
end)

-- Move line
map('n', '<A-S-k>', ':m .-2<CR>==')     -- Move line up
map('n', '<A-S-j>', ':m .+1<CR>==')     -- Move line down
map('v', '<A-S-k>', ":m '<-2<CR>gv=gv") -- Move selected region up
map('v', '<A-S-j>', ":m '>+1<CR>gv=gv") -- Move selected region down

-- Redo
map('n', '<S-u>', '<C-r>')

-- File picking
map('n', '<leader>f', ':Pick files<CR>')      -- Fuzzy find file
map('n', '<leader>ff', ':Pick grep_live<CR>') -- Fuzzy find string matching
map('n', '<leader>fs', function()
	require('mini.pick').builtin.grep({}, { source = { cwd = vim.fn.expand('%:p:h') } })
end) -- Search currently selected/open buffer
map('n', '<leader>nf', function ()
	local dir = vim.fn.expand('%:p:h')
	local name = vim.fn.input('New file: ', dir .. '/', 'file')

	if name ~= '' then
		vim.cmd('edit' .. name)
	end
end)

-- Attempt to pop the :Pick grep_live but it doesn't seem to grab the selected region and pass it to the grip
-- TODO: Figure out why and fix it!
map('v', '<C-S-f>', function()
	local from = vim.fn.getpos('v')
	local to = vim.fn.getpos('.')
	local lines = vim.fn.getregion(from, to, { type = vim.fn.mode() })
	local selection = table.concat(lines, '\n')
	require "mini.pick".builtin.grep_live({}, { query = selection })
end)

map('n', '<leader>b', ':Pick buffers<CR>') -- Displays the open buffers
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>e', ':Oil<CR>')

-- LSP stuffs
map('n', '<leader>lf', vim.lsp.buf.format)       -- does what it says...
map('n', '<leader>gd', vim.lsp.buf.definition)   -- go to def
map('n', '<leader>k', vim.lsp.buf.hover)         -- Pops up the type def
map('n', '<leader>d', vim.diagnostic.open_float) -- Checkout warnings & errors
