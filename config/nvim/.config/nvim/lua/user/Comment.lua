local Comment_status_ok, Comment = pcall(require, 'Comment')
if not Comment_status_ok then
	return
end

Comment.setup()
