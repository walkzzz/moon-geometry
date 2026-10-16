///|
/// # Radial Basis Function Interpolation
/// # 径向基函数插值
///
/// RBF interpolation for scattered data approximation.
/// 散乱数据近似的径向基函数插值。

///|
pub fn rbf_interpolate_gaussian(r : Double, eps : Double) -> Double {
  @math.exp(-eps * eps * r * r)
}

///|
pub fn rbf_interpolate_multiquadric(r : Double, eps : Double) -> Double {
  (1.0 + eps * eps * r * r).sqrt()
}

///|
pub fn rbf_interpolate_inverse_multiquadric(r : Double, eps : Double) -> Double {
  1.0 / (1.0 + eps * eps * r * r).sqrt()
}

///|
pub fn rbf_interpolate_polyharmonic(r : Double, k : Int) -> Double {
  if k == 3 {
    if r < 0.000000000001 { 0.0 } else { r * r * r }
  } else if k == 5 {
    if r < 0.000000000001 { 0.0 } else { r * r * r * r * r }
  } else {
    if r < 0.000000000001 { 0.0 } else { r * r * @math.ln(r) }
  }
}

///|
pub fn rbf_condition_number_estimate(centers : Array[(Double, Double)], eps : Double) -> Double {
  let mut min_dist = 999999999.0
  let mut max_dist = 0.0
  for i in 0..<centers.length() {
    for j in 0..<centers.length() {
      if i != j {
        let (x1, y1) = centers[i]
        let (x2, y2) = centers[j]
        let d = ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)).sqrt()
        if d < min_dist { min_dist = d }
        if d > max_dist { max_dist = d }
      }
    }
  }
  if min_dist < 0.000000000001 { 999999999.0 } else { max_dist / min_dist * eps }
}
