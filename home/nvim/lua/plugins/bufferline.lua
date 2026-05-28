return {
    -- Bufferline configuration
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = function()
            vim.opt.termguicolors = true
            return {
                options = {
                    separator_style = "slanted",
                    numbers = "ordinal",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    middle_mouse_command = "BufferLineCloseOthers",
                    indicator = {
                        icon = "",
                        style = "icon", -- Highlight active buffer with underline for clarity
                    },
                    diagnostics = "coc",
                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and "" or ""
                        return "  " .. icon .. count
                    end,
                    buffer_close_icon = "", -- Custom close icon
                    close_icon = "-", -- Icon for closing all the tabs
                    modified_icon = "●", -- Icon for modified buffers
                    left_trunc_marker = "", -- Marker for left overflow
                    right_trunc_marker = "", -- Marker for right overflow
                    max_name_length = 20, -- Set a max buffer name length
                    max_prefix_length = 15, -- Set a max prefix length for truncated buffers
                    tab_size = 25, -- Set minimum tab size for buffers
                    enforce_regular_tabs = true, -- Ensure all tabs are the same width
                    color_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    persist_buffer_sort = true, -- Keep custom sorting
                }
            }
        end,
    },
}
