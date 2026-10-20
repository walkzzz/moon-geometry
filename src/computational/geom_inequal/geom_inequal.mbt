///| Geometric Inequalities | 几何不等式
///| Isoperimetric, Brunn-Minkowski, Cauchy-Schwarz for geometry
///| 等周、Brunn-Minkowski、Cauchy-Schwarz 几何版

pub fn brunn_minkowski(vol_a : Double, vol_b : Double) -> Double {
  (@math.pow(vol_a, 1.0 / 2.0) + @math.pow(vol_b, 1.0 / 2.0)) * (@math.pow(vol_a, 1.0 / 2.0) + @math.pow(vol_b, 1.0 / 2.0))
}

pub fn cauchy_schwarz(a1 : Double, a2 : Double, b1 : Double, b2 : Double) -> Double {
  let dot = a1 * b1 + a2 * b2
  let na = (a1 * a1 + a2 * a2).sqrt()
  let nb = (b1 * b1 + b2 * b2).sqrt()
  dot * dot - na * na * nb * nb
}

pub fn triangle_inequality(a : Double, b : Double, c : Double) -> Bool {
  a + b > c && a + c > b && b + c > a
}

pub fn ptolemy_inequality(a : Double, b : Double, c : Double, d : Double, e : Double, f : Double) -> Double {
  a * c + b * d - e * f
}

pub fn weitzenbock_inequality(a : Double, b : Double, c : Double, area : Double) -> Double {
  a * a + b * b + c * c - 4.0 * 1.7320508075688772 * area
}
