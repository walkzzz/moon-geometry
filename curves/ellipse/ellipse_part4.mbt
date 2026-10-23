///|
/// Intersection of the ellipse with a line (a*x + b*y + c = 0).
/// Returns 0, 1, or 2 intersection points.
/// 椭圆与直线交点（0/1/2 个）。
pub fn Ellipse::line_intersect(
  self : Ellipse,
  line : @core.Line,
) -> Array[@core.Point2D] {
  let c = @math.cos(self.angle)
  let s = @math.sin(self.angle)
  let la = line.a
  let lb = line.b
  let lc = line.c
  let cx = self.center.x()
  let cy = self.center.y()
  let a = self.a
  let b = self.b
  let la_rot = la * c + lb * s
  let lb_rot = -la * s + lb * c
  let lc_rot = la * cx + lb * cy + lc
  let a_sq = a * a
  let b_sq = b * b
  let aa = la_rot * la_rot * b_sq + lb_rot * lb_rot * a_sq
  let bb = 2.0 * la_rot * lb_rot * (b_sq - a_sq)
  let cc = lb_rot * lb_rot * b_sq + la_rot * la_rot * a_sq
  let dd = lc_rot * lc_rot
  let result : Array[@core.Point2D] = []
  if @core.approx_eq(aa, 0.0, 0.000000000000001) {
    if @core.approx_eq(lb_rot, 0.0, 0.000000000000001) {
      return result
    }
    let y_local = -lc_rot / lb_rot
    let val = 1.0 - y_local * y_local / b_sq
    if val < 0.0 {
      return result
    }
    let x_local = a * val.sqrt()
    let wx1 = x_local * c - y_local * s + cx
    let wy1 = x_local * s + y_local * c + cy
    result.push(@core.Point2D::new(wx1, wy1))
    if val > 0.0 {
      let wx2 = -x_local * c - y_local * s + cx
      let wy2 = -x_local * s + y_local * c + cy
      result.push(@core.Point2D::new(wx2, wy2))
    }
    return result
  }
  let disc = bb * bb - 4.0 * aa * (cc - dd * a_sq * b_sq / aa)
  if disc < 0.0 {
    return result
  }
  let sqrt_disc = disc.sqrt()
  let x1 = (-bb + sqrt_disc) / (2.0 * aa)
  let x2 = (-bb - sqrt_disc) / (2.0 * aa)
  for x_local in [x1, x2] {
    let val = 1.0 - x_local * x_local / a_sq
    if val >= 0.0 {
      let y_local = b * val.sqrt()
      let wx = x_local * c - y_local * s + cx
      let wy = x_local * s + y_local * c + cy
      result.push(@core.Point2D::new(wx, wy))
      if val > 0.0 {
        let wx2 = x_local * c + y_local * s + cx
        let wy2 = x_local * s - y_local * c + cy
        result.push(@core.Point2D::new(wx2, wy2))
      }
    }
  }
  result
}
