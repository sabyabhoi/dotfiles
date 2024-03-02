local comment_ok, comment = pcall(require, 'Comment')
if not comment_ok then
  return
end

comment.setup({
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = { line = '<C-m>', block = 'gbc' },
  opleader = { line = '<C-m>', block = 'gb' },
  extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
  mappings = { basic = true, extra = true },
  pre_hook = nil,
  post_hook = nil,

})
