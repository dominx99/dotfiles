local ayu = require "ayu"

local _M = {}

_M.colors = {
    bg = "#0A0E14",
    fg = "#E6E1CF",

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

ayu.setup({
    mirage = false,
    overrides = {
        Normal = { bg = _M.colors.bg },
        NormalFloat = { bg = _M.colors.bg },

        StatusLine = { bg = _M.colors.bg },
        StatusLineNC = { bg = _M.colors.bg },
        FoldColumn = { bg = _M.colors.bg },
        Folded = { bg = _M.colors.bg },
        CursorColumn = { bg = _M.colors.bg },
        CursorLine = { bg = _M.colors.bg },
        ColorColumn = { bg = _M.colors.bg },
        SignColumn = { bg = _M.colors.bg },

        VertSplit = { bg = _M.colors.bg },

        -- TelescopePromptPrefix = { bg = _M.colors.dark1 },
        -- TelescopePromptNormal = { bg = _M.colors.dark1 },
        -- TelescopeResultsNormal = { bg = _M.colors.dark2 },
        -- TelescopePreviewNormal = { bg = _M.colors.dark3 },
        --
        -- TelescopePromptBorder = { bg = _M.colors.dark1, fg = _M.colors.dark1 },
        -- TelescopeResultsBorder = { bg = _M.colors.dark2, fg = _M.colors.dark2 },
        -- TelescopePreviewBorder = { bg = _M.colors.dark3, fg = _M.colors.dark3 },
        --
        -- TelescopePromptTitle = { fg = _M.colors.grey14 },
        -- TelescopeResultsTitle = { fg = _M.colors.grey15 },
        -- TelescopePreviewTitle = { fg = _M.colors.grey16 },

        BufferCurrentTarget = { fg = _M.colors.special, bg = _M.colors.bg },
        BufferVisibleTarget = { fg = _M.colors.special, bg = _M.colors.bg },
        BufferInactiveTarget = { fg = _M.colors.special, bg = _M.colors.active },

        DapBreakpoint = { fg = _M.colors.special },

        BufferLineIndicatorSelected = { fg = _M.colors.cyan, bg = _M.colors.bg },
        BufferLineFill = { fg = _M.colors.fg, bg = _M.colors.grey14 },
        NvimTreeNormal = { fg = _M.colors.grey5, bg = _M.colors.bg },
        WhichKeyFloat = { bg = _M.colors.grey14 },
        GitSignsAdd = { fg = _M.colors.green },
        GitSignsChange = { fg = _M.colors.orange },
        GitSignsDelete = { fg = _M.colors.red },
        NvimTreeFolderIcon = { fg = _M.colors.grey9 },
        NvimTreeIndentMarker = { fg = _M.colors.grey12 },

        FloatBorder = { bg = _M.colors.grey14, fg = _M.colors.grey14 },
        PmenuSel = { bg = _M.colors.grey12 },
        Pmenu = { bg = _M.colors.grey14 },
        PMenuThumb = { bg = _M.colors.grey16 },

        LspFloatWinNormal = { fg = _M.colors.fg, bg = _M.colors.grey14 },
        LspFloatWinBorder = { fg = _M.colors.grey14 },
    },
})

return ayu
