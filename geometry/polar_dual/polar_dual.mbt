///|
/// Polar dual of a point (assuming origin inside). / 点的极对偶。
pub fn polar_dual_point(p : @core.Point2D) -> @core.Point2D {
  let d = p.x() * p.x() + p.y() * p.y()
  if d < 0.000000000001 {
    return @core.Point2D::new(0.0, 0.0)
  }
  @core.Point2D::new(p.x() / d, p.y() / d)
}

///|
/// Polar dual of a convex polygon (assuming origin inside). / 凸多边形的极对偶。
pub fn polar_dual(poly : @core.Polygon) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.vertices.length()
  for i in 0..<n {
    result.push(polar_dual_point(poly.vertices[i]))
  }
  result
}

///|
/// Inverse polar dual of a point. / 点的逆极对偶。
pub fn inverse_polar_dual_point(p : @core.Point2D) -> @core.Point2D {
  polar_dual_point(p)
}

///|
/// Inverse polar dual of a polygon. / 多边形的逆极对偶。
pub fn inverse_polar_dual(poly : @core.Polygon) -> Array[@core.Point2D] {
  polar_dual(poly)
}

///|
/// Check if origin is inside a polygon. / 检查原点是否在多边形内。
pub fn origin_inside(poly : @core.Polygon) -> Bool {
  let n = poly.vertices.length()
  let mut inside = false
  let px = 0.0
  let py = 0.0
  for i in 0..<n {
    let j = (i + n - 1) % n
    let xi = poly.vertices[i].x()
    let yi = poly.vertices[i].y()
    let xj = poly.vertices[j].x()
    let yj = poly.vertices[j].y()
    if (yi > py) != (yj > py) {
      let x_cross = (xj - xi) * (py - yi) / (yj - yi) + xi
      if px < x_cross {
        inside = !inside
      }
    }
  }
  inside
}

///|
/// Dual area (sum of 1/|v_i|^2 for polygon vertices). / 对偶面积。
pub fn dual_area(poly : @core.Polygon) -> Double {
  let mut sum = 0.0
  let n = poly.vertices.length()
  for i in 0..<n {
    let d = poly.vertices[i].x() * poly.vertices[i].x() +
      poly.vertices[i].y() * poly.vertices[i].y()
    if d > 0.000000000001 {
      sum += 1.0 / d
    }
  }
  sum
}
