local currentLine = function()
    local linenr = vim.api.nvim_win_get_cursor(0)[1]
    print(
        string.format("Current line [%d]", linenr)
    )
end

return {
    currentLine = currentLine,
}
