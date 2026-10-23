///|
/// Smooth a path using uniform cubic B-spline. / 使用均匀三次 B 样条平滑路径。
pub fn bspline_smooth(
  path : Array[@core.Point2D],
  num_samples : Int32,
) -> Array[@core.Point2D] {
  let n = path.length()
  if n < 2 {
    return path
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<(n - 1) {
    let p0 = if i == 0 { path[0] } else { path[i - 1] }
    let p1 = path[i]
    let p2 = path[i + 1]
    let p3 = if i + 2 < n { path[i + 2] } else { path[n - 1] }
    for s in 0..<num_samples {
      let t = s.to_double() / num_samples.to_double()
      let pt = bspline_point(p0, p1, p2, p3, t)
      result.push(pt)
    }
  }
  result.push(path[n - 1])
  result
}

///|
fn bspline_point(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  t : Double,
) -> @core.Point2D {
  let t2 = t * t
  let t3 = t2 * t
  let b0 = (1.0 - t) * (1.0 - t) * (1.0 - t) / 6.0
  let b1 = (3.0 * t3 - 6.0 * t2 + 4.0) / 6.0
  let b2 = (-3.0 * t3 + 3.0 * t2 + 3.0 * t + 1.0) / 6.0
  let b3 = t3 / 6.0
  @core.Point2D::new(
    b0 * p0.x() + b1 * p1.x() + b2 * p2.x() + b3 * p3.x(),
    b0 * p0.y() + b1 * p1.y() + b2 * p2.y() + b3 * p3.y(),
  )
}
