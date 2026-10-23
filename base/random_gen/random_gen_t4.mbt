///|
/// Generate a random convex polygon with n vertices. / 生成 n 个顶点的随机凸多边形。
pub fn Rng::random_convex_polygon(
  r : Rng,
  n : Int32,
  radius : Double,
) -> Array[@core.Point2D] {
  let angles : Array[Double] = []
  for _ in 0..<n {
    angles.push(r.range_double(0.0, 6.283185307179586))
  }
  angles.sort()
  let result : Array[@core.Point2D] = []
  for a in angles {
    result.push(
      @core.Point2D::new(radius * @math.cos(a), radius * @math.sin(a)),
    )
  }
  result
}
