local status, lualine = pcall(require, "lualine")

if not status then
  return
end

lualine.setup()

lualine.setup({
  options = {
    icons_enabled = true,
    -- theme = "onedark",
    theme = "catppuccin",
    component_separators = "|",
    section_separators = "",
  },
})
