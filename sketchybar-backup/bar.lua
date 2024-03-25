local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 39,
  color = colors.bar.bg,
  padding_right = 2,
  padding_left = 2,
  y_offset = 0,
  margin = 0,
  corner_radius = 0,
  notch_width = 180,
})
