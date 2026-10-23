///|
/// Hash a 2D point to a grid cell index. / 将二维点哈希到网格单元索引。
pub fn hash_point_2d(
  x : Double,
  y : Double,
  grid_size : Double,
) -> (Int32, Int32) {
  ((x / grid_size).floor().to_int(), (y / grid_size).floor().to_int())
}

///|
/// Compute basis-invariant coordinates of a point relative to a basis. / 计算点相对于基底的不变坐标。
pub fn hash_basis_invariant(
  p1x : Double,
  p1y : Double,
  p2x : Double,
  p2y : Double,
  p3x : Double,
  p3y : Double,
) -> (Double, Double) {
  let dx = p2x - p1x
  let dy = p2y - p1y
  let scale = (dx * dx + dy * dy).sqrt()
  if scale < 1.0e-10 {
    (0.0, 0.0)
  } else {
    let cos_a = dx / scale
    let sin_a = dy / scale
    let tx = (p3x - p1x) * cos_a + (p3y - p1y) * sin_a
    let ty = -(p3x - p1x) * sin_a + (p3y - p1y) * cos_a
    (tx / scale, ty / scale)
  }
}
