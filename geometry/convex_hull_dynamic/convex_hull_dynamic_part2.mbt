///|
/// Insert a point and update the hull. / 插入点并更新凸包。
pub fn DynamicHull::insert(dh : DynamicHull, p : @core.Point2D) -> Unit {
  dh.points.push(p)
  half_hull(dh)
}

///|
fn half_hull(dh : DynamicHull) -> Unit {
  let pts = dh.points.copy()
  if pts.length() <= 3 {
    dh.hull.clear()
    for p in pts {
      dh.hull.push(p)
    }
    return
  }
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
  dh.hull.clear()
  for p in lower {
    dh.hull.push(p)
  }
  for i in 1..<(upper.length() - 1) {
    dh.hull.push(upper[i])
  }
}
