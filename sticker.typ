#import "components/loader.typ": *
#import "@preview/cetz:0.4.2": *
#import "components/color.typ": *

#set page(width: 30em, height: 30em, fill: get-background-color())

#let contr = load-contributions()

#let contr-graph(contr) = {
  layout((parent) => {
    let side = calc.min(parent.width / 7, parent.height / contr.at(0).len())
    let margin = 0.05pt

    canvas({
      import draw: *

      for y in range(contr.len() - 1, -1, step: -1) {
        let row = contr.at(y)
        for x in range(row.len()) {
          let contr-entry = row.at(x)
          if contr-entry == none {
            continue
          }

          let color = get-color(contr-entry.level)
          rect((x * (side + margin) + margin, -y * (side + margin) + margin),(x * (side + margin) + side - margin, -y * (side + margin) + side - margin), fill: color, stroke: none, radius: 1pt, inset: 1pt)
        }
      }
    })
  })
}

#contr-graph(contr)

#let render-cell(level) = {
  let base-color = cmyk(82.48%, 0%, 78.83%, 46.27%);
  let color = base-color.lighten(level * 2 * 10%);
  if level == 0 {
    color = gray;
  }
  return box(width: 10pt, height: 10pt, fill: color)[

  ]
}

#box(height: 100% * 7 / 52, grid(columns: contr.at(0).len(), ..contr.flatten().map(x => {
  if x == none {
    []
  } else {
    render-cell(x.level)
  }
})))
