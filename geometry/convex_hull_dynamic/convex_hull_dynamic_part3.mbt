///|
/// Get the current convex hull. / 获取当前凸包。
pub fn DynamicHull::get_hull(dh : DynamicHull) -> Array[@core.Point2D] {
  dh.hull
}


///|
/// Get the number of points. / 获取点数。
pub fn DynamicHull::size(dh : DynamicHull) -> Int {
  dh.points.length()
}


///|
/// Check if a point is inside the hull. / 检查点是否在凸包内。
pub fn DynamicHull::contains(
  dh : DynamicHull,
  p : @core.Point2D,
) -> Bool {
  let h = dh.hull
  let n = h.length()
  if n < 3 {
    return false
  }
  for i in 0..<n {
    let j = (i + 1) % n
    if @core.turn(h[i], h[j], p) < 0.0 {
      return false
    }
  }
  true
}