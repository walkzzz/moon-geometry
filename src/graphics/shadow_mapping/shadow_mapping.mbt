///|
/// # Shadow Mapping | 阴影映射
/// Shadow mapping techniques. / 阴影映射技术。
///|
pub fn shadow_factor(depth : Double, shadow_map_depth : Double, bias : Double) -> Double {
  if depth - bias > shadow_map_depth { 0.0 } else { 1.0 }
}
///|
pub fn pcf_3x3(depths : Array[Array[Double]], ref_depth : Double, bias : Double) -> Double {
  let mut sum = 0.0; let mut count = 0.0
  for i in 0..<depths.length() {
    for j in 0..<depths[i].length() {
      sum += shadow_factor(ref_depth, depths[i][j], bias)
      count += 1.0
    }
  }
  if count.abs() < 0.000000000001 { 0.0 } else { sum / count }
}
///|
pub fn vsm_variance(depths : Array[Double]) -> Double {
  let n = depths.length().to_double()
  let mut mean = 0.0
  for i in 0..<depths.length() { mean += depths[i] }
  mean /= n
  let mut variance = 0.0
  for i in 0..<depths.length() {
    let d = depths[i] - mean
    variance += d * d
  }
  variance / n
}
///|
pub fn vsm_chebyshev(t : Double, mean : Double, variance : Double) -> Double {
  if t <= mean { 1.0 } else {
    if variance.abs() < 0.000000000001 { 0.0 } else {
      let d = t - mean
      variance / (variance + d * d)
    }
  }
}
