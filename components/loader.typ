#let load-config() = {
    let config = toml("../config.toml")
    return config
}

#let pad-array-with(arr, value, count) = {
  while arr.len() < count {
    arr.push(value);
  }
  return arr;
}

#let load-contributions() = {
    let config = load-config()
    let name = config.username
    let year = config.year

    let path = "../contribution-stats/" + name + "_" + year + ".json"
    let contributions = json(path)
    
    let max-weeks = contributions.fold(0, ((acc, x) => calc.max(acc, x.len())))
    return contributions.map(x => {
      pad-array-with(x, none, max-weeks)
    })
}