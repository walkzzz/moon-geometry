///|
/// EMD for 1D weighted distributions. / 一维加权分布的 EMD。
pub fn emd_weighted(
  positions : Array[Double],
  weights_a : Array[Double],
  weights_b : Array[Double],
) -> Double {
  let n = positions.length()
  if n == 0 {
    return 0.0
  }
  let mut result = 0.0
  let mut cum_a = 0.0
  let mut cum_b = 0.0
  for i in 0..<n {
    cum_a += weights_a[i]
    cum_b += weights_b[i]
    result += (cum_a - cum_b).abs()
  }
  result
}
