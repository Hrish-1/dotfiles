local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end
telescope.setup{
  defaults = {
    layout_strategy = "vertical",
    file_ignore_patterns = {
      ".git",
      "node_modules",
      "project",
      "target"
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      }
    },
  },
}
