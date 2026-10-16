///|
/// Simple linear congruential generator for reproducible random numbers. / 简单线性同余生成器，用于可复现随机数。
pub struct Rng {
  mut state : UInt
}

///|
/// Create a new RNG with a seed. / 用种子创建新 RNG。
pub fn Rng::new(seed : UInt) -> Rng {
  { state: seed }
}

///|
/// Generate next random UInt. / 生成下一个随机 UInt。
pub fn Rng::next_uint(r : Rng) -> UInt {
  r.state = r.state * 1103515245U + 12345U
  r.state
}

///|
/// Generate a random Double in [0, 1). / 生成 [0, 1) 中的随机 Double。
pub fn Rng::next_double(r : Rng) -> Double {
  let v = r.next_uint()
  (v % 1000000U).to_double() / 1000000.0
}

///|
/// Generate a random Double in [lo, hi). / 生成 [lo, hi) 中的随机 Double。
pub fn Rng::range_double(r : Rng, lo : Double, hi : Double) -> Double {
  lo + r.next_double() * (hi - lo)
}

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
  n : Int,
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

///|
/// Generate a random convex polygon with n vertices. / 生成 n 个顶点的随机凸多边形。
pub fn Rng::random_convex_polygon(
  r : Rng,
  n : Int,
  radius : Double,
) -> Array[@core.Point2D] {
  let angles : Array[Double] = []
  for _ in 0..<n {
    angles.push(r.range_double(0.0, 6.283185307179586))
  }
  angles.sort()
  let result : Array[@core.Point2D] = []
  for a in angles {
    result.push(@core.Point2D::new(radius * @math.cos(a), radius * @math.sin(a)))
  }
  result
}

///|
/// Generate random points on a circle. / 在圆上生成随机点。
pub fn Rng::random_points_on_circle(
  r : Rng,
  n : Int,
  center : @core.Point2D,
  radius : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for _ in 0..<n {
    let angle = r.range_double(0.0, 6.283185307179586)
    result.push(@core.Point2D::new(center.x() + radius * @math.cos(angle), center.y() + radius * @math.sin(angle)))
  }
  result
}