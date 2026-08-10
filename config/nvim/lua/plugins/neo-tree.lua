-- Layer Zed-like styling and ergonomics on top of LazyVim's neo-tree extra.
-- Only `opts` here, deep-merged with the extra's opts -- no `config`/`init`,
-- so we don't clobber the extra's file-rename hooks or lazy-load autocmd.

-- Single click opens files and toggles directories, even when the click
-- starts from a different window (e.g. the editor). A neo-tree-buffer-local
-- mapping only fires once neo-tree already has focus: Neovim resolves
-- <LeftMouse> against the window you're clicking FROM, so the first click
-- from elsewhere just switches focus and a second click is needed to open.
-- Mapping globally and doing the window switch/cursor placement ourselves
-- (mirroring Neovim's default click behavior for non-neo-tree windows)
-- lets the same click both focus neo-tree and act on the node under it.
vim.keymap.set("n", "<LeftMouse>", function()
  local mouse = vim.fn.getmousepos()
  local winid = mouse.winid
  if winid == 0 or not vim.api.nvim_win_is_valid(winid) then
    return
  end
  vim.api.nvim_set_current_win(winid)
  pcall(vim.api.nvim_win_set_cursor, winid, { mouse.line, 0 })

  local state = require("neo-tree.sources.manager").get_state_for_window(winid)
  if state and state.commands and state.commands["open"] then
    state.commands["open"](state)
  end
end, { desc = "Focus window at click; open node if it's neo-tree" })

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    default_component_configs = {
      indent = {
        expander_collapsed = "",
        expander_expanded = "",
      },
      modified = {
        symbol = "●",
      },
      git_status = {
        symbols = {
          added = "+",
          modified = "●",
          deleted = "-",
          renamed = "➜",
          untracked = "+",
          ignored = "",
          unstaged = "○",
          staged = "●",
          conflict = "!",
        },
      },
    },
  },
}
