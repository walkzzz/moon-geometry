///|
/// 3x3 homography matrix for 2D projective transformations. / 用于二维射影变换的 3x3 单应矩阵。
pub struct Homography {
  h00 : Double
  h01 : Double
  h02 : Double
  h10 : Double
  h11 : Double
  h12 : Double
  h20 : Double
  h21 : Double
  h22 : Double
}

///|
/// Create identity homography. / 创建单位单应矩阵。
pub fn Homography::identity() -> Homography {
  {
    h00: 1.0,
    h01: 0.0,
    h02: 0.0,
    h10: 0.0,
    h11: 1.0,
    h12: 0.0,
    h20: 0.0,
    h21: 0.0,
    h22: 1.0,
  }
}

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
pub fn Homography::apply(m : Homography, p : @core.Point2D) -> @core.Point2D? {
  let w = m.h20 * p.x() + m.h21 * p.y() + m.h22
  if @core.approx_eq(w, 0.0, 0.000000001) {
    return None
  }
  let x = m.h00 * p.x() + m.h01 * p.y() + m.h02
  let y = m.h10 * p.x() + m.h11 * p.y() + m.h12
  Some(@core.Point2D::new(x / w, y / w))
}

///|
/// Compose two homographies (self after other). / 组合两个单应矩阵（先 other 后 self）。
pub impl @core.Composable for Homography with fn compose(self, other) {
  {
    h00: self.h00 * other.h00 + self.h01 * other.h10 + self.h02 * other.h20,
    h01: self.h00 * other.h01 + self.h01 * other.h11 + self.h02 * other.h21,
    h02: self.h00 * other.h02 + self.h01 * other.h12 + self.h02 * other.h22,
    h10: self.h10 * other.h00 + self.h11 * other.h10 + self.h12 * other.h20,
    h11: self.h10 * other.h01 + self.h11 * other.h11 + self.h12 * other.h21,
    h12: self.h10 * other.h02 + self.h11 * other.h12 + self.h12 * other.h22,
    h20: self.h20 * other.h00 + self.h21 * other.h10 + self.h22 * other.h20,
    h21: self.h20 * other.h01 + self.h21 * other.h11 + self.h22 * other.h21,
    h22: self.h20 * other.h02 + self.h21 * other.h12 + self.h22 * other.h22,
  }
}

///|
pub extend Homography with @core.Composable::{compose}

///|
/// Apply homography to an array of points. / 将单应矩阵应用于点数组。
pub fn Homography::apply_batch(
  m : Homography,
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    match m.apply(p) {
      Some(pt) => result.push(pt)
      None => continue
    }
  }
  result
}

///|
/// Compute homography determinant. / 计算单应矩阵行列式。
pub fn Homography::determinant(m : Homography) -> Double {
  m.h00 * (m.h11 * m.h22 - m.h12 * m.h21) -
  m.h01 * (m.h10 * m.h22 - m.h12 * m.h20) +
  m.h02 * (m.h10 * m.h21 - m.h11 * m.h20)
}
