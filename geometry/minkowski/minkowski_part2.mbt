///|
/// Find the index of the bottom-most (then left-most) vertex.
/// 查找最底（然后最左）顶点的索引。
fn bottom_left_index(pts : Array[@core.Point2D]) -> Int {
  let n = pts.length()
  let mut best = 0
  for i in 1..<n {
    if pts[i].y() < pts[best].y() ||
      (pts[i].y() == pts[best].y() && pts[i].x() < pts[best].x()) {
      best = i
    }
  }
  best
}


///|
/// Edge angle of vertex at index i in CCW polygon.
/// Returns angle in [0, 2*PI). / CCW 多边形中顶点 i 的边角度，返回 [0, 2*PI)。
fn edge_angle(pts : Array[@core.Point2D], i : Int) -> Double {
  let n = pts.length()
  let dx = pts[(i + 1) % n].x() - pts[i].x()
  let dy = pts[(i + 1) % n].y() - pts[i].y()
  let angle = @math.atan2(dy, dx)
  if angle < 0.0 {
    angle + 2.0 * 3.141592653589793
  } else {
    angle
  }
}
