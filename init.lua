require "options"
require "keymap"

-- Packages --
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/saghen/blink.cmp", },
})

require "blink.cmp".setup({
	completion = {
		selection = { preselect = false, auto_insert = false },
	},
	keymap = {
		['<CR>'] = { 'accept', 'fallback' },
		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<Tab>'] = { 'select_next', 'fallback' },
		['<S-Tab>'] = { 'select_prev', 'fallback' },
		['<C-e>'] = { 'hide', 'fallback' },
		['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
	},
})

require "mini.pairs".setup()
require "mini.pick".setup()
require "oil".setup()

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>ff', ':Pick grep_live<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

vim.lsp.enable({ 'lua_ls', 'ts_ls' })
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
})
vim.lsp.config('ts_ls', {
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
	root_markers = { 'tsconfig.json', 'package.json', '.git' },
	settings = {
		typescript = {
			preferences = {
				includeCompletionsForModuleExports = true,
				importModuleSpecifier = "shortest"
			}
		}
	}
})

-- Color scheme --
require "vague".setup()
vim.cmd("colorscheme vague")
