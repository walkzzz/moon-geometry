///| Robust Intersection | 鲁棒相交
///| Exact intersection point computation
///| 精确交点计算

pub fn robust_segment_intersect(a1x : Double, a1y : Double, a2x : Double, a2y : Double, b1x : Double, b1y : Double, b2x : Double, b2y : Double) -> (Double, Double, Bool) {
  let d1x = a2x - a1x
  let d1y = a2y - a1y
  let d2x = b2x - b1x
  let d2y = b2y - b1y
  let det = d1x * d2y - d2x * d1y
  if det.abs() < 1.0e-15 {
    (0.0, 0.0, false)
  } else {
    let t = ((b1x - a1x) * d2y - (b1y - a1y) * d2x) / det
    (a1x + t * d1x, a1y + t * d1y, true)
  }
}

pub fn robust_line_line(a1 : Double, b1 : Double, c1 : Double, a2 : Double, b2 : Double, c2 : Double) -> (Double, Double, Bool) {
  let det = a1 * b2 - a2 * b1
  if det.abs() < 1.0e-15 {
    (0.0, 0.0, false)
  } else {
    ((c1 * b2 - c2 * b1) / det, (a1 * c2 - a2 * c1) / det, true)
  }
}

pub fn robust_point_on_segment(px : Double, py : Double, ax : Double, ay : Double, bx : Double, by : Double) -> Bool {
  let cross = (bx - ax) * (py - ay) - (by - ay) * (px - ax)
  if cross.abs() > 1.0e-10 {
    false
  } else {
    let dot = (px - ax) * (bx - ax) + (py - ay) * (by - ay)
    let len_sq = (bx - ax) * (bx - ax) + (by - ay) * (by - ay)
    dot >= -1.0e-10 && dot <= len_sq + 1.0e-10
  }
}
