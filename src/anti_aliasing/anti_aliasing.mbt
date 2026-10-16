///|
/// # Anti-Aliasing | 抗锯齿
/// Anti-aliasing techniques. / 抗锯齿技术。
///|
pub fn fxaa_luma(rgb : (Double, Double, Double)) -> Double {
  rgb.1 * 0.299 + rgb.0 * 0.587 + rgb.2 * 0.114
}
///|
pub fn msaa_average(samples : Array[(Double, Double, Double)]) -> (Double, Double, Double) {
  let n = samples.length().to_double()
  let mut r = 0.0; let mut g = 0.0; let mut b = 0.0
  for i in 0..<samples.length() {
    r += samples[i].0; g += samples[i].1; b += samples[i].2
  }
  if n.abs() < 0.000000000001 { (0.0, 0.0, 0.0) } else { (r / n, g / n, b / n) }
}
///|
pub fn ssaa_weight_blend(c1 : (Double, Double, Double), c2 : (Double, Double, Double), w : Double) -> (Double, Double, Double) {
  (c1.0 * (1.0 - w) + c2.0 * w, c1.1 * (1.0 - w) + c2.1 * w, c1.2 * (1.0 - w) + c2.2 * w)
}
///|
pub fn taa_resolve(history : (Double, Double, Double), current : (Double, Double, Double), alpha : Double) -> (Double, Double, Double) {
  (history.0 * alpha + current.0 * (1.0 - alpha),
   history.1 * alpha + current.1 * (1.0 - alpha),
   history.2 * alpha + current.2 * (1.0 - alpha))
}
