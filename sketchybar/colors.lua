return {
  black = 0xff363a4f,
  white = 0xfff4dbd6,
  red = 0xffed8796,
  green = 0xffa6da95,
  blue = 0xff8aadf4,
  yellow = 0xffeed49f,
  orange = 0xfff5a97f,
  magenta = 0xfff5bde6,
  grey = 0xff494d64,
  transparent = 0x00000000,

  bar = {
    bg = 0xaf494d64,
    border = 0xff8087a2,
  },
  popup = {
    bg = 0xff494d64,
    border = 0xff6e738d,
  },
  bg1 = 0xff494d64,
  bg2 = 0xff494d64,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
