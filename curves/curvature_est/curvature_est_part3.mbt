///|
/// Principal curvatures from Gaussian (K) and mean (H). / 从高斯曲率K和平均曲率H求主曲率。
pub fn principal_curvatures(k_gaussian : Double, k_mean : Double) -> (Double, Double) {
  let disc = k_mean * k_mean - k_gaussian
  if disc < 0.0 {
    return (k_mean, k_mean)
  }
  let s = disc.sqrt()
  (k_mean + s, k_mean - s)
}
