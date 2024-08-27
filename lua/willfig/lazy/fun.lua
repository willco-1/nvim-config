return {	-----------------------------------------------------------------------------
	-- Code outline sidebar powered by LSP
	{
		'hedyhli/outline.nvim',
		cmd = { 'Outline', 'OutlineOpen' },
		keys = {
			{ '<leader>wo', '<cmd>Outline<CR>', desc = 'Toggle outline' },
		},
		opts = function()
			local Config = require('lazyvim.config')
			local defaults = require('outline.config').defaults
			local opts = {
				symbols = {},
				symbol_blacklist = {},
			}
			local filter = Config.kind_filter

			if type(filter) == 'table' then
				local filter_opts = filter.default
				if type(filter_opts) == 'table' then
					for kind, symbol in pairs(defaults.symbols) do
						opts.symbols[kind] = {
							icon = Config.icons.kinds[kind] or symbol.icon,
							hl = symbol.hl,
						}
						if not vim.tbl_contains(filter_opts, kind) then
							table.insert(opts.symbol_blacklist, kind)
						end
					end
                end
			end
			return opts
		end,
	},

	-----------------------------------------------------------------------------
	-- Fancy window picker
	{
		's1n7ax/nvim-window-picker',
		event = 'VeryLazy',
		keys = function(_, keys)

			local pick_window = function()
				local picked_window_id = require('window-picker').pick_window()
				if picked_window_id ~= nil then
					vim.api.nvim_set_current_win(picked_window_id)
                end
			end

			local swap_window = function()
				local picked_window_id = require('window-picker').pick_window()
				if picked_window_id ~= nil then
					local current_winnr = vim.api.nvim_get_current_win()
					local current_bufnr = vim.api.nvim_get_current_buf()
					local other_bufnr = vim.api.nvim_win_get_buf(picked_window_id)
					vim.api.nvim_win_set_buf(current_winnr, other_bufnr)
					vim.api.nvim_win_set_buf(picked_window_id, current_bufnr)
				end
			end

			local mappings = {
				{ 'sp', pick_window, desc = 'Pick window' },
				{ 'sw', swap_window, desc = 'Swap picked window' },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			hint = 'floating-big-letter',
			show_prompt = false,
			filter_rules = {
				include_current_win = true,
				bo = {
					filetype = { 'notify', 'noice', 'neo-tree-popup' },
					buftype = { 'prompt', 'nofile', 'quickfix' },
				},
			},
		},
	},

	-----------------------------------------------------------------------------
	-- Pretty window for navigating LSP locations
	{
		'dnlhc/glance.nvim',
		cmd = 'Glance',
		keys = {
			{ 'gpd', '<cmd>Glance definitions<CR>' },
			{ 'gpr', '<cmd>Glance references<CR>' },
			{ 'gpy', '<cmd>Glance type_definitions<CR>' },
			{ 'gpi', '<cmd>Glance implementations<CR>' },
		},
		opts = function()
			local actions = require('glance').actions
			return {
				folds = {
					fold_closed = '󰅂', -- 󰅂 
					fold_open = '󰅀', -- 󰅀 
					folded = true,
				},
				mappings = {
					list = {
						['<C-u>'] = actions.preview_scroll_win(5),
						['<C-d>'] = actions.preview_scroll_win(-5),
						['sg'] = actions.jump_vsplit,
						['sv'] = actions.jump_split,
						['st'] = actions.jump_tab,
						['p'] = actions.enter_win('preview'),
					},
					preview = {
						['q'] = actions.close,
						['p'] = actions.enter_win('list'),
					},
				},
			}
		end,
	},

	-----------------------------------------------------------------------------
	-- Find the enemy and replace them with dark power
	{
		'nvim-pack/nvim-spectre',
		-- stylua: ignore
		keys = {
			{ '<Leader>sp', function() require('spectre').toggle() end, desc = 'Spectre', },
			{ '<Leader>sp', function() require('spectre').open_visual({ select_word = true }) end, mode = 'x', desc = 'Spectre Word' },
		},
		opts = {
			open_cmd = 'noswapfile vnew',
			mapping = {
				['toggle_gitignore'] = {
					map = 'tg',
					cmd = "<cmd>lua require('spectre').change_options('gitignore')<CR>",
					desc = 'toggle gitignore',
				},
			},
			find_engine = {
				['rg'] = {
					cmd = 'rg',
					args = {
						'--pcre2',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--ignore',
					},
					options = {
						['gitignore'] = {
							value = '--no-ignore',
							icon = '[G]',
							desc = 'gitignore',
						},
					},
				},
			},
			default = {
				find = {
					cmd = 'rg',
					options = { 'ignore-case', 'hidden', 'gitignore' },
				},
			},
		},
	}, }
