#import "components/loader.typ": *
#import "@preview/cetz:0.4.2": *
#import "components/color.typ": *

#let contr = load-contributions()
#let config = load-config()
#let username = config.username
#let year = config.year

#let contr-graph() = {
  let side = 50pt
  let gap = 20pt

  canvas({
    import draw: *

    // Draw graph
    for y in range(contr.len()) {
      let row = contr.at(contr.len() - y - 1)
      for x in range(row.len()) {
        let contr-entry = row.at(x)
        if contr-entry == none {
          continue
        }

        let fill-color = get-color(contr-entry.level)
        let border-color = get-border-color(contr-entry.level)
        rect(
          (x * (side + gap),
           y * (side + gap)),
           (x * (side + gap) + side,
           y * (side + gap) + side), 
           fill: fill-color, stroke: border-color + 2pt, 
           radius: 10pt)
      }
    }
  })
}

#let github-icon() = {
  let theme = config.theme
  let size = 500pt
  let icon = if theme == "dark" {
    image("components/github-mark-white.svg", width: size)
  } else {
    image("components/github-mark.svg", width: size)
  }
  return icon
}

#context {
  let graph = contr-graph()
  let content = {
    let graph-size = measure(graph)
    let graph-width = graph-size.width

    graph
    v(50pt)

    let logo-and-year = box[
      #let icon = github-icon()
      #let icon-size = measure(icon)
      #box(icon)
      #box(baseline: -icon-size.height + 100%, text(size: 100pt, weight: "bold", year))
    ]

    let right-size = measure(logo-and-year)
    let right-height = right-size.height
    let username-width = graph-width - right-size.width - 100pt // margin

    let username-size = measure([])
    let username-font-size = 0pt

    let username-text(size) = {
      text(size: size, weight: "bold", baseline: -25pt)[
        //#text(size: size / 1.5, "@", baseline: -size / 3)
        #text(weight: "regular", username)
      ]
    }

    while (username-size.height < right-height) and (username-size.width < username-width) {
      username-font-size += 1pt
      username-size = measure(username-text(username-font-size))
    }

    username-text(username-font-size - 1pt)    

    h(1fr)

    logo-and-year
  }

  let page-size = measure(content)
  let page-width = page-size.width
  let page-height = page-size.height
  let page-margin = 200pt

  set page(
    width: page-width + 2 * page-margin, 
    height: page-height + 2 * page-margin, 
    margin: page-margin,
    fill: get-background-color(), 
  )
  set text(fill: get-foreground-color(), font: "Segoe UI")
  
  content
}
