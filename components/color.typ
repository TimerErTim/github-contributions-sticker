#import "loader.typ": *

#let color-map = (
  "light": (  // Inverted
    rgb("#0104090d"), // Bordercolor
    rgb("#151b23"),
    rgb("#033a16"),
    rgb("#196c2e"),
    rgb("#2ea043"),
    rgb("#56d364")
  ),
  "dark": (
    rgb("#1f23280d"), // Bordercolor
    rgb("#eff2f5"),
    rgb("#aceebb"),
    rgb("#4ac26b"),
    rgb("#2da44e"),
    rgb("#116329"),
  )
)

#let background-color = (
  "dark": rgb("#0d1117"),
  "light": rgb("#ffffff"),
)

#let foreground-color = (
  "dark": rgb("#f0f6fc"),
  "light": rgb("#1f2328"),
)

#let color-space(color) = {
  return rgb(color)
}

#let get-color(level) = {
  let config = load-config()
  let theme = config.at("theme", default: "dark")
  let color = color-map.at(theme).at(level + 1)
  return color-space(color)
}

#let get-border-color(level) = {
  let config = load-config()
  let theme = config.at("theme", default: "dark")
  let fill-color = color-map.at(theme).at(level + 1)
  let border-color = color-map.at(theme).at(0)
  return color-space(color.mix(fill-color, border-color).opacify(100%))
}

#let get-background-color() = {
  let config = load-config()
  let theme = config.at("theme", default: "dark")
  let color = background-color.at(theme)
  return color-space(color)
}

#let get-foreground-color() = {
  let config = load-config()
  let theme = config.at("theme", default: "dark")
  let color = foreground-color.at(theme)
  return color-space(color)
}

