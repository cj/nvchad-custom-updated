local M = {}

M.plugins = require 'custom.plugins'

M.mappings = require "custom.mappings"

M.ui = {
  -- statusline = {
  --  override = require "custom.plugins.statusline",
  -- },

  hl_override = {
    --override default highlights
    IndentBlanklineContextChar = { fg = "#e5c07b", bg = "NONE" },
    IndentBlanklineContextStart = { fg = "NONE", bg = "#272c36" },
    DiffAdd = { bg = "#2F4446", fg = "NONE" },
    DiffChange = { bg = "#232c4c", fg = "NONE" },
    DiffText = { bg = "#404475", fg = "NONE" },
    DiffDelete = { bg = "#341c28", fg = "#313650" },
    Error = { bg = "#2a1d1d", fg = "NONE", italic = true },
  },

  hl_add = {
    DiffText = { bg = "#404475", fg = "NONE" },
    CmpItemKindCopilot = { fg = "#c8ccd4", bg = "NONE" },
    CmpItemKindTabNine = { fg = "#e5c07b", bg = "NONE" },
    CmpItemKindTreesitter = { fg = "#6CC644", bg = "NONE" },
    GpsItemAbbr = { fg = "#abb2bf", bg = "#22262e", bold = true },
    GpsItemAbbrMatch = { fg = "#61afef", bold = true, bg = "#22262e" },
    GpsBorder = { fg = "#42464e", bg = "#22262e", bold = true },
    GpsDocBorder = { fg = "#42464e", bg = "#22262e", bold = true },
    NavicIconsConstant = { fg = "#d19a66", bg = "#22262e", bold = true },
    NavicIconsFunction = { fg = "#61afef", bg = "#22262e", bold = true },
    NavicIconsIdentifier = { fg = "#e06c75", bg = "#22262e", bold = true },
    NavicIconsField = { fg = "#e06c75", bg = "#22262e", bold = true },
    NavicIconsVariable = { fg = "#c678dd", bg = "#22262e", bold = true },
    NavicIconsSnippet = { fg = "#e06c75", bg = "#22262e", bold = true },
    NavicIconsText = { fg = "#98c379", bg = "#22262e", bold = true },
    NavicIconsStructure = { fg = "#c678dd", bg = "#22262e", bold = true },
    NavicIconsType = { fg = "#e5c07b", bg = "#22262e", bold = true },
    NavicIconsKeyword = { fg = "#c8ccd4", bg = "#22262e", bold = true },
    NavicIconsMethod = { fg = "#61afef", bg = "#22262e", bold = true },
    NavicIconsConstructor = { fg = "#61afef", bg = "#22262e", bold = true },
    NavicIconsFolder = { fg = "#c8ccd4", bg = "#22262e", bold = true },
    NavicIconsModule = { fg = "#e5c07b", bg = "#22262e", bold = true },
    NavicIconsProperty = { fg = "#e06c75", bg = "#22262e", bold = true },
    NavicIconsEnum = { fg = "#56b6c2", bg = "#22262e", bold = true },
    NavicIconsUnit = { fg = "#c678dd", bg = "#22262e", bold = true },
    NavicIconsClass = { fg = "#56b6c2", bg = "#22262e", bold = true },
    NavicIconsFile = { fg = "#c8ccd4", bg = "#22262e", bold = true },
    NavicIconsInterface = { fg = "#56b6c2", bg = "#22262e", bold = true },
    NavicIconsColor = { fg = "#e06c75", bg = "#22262e", bold = true },
    NavicIconsReference = { fg = "#abb2bf", bg = "#22262e", bold = true },
    NavicIconsEnumMember = { fg = "#56b6c2", bg = "#22262e", bold = true },
    NavicIconsStruct = { fg = "#c678dd", bg = "#22262e", bold = true },
    NavicIconsValue = { fg = "#56b6c2", bg = "#22262e", bold = true },
    NavicIconsEvent = { fg = "#56b6c2", bg = "#22262e", bold = true },
    NavicIconsOperator = { fg = "#abb2bf", bg = "#22262e", bold = true },
    NavicIconsTypeParameter = { fg = "#e06c75", bg = "#22262e", bold = true },
    GuihuaListSelHl = { bg = "#3e4451", fg = "NONE" },
  },
}

return M
