return {
	{
		"bufferline.nvim",
		for_cat = "general.always",
		-- cmd = { "" },
		event = "DeferredUIEnter",
		-- ft = "",
		-- keys = "",
		-- colorscheme = "",
		after = function(plugin)
			require("bufferline").setup({
				options = {
					close_command = function(n)
						Snacks.bufdelete(n)
					end,
					right_mouse_command = function(n)
						Snacks.bufdelete(n)
					end,
					diagnostics = "nvim_lsp",
					always_show_bufferline = false,
					diagnostics_indicator = function(_, _, diag)
						local ret = (diag.error and icons.diagnostics.Error .. diag.error .. " " or "")
							.. (diag.warning and icons.diagnostics.Warn .. diag.warning or "")
						return vim.trim(ret)
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neo-tree",
							highlight = "Directory",
							text_align = "left",
						},
						{
							filetype = "snacks_layout_box",
						},
					},
					--        get_element_icon = function(opts)
					--          return icons.ft[opts.filetype]
					--        end,
				},
			})
		end,
	},
}
