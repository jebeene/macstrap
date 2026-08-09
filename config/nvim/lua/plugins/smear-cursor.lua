return {
  "sphamba/smear-cursor.nvim",
  opts = {
    -- Smear cursor color. Defaults to Cursor GUI color if not set.
    cursor_color = nil,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    smear_insert_mode = true,

    -- How fast the smear's head moves towards the target.
    -- 0: no movement, 1: instantaneous
    stiffness = 0.6,

    -- How fast the smear's tail moves towards the target.
    -- 0: no movement, 1: instantaneous
    -- Slightly behind `stiffness` for a short, subtle trail instead of a long one.
    trailing_stiffness = 0.5,

    -- Velocity reduction over time. 0: no reduction, 1: full reduction
    damping = 0.85,

    -- Maximum smear length, in characters. Keeps the trail short.
    max_length = 5,

    particles_enabled = false, -- When true, better to also set `never_draw_over_target` to true
  },
}
