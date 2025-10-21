#import "loader.typ": *

#let color-map = (
  "dark": (
    cmyk(40%, 22.86%, 0%, 86.27%),
    cmyk(94.83%, 0%, 62.07%, 77.25%),
    cmyk(76.85%, 0%, 57.41%, 57.65%),
    cmyk(71.25%, 0%, 58.13%, 37.25%),
    cmyk(59.24%, 0%, 52.61%, 17.25%),
  ),
  "light": (
    cmyk(2.45%, 1.22%, 0%, 3.92%),
    cmyk(27.73%, 0%, 21.43%, 6.67%),
    cmyk(61.86%, 0%, 44.85%, 23.92%),
    cmyk(72.56%, 0%, 52.44%, 35.69%),
    cmyk(82.83%, 0%, 58.59%, 61.18%)
  ),
)

#let background-color = (
  "dark": cmyk(43.48%, 26.09%, 0%, 90.98%),
  "light": cmyk(0%, 0%, 0%, 0%),
)

#let get-color(level) = {
  let config = load-config()
  let theme = config.at("theme", default: "dark")
  let color = color-map.at(theme).at(level)
  return color
}

#let get-background-color() = {
  let config = load-config()
  let theme = config.at("theme", default: "dark")
  let color = background-color.at(theme)
  return color
}
