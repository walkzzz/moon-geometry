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
