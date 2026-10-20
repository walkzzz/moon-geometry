///| Filtered Predicates | 过滤谓词
///| Static and dynamic filters for robust geometric predicates
///| 静态和动态过滤用于鲁棒几何谓词

pub fn static_filter_bound(coords : Array[Double]) -> Double {
  let mut maxv = 0.0
  for c in coords {
    let a = c.abs()
    if a > maxv {
      maxv = a
    }
  }
  maxv * maxv * maxv * 3.33e-16
}

pub fn filtered_orientation(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  let bound = static_filter_bound([ax, ay, bx, by, cx, cy])
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else {
    0
  }
}

pub fn dynamic_filter(a : Double, b : Double, eps : Double) -> Bool {
  a.abs() > b.abs() * eps
}

pub fn filter_result(det : Double, bound : Double) -> Int {
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else {
    0
  }
}
