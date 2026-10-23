///|
/// Convex layers (onion decomposition): peels off convex hulls iteratively. / 凸包层次（洋葱分解）：迭代剥离凸包。
pub fn convex_layers(
  points : Array[@core.Point2D],
) -> Array[Array[@core.Point2D]] {
  let layers : Array[Array[@core.Point2D]] = []
  let remaining = points.copy()
  while remaining.length() >= 3 {
    let layer = compute_hull(remaining)
    if layer.length() < 3 {
      break
    }
    layers.push(layer)
    let layer_set = layer.copy()
    let new_remaining : Array[@core.Point2D] = []
    for p in remaining {
      let mut found = false
      for q in layer_set {
        if p.dist(q) < 0.0000001 {
          found = true
          break
        }
      }
      if !found {
        new_remaining.push(p)
      }
    }
    if new_remaining.length() == remaining.length() {
      break
    }
    remaining.clear()
    for p in new_remaining {
      remaining.push(p)
    }
  }
  layers
}

///|
fn compute_hull(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
  if points.length() <= 3 {
    return points.copy()
  }
  let pts = points.copy()
  pts.sort_by(fn(a, b) {
    if a.x() < b.x() {
      -1
    } else if a.x() > b.x() {
      1
    } else if a.y() < b.y() {
      -1
    } else if a.y() > b.y() {
      1
    } else {
      0
    }
  })
  let lower : Array[@core.Point2D] = []
  for p in pts {
    while lower.length() >= 2 &&
          @core.turn(lower[lower.length() - 2], lower[lower.length() - 1], p) <=
          0.0 {
      ignore(lower.remove(lower.length() - 1))
    }
    lower.push(p)
  }
  let upper : Array[@core.Point2D] = []
  let mut idx = pts.length() - 1
  while idx >= 0 {
    let p = pts[idx]
    while upper.length() >= 2 &&
          @core.turn(upper[upper.length() - 2], upper[upper.length() - 1], p) <=
          0.0 {
      ignore(upper.remove(upper.length() - 1))
    }
    upper.push(p)
    idx -= 1
  }
  let result : Array[@core.Point2D] = []
  for p in lower {
    result.push(p)
  }
  for i in 1..<(upper.length() - 1) {
    result.push(upper[i])
  }
  result
}

///|
/// Count the number of convex layers. / 计算凸包层次数。
pub fn layer_count(points : Array[@core.Point2D]) -> Int32 {
  convex_layers(points).length()
}

///|
/// Get the outermost layer (first convex hull). / 获取最外层（第一个凸包）。
pub fn outermost_layer(points : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let layers = convex_layers(points)
  if layers.length() > 0 {
    layers[0]
  } else {
    []
  }
}
