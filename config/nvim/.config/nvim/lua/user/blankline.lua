local blankline_status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not blankline_status_ok then
	return
end

indent_blankline.setup {
	indent_blankline_buftype_exclude = {'terminal'},
}
