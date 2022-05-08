local _M = {}

_M.colors = {
    bg = "#0A0E14",
    fg = "#B3B1AD",

    comment = "#5C6773",
    markup = "#F07178",
    constant = "#FFEE99",
    operator = "#E7C547",
    tag = "#36A3D9",
    regexp = "#95E6CB",
    string = "#B8CC52",
    fn = "#FFB454",
    special = "#E6B673",
    keyword = "#FF7733",

    error = "#FF3333",
    accent = "#F29718",
    panel = "#14191F",
    guide = "#2D3640",
    line = "#151A1E",
    selection = "#253340",
    fg = "#E6E1CF",
    fg_idle = "#3E4B59",

    dark1 = "#0F131A",
    dark2 = "#0D1017",
    dark3 = "#0B0E14",

    magenta = "#D2A6FF",

    grey1 = "#f8fafc",
    grey2 = "#f0f1f4",
    grey3 = "#eaecf0",
    grey4 = "#d9dce3",
    grey5 = "#c4c9d4",
    grey6 = "#b5bcc9",
    grey7 = "#929cb0",
    grey8 = "#8e99ae",
    grey9 = "#74819a",
    grey10 = "#616d85",
    grey11 = "#464f62",
    grey12 = "#3a4150",
    grey13 = "#333a47",
    grey14 = "#242932",
    grey15 = "#1e222a",
    grey16 = "#1c1f26",
    grey17 = "#0f1115",
    grey18 = "#0d0e11",
    grey19 = "#020203",
}

_M.init = function()
    local isExistNord, onenord = pcall(require, "onenord")
    if isExistNord then
        print "echo";
        onenord.setup {
            custom_colors = {
                fg_light = "#E5E9F0",
                gray = "#646A76",
                light_gray = "#6C7A96",
                cyan = "#88C0D0",
                light_green = "#8FBCBB",
                dark_red = "#BF616A",
                red = "#D57780",
                light_red = "#DE878F",
                pink = "#E85B7A",
                dark_pink = "#E44675",
                light_purple = "#B48EAD",
                none = "NONE",

                orange = _M.colors.magenta,

                bg = _M.colors.bg,
                fg = _M.colors.fg,

                blue = _M.colors.fn,
                dark_blue = _M.colors.fn,

                red = _M.colors.error,
                purple = _M.colors.keyword,
                yellow = _M.colors.tag,
                green = _M.colors.tag,
                cyan = "NONE",

                active = _M.colors.bg,

                gray = _M.colors.comment,
                light_gray = _M.colors.comment,
                light_red = _M.colors.light_red,
            },
            borders = true,
            fade_nc = false,
            styles = {
                comments = "italic",
                keywords = "NONE",
                functions = "italic",
                diagnostics = "underline",
            },
            disable = {
                background = false,
                cursorline = false,
                eob_lines = true,
            },
            custom_highlights = {
                String = { fg = _M.colors.string },

                Define = { fg = _M.colors.special },
                Macro = { fg = _M.colors.special },

                TSString = { fg = _M.colors.string },
                TSConstMacro = { fg = _M.colors.special },
                TSParameter = { fg = _M.colors.special },
                TSParameterReference = { fg = _M.colors.special },
                TSVariableBuiltin = { fg = _M.colors.special },
                TSField = { fg = _M.colors.tag },

                LspSagaAutoPreview = { fg = _M.colors.special },

                BufferCurrentTarget = { fg = _M.colors.special, bg = _M.colors.bg, style = "bold" },
                BufferVisibleTarget = { fg = _M.colors.special, bg = _M.colors.bg, style = "bold" },
                BufferInactiveTarget = { fg = _M.colors.special, bg = _M.colors.active, style = "bold" },

                DapBreakpoint = { fg = _M.colors.special },

                VertSplit = { fg = _M.colors.grey14 },
                BufferLineIndicatorSelected = { fg = _M.colors.cyan, bg = _M.colors.bg },
                BufferLineFill = { fg = _M.colors.fg, bg = _M.colors.grey14 },
                NvimTreeNormal = { fg = _M.colors.grey5, bg = _M.colors.bg },
                WhichKeyFloat = { bg = _M.colors.grey14 },
                GitSignsAdd = { fg = _M.colors.green },
                GitSignsChange = { fg = _M.colors.orange },
                GitSignsDelete = { fg = _M.colors.red },
                NvimTreeFolderIcon = { fg = _M.colors.grey9 },
                NvimTreeIndentMarker = { fg = _M.colors.grey12 },

                NormalFloat = { bg = _M.colors.grey14 },
                FloatBorder = { bg = _M.colors.grey14, fg = _M.colors.grey14 },

                TelescopePromptPrefix = { bg = _M.colors.dark1 },
                TelescopePromptNormal = { bg = _M.colors.dark1 },
                TelescopeResultsNormal = { bg = _M.colors.dark2 },
                TelescopePreviewNormal = { bg = _M.colors.dark3 },

                TelescopePromptBorder = { bg = _M.colors.dark1, fg = _M.colors.dark1 },
                TelescopeResultsBorder = { bg = _M.colors.dark2, fg = _M.colors.dark2 },
                TelescopePreviewBorder = { bg = _M.colors.dark3, fg = _M.colors.dark3 },

                TelescopePromptTitle = { fg = _M.colors.grey14 },
                TelescopeResultsTitle = { fg = _M.colors.grey15 },
                TelescopePreviewTitle = { fg = _M.colors.grey16 },

                PmenuSel = { bg = _M.colors.grey12 },
                Pmenu = { bg = _M.colors.grey14 },
                PMenuThumb = { bg = _M.colors.grey16 },

                LspFloatWinNormal = { fg = _M.colors.fg, bg = _M.colors.grey14 },
                LspFloatWinBorder = { fg = _M.colors.grey14 },
            },
        }
    end
end

return _M
