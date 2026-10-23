///|
/// Compute local point density (count within radius). / 计算局部点密度（半径内点数）。
pub fn local_density(
  points : Array[@core.Point3D],
  center : @core.Point3D,
  radius : Double,
) -> Int32 {
  let mut count = 0
  for i in 0..<points.length() {
    if points[i].dist(center) < radius {
      count += 1
    }
  }
  count
}
