return {
	{
		"neo-tree.nvim",
		for_cat = "general.neo-tree-nvim",
		event = "DeferredUIEnter",
		-- ft = "",
		keys = {
			--			{
			--				"<leader>fe",
			--				function()
			--					require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
			--				end,
			--				desc = "Explorer NeoTree (Root Dir)",
			--			},
			{
				"<leader>f]",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>]", "<leader>f]", desc = "Explorer NeoTree (cwd)", remap = true },
			{
				"<leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git Explorer",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer Explorer",
			},
		},
		-- colorscheme = "",
		after = function(plugin)
			require("neo-tree").setup({
				options = {
					sources = { "filesystem", "buffers", "git_status" },
					open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
					filesystem = {
						bind_to_cwd = false,
						follow_current_file = { enabled = true },
						use_libuv_file_watcher = true,
					},
					window = {
						mappings = {
							["l"] = "open",
							["h"] = "close_node",
							["<space>"] = "none",
							["Y"] = {
								function(state)
									local node = state.tree:get_node()
									local path = node:get_id()
									vim.fn.setreg("+", path, "c")
								end,
								desc = "Copy Path to Clipboard",
							},
							--							["O"] = {
							--								function(state)
							--									require("lazy.util").open(state.tree:get_node().path, { system = true })
							--								end,
							--								desc = "Open with System Application",
							--							},
							["P"] = { "toggle_preview", config = { use_float = false } },
						},
					},
					default_component_configs = {
						indent = {
							with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
							expander_collapsed = "",
							expander_expanded = "",
							expander_highlight = "NeoTreeExpander",
						},
						git_status = {
							symbols = {
								unstaged = "󰄱",
								staged = "󰱒",
							},
						},
					},
				},
			})
		end,
	},
}
