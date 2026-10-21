///| Conformal Geometry | 共形几何
///| Angle-preserving maps, Riemann mapping, conformal invariants
///| 保角映射、Riemann 映射、共形不变量

///| Check if a 2x2 matrix is conformal. / 检查 2x2 矩阵是否共形。
pub fn is_conformal(a : Double, b : Double, c : Double, d : Double) -> Bool {
  (a - d).abs() < 1.0e-10 && (b + c).abs() < 1.0e-10
}

///| Apply Möbius transformation to a complex point. / 对复数点施加 Möbius 变换。
pub fn mobius_transform(zx : Double, zy : Double, a : Double, b : Double) -> (Double, Double) {
  let denom = a * a + b * b
  let rx = (a * zx + b * zy) / denom
  let ry = (a * zy - b * zx) / denom
  (rx, ry)
}

///| Compute conformal scale factor at radius r. / 计算半径 r 处的共形缩放因子。
pub fn conformal_factor(r : Double, scale : Double) -> Double {
  scale / (r * r + 1.0e-10)
}

///| Compute angle between two 2D vectors. / 计算两个二维向量之间的夹角。
pub fn angle_preserving(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> Double {
  let dot = a1x * a2x + a1y * a2y
  let m1 = (a1x * a1x + a1y * a1y).sqrt()
  let m2 = (a2x * a2x + a2y * a2y).sqrt()
  if m1 < 1.0e-10 || m2 < 1.0e-10 {
    0.0
  } else {
    @math.acos(dot / (m1 * m2))
  }
}

///| Sum exponents for Schwarz-Christoffel mapping. / 求和 Schwarz-Christoffel 映射的指数。
pub fn schwarz_christoffel_alpha(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for a in angles {
    sum += a
  }
  sum
}
