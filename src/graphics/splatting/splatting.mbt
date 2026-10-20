///|
/// # Splatting | 点泼溅
/// Point splatting for rendering. / 点泼溅渲染。
///|
pub fn gaussian_splat(x : Double, y : Double, sigma : Double) -> Double {
  @math.exp(-(x * x + y * y) / (2.0 * sigma * sigma))
}
///|
pub fn splat_radius(screen_space_size : Double, depth : Double) -> Double {
  if depth.abs() < 0.000000000001 { 0.0 } else { screen_space_size / depth }
}
///|
pub fn splat_coverage(px : Double, py : Double, cx : Double, cy : Double, r : Double) -> Double {
  let dx = px - cx; let dy = py - cy
  let d = (dx * dx + dy * dy).sqrt()
  if d > r { 0.0 } else { 1.0 - d / r }
}
///|
pub fn splat_alpha_blend(src_alpha : Double, dst_alpha : Double) -> Double {
  src_alpha + dst_alpha * (1.0 - src_alpha)
}
