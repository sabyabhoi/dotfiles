local bufferline_status_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_status_ok then
	return
end

bufferline.setup {
	options = {
		separator_style = 'slant'
	},
}
