local modes = require "modes"

modes.add_binds("normal", {
  { "<Mod1-t>", "Open a new tab.",
    function(w) w:new_tab() end },

  { "<Mod1-w>", "Close current tab (or `[count]` tabs).",
    function(w, m) for _ = 1, m.count do w:close_tab() end end, { count = 1 } },
})
