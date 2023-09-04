local status, tsContextCommentStr = pcall(require, "nvim-ts-context-commentstring")
if (not status) then return end

tsContextCommentStr.setup({
})
