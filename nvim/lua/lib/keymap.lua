local keymap = function(mode, lhs, rhs, opts)
	vim.api.nvim_set_keymap(
		mode,
		lhs,
		rhs,
		vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true})
	)
end

return keymap
