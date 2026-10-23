///|
/// Apply homography to an array of points. / 将单应矩阵应用于点数组。
pub fn Homography::apply_batch(
  m : Homography,
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    match m.apply(p) {
      Some(pt) => result.push(pt)
      None => continue
    }
  }
  result
}
