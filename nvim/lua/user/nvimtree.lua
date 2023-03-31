local present, nvimtree = pcall(require, "nvim-tree")
local tree_cb = require 'nvim-tree.config'.nvim_tree_callback

if not present then
    return
end

local options = {
    filters = {
        dotfiles = false,
        exclude = { "custom" },
    },
    disable_netrw = true,
    hijack_netrw = true,
    ignore_ft_on_setup = { "alpha" },
    open_on_tab = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    view = {
        side = "left",
        width = 30,
        hide_root_folder = true,
        mappings = {
            custom_only = false,
            list = {
                -- user mappings go here
                { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                { key = "<C-e>", action = "edit_in_place" },
                { key = "O", action = "edit_no_picker" },
                { key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
                { key = "<C-v>", action = "vsplit" },
                { key = "<C-x>", action = "split" },
                { key = "<C-t>", action = "tabnew" },
                { key = "<", action = "prev_sibling" },
                { key = ">", action = "next_sibling" },
                { key = "P", action = "parent_node" },
                { key = "<BS>", action = "close_node" },
                { key = "<Tab>", action = "preview" },
                { key = "K", action = "first_sibling" },
                { key = "J", action = "last_sibling" },
                { key = "I", action = "toggle_git_ignored" },
                { key = "H", action = "toggle_dotfiles" },
                { key = "U", action = "toggle_custom" },
                { key = "R", action = "refresh" },
                { key = "a", action = "create" },
                { key = "d", action = "remove" },
                { key = "D", action = "trash" },
                { key = "r", action = "rename" },
                { key = "<C-r>", action = "full_rename" },
                { key = "x", action = "cut" },
                { key = "c", action = "copy" },
                { key = "p", action = "paste" },
                { key = "y", action = "copy_name" },
                { key = "Y", action = "copy_path" },
                { key = "gy", action = "copy_absolute_path" },
                { key = "[c", action = "prev_git_item" },
                { key = "]c", action = "next_git_item" },
                { key = "-", action = "dir_up" },
                { key = "s", action = "system_open" },
                { key = "f", action = "live_filter" },
                { key = "F", action = "clear_live_filter" },
                { key = "q", action = "close" },
                { key = "W", action = "collapse_all" },
                { key = "E", action = "expand_all" },
                { key = "S", action = "search_node" },
                { key = ".", action = "run_file_command" },
                { key = "<C-k>", action = "toggle_file_info" },
                { key = "g?", action = "toggle_help" },
            },
        },
    },
    git = {
        enable = false,
        ignore = true,
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    renderer = {
        highlight_git = false,
        highlight_opened_files = "none",
        indent_markers = {
            enable = false,
        },
        icons = {
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false,
            },
            glyphs = {
                -- default = "",
                default = "☰",
                symlink = "",
                folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                    symlink_open = "",
                    arrow_open = "",
                    arrow_closed = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
}

local list = {
    { key = { "<CR>", "o" }, action = "edit", mode = "n" },
    { key = "p", action = "print_path", action_cb = print_node_path },
    { key = "s", cb = tree_cb("vsplit") }, --tree_cb and the cb property are deprecated
    { key = "<2-RightMouse>", action = "" }, -- will remove default cd action
}

nvimtree.setup(options)
