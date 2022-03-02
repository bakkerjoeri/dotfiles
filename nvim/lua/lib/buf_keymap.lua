local buf_keymap = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true }))
end

return buf_keymap
