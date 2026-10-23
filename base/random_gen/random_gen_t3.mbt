///|
/// Generate a random 2D point in [x_lo, x_hi) × [y_lo, y_hi). / 生成 [x_lo, x_hi) × [y_lo, y_hi) 中的随机二维点。
pub fn Rng::point2d(
  r : Rng,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
) -> @core.Point2D {
  @core.Point2D::new(r.range_double(x_lo, x_hi), r.range_double(y_lo, y_hi))
}

///|
/// Generate n random 2D points in a rectangle. / 在矩形中生成 n 个随机二维点。
pub fn Rng::random_points(
  r : Rng,
  n : Int32,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for _ in 0..<n {
    result.push(r.point2d(x_lo, x_hi, y_lo, y_hi))
  }
  result
}
