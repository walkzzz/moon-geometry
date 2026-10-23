///|
/// Project an array of 3D points to 2D using orthographic projection. / 正交投影：将三维点数组投影到二维。
pub fn orthographic_batch(
  points : Array[@core.Point3D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    result.push(orthographic(p))
  }
  result
}
