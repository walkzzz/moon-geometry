///|
/// Mean curvature of the implicit surface at a point.
/// H = (|grad|^2 * trace(H) - grad^T * H * grad) / (2 * |grad|^3)
/// 隐式曲面在一点处的平均曲率。
pub fn mean_curvature(
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  fxx : (Double, Double, Double) -> Double,
  fyy : (Double, Double, Double) -> Double,
  fzz : (Double, Double, Double) -> Double,
  p : @core.Point3D,
) -> Double {
  let x = p.x
  let y = p.y
  let z = p.z
  let a = fx(x, y, z)
  let b = fy(x, y, z)
  let c = fz(x, y, z)
  let aa = fxx(x, y, z)
  let bb = fyy(x, y, z)
  let cc = fzz(x, y, z)
  let g2 = a * a + b * b + c * c
  if g2 < 0.0000000001 {
    return 0.0
  }
  let g3 = g2 * g2.sqrt()
  let trace_h = aa + bb + cc
  let quad = a * a * aa + b * b * bb + c * c * cc
  (g2 * trace_h - quad) / (2.0 * g3)
}


///|
/// Principal curvatures (k1, k2) from Gaussian and mean curvature.
/// 由高斯曲率和平均曲率求主曲率 (k1, k2)。
pub fn principal_curvatures(k_gauss : Double, k_mean : Double) -> (Double, Double) {
  let disc = k_mean * k_mean - k_gauss
  if disc < 0.0 {
    return (k_mean, k_mean)
  }
  let sq = disc.sqrt()
  (k_mean + sq, k_mean - sq)
}
