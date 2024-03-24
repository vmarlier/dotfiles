local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 39,
  color = colors.bar.bg,
  padding_right = 2,
  padding_left = 2,
  y_offset = 10,
  margin = 10,
  corner_radius = 9,
  notch_width = 180,
})
