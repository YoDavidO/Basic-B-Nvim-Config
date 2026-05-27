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
		list = {
			selection = { preselect = true, auto_insert = false },
		}
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
vim.keymap.set('n', '<leader>b', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

vim.lsp.enable({ 'lua_ls', 'ts_ls', 'eslint', })
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
vim.lsp.config('eslint', {
	filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
	root_markers = { 'eslint.config.js', '.eslintrc.js', '.eslintrc.json', 'package.json'},
	settings = {
		format = true
	}
})

vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
	callback = function ()
		vim.lsp.buf.code_action({
			context = {
				only = { 'source.fixAll.eslint' },
				diagnostics = {},
			},
			apply = true
		})
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function ()
		if vim.fn.filereadable('.session.vim') == 1 then
			vim.cmd('source .session.vim')
			-- retrigger filetype detection on current buffer to reattach lsp
			vim.defer_fn(function ()
				vim.cmd('filetype detect')
				vim.cmd('e')
			end, 100)
		end
	end
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function ()
		if vim.fn.filereadable('.session.vim') == 1 then
			vim.cmd('mksession! .session.vim')
		end
	end
})

-- Color scheme --
require "vague".setup()
vim.cmd("colorscheme vague")
