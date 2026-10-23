///|
/// Compute homography determinant. / 计算单应矩阵行列式。
pub fn Homography::determinant(m : Homography) -> Double {
  m.h00 * (m.h11 * m.h22 - m.h12 * m.h21) -
  m.h01 * (m.h10 * m.h22 - m.h12 * m.h20) +
  m.h02 * (m.h10 * m.h21 - m.h11 * m.h20)
}
