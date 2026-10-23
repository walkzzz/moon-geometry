///|
pub fn cotangent_laplacian(
  center_val : Double,
  neighbor_vals : Array[Double],
  weights : Array[Double],
) -> Double {
  let n = neighbor_vals.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  let mut total_w = 0.0
  for i in 0..<n {
    sum += weights[i] * (neighbor_vals[i] - center_val)
    total_w += weights[i]
  }
  if total_w.abs() < 0.000000000001 {
    0.0
  } else {
    sum / total_w
  }
}
