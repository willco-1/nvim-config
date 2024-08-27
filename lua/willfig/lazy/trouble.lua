return {
    {
		'folke/trouble.nvim',
		cmd = { 'Trouble', 'TroubleToggle' },
		opts = { use_diagnostic_signs = true },
		-- stylua: ignore
		keys = {
			{ '<leader>xz', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
			{ '<leader>xZ', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
			{ '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
			{
				'<leader>xS',
				'<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
				desc = 'LSP references/definitions/... (Trouble)',
			},
			{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
			{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },

			{ 'gR', function() require('trouble').open('lsp_references') end, desc = 'LSP References (Trouble)' },
			{
				'[q',
				function()
					if require('trouble').is_open() then
						require('trouble').previous({ skip_groups = true, jump = true })
					else
						vim.cmd.cprev()
					end
				end,
				desc = 'Previous Trouble/Quickfix Item',
			},
			{
				']q',
				function()
					if require('trouble').is_open() then
						require('trouble').next({ skip_groups = true, jump = true })
					else
						vim.cmd.cnext()
					end
				end,
				desc = 'Next Trouble/Quickfix Item',
			},
		},
	},

}
