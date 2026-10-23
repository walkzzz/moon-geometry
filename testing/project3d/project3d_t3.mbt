///|
/// Project an array of 3D points to 2D using perspective projection. / 透视投影：将三维点数组投影到二维。
pub fn perspective_batch(
  points : Array[@core.Point3D],
  f : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    match perspective_project(p, f) {
      Some(pt) => result.push(pt)
      None => continue
    }
  }
  result
}
