///| Conformal Geometry | 共形几何
///| Angle-preserving maps, Riemann mapping, conformal invariants
///| 保角映射、Riemann 映射、共形不变量

pub fn is_conformal(a : Double, b : Double, c : Double, d : Double) -> Bool {
  (a - d).abs() < 1.0e-10 && (b + c).abs() < 1.0e-10
}

pub fn mobius_transform(zx : Double, zy : Double, a : Double, b : Double) -> (Double, Double) {
  let denom = a * a + b * b
  let rx = (a * zx + b * zy) / denom
  let ry = (a * zy - b * zx) / denom
  (rx, ry)
}

pub fn conformal_factor(r : Double, scale : Double) -> Double {
  scale / (r * r + 1.0e-10)
}

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

pub fn schwarz_christoffel_alpha(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for a in angles {
    sum += a
  }
  sum
}
