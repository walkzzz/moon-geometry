///|
/// Create homography from 9 matrix elements (row-major). / 由 9 个矩阵元素（行优先）创建单应矩阵。
pub fn Homography::from_array(h : Array[Double]) -> Homography {
  {
    h00: h[0],
    h01: h[1],
    h02: h[2],
    h10: h[3],
    h11: h[4],
    h12: h[5],
    h20: h[6],
    h21: h[7],
    h22: h[8],
  }
}


///|
/// Apply homography to a 2D point. / 将单应矩阵应用于二维点。
pub fn Homography::apply(
  m : Homography,
  p : @core.Point2D,
) -> @core.Point2D? {
  let w = m.h20 * p.x() + m.h21 * p.y() + m.h22
  if @core.approx_eq(w, 0.0, 0.000000001) {
    return None
  }
  let x = m.h00 * p.x() + m.h01 * p.y() + m.h02
  let y = m.h10 * p.x() + m.h11 * p.y() + m.h12
  Some(@core.Point2D::new(x / w, y / w))
}
