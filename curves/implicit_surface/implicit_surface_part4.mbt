///|
/// Sample points on the surface within a box by rejection + Newton projection.
/// 在包围盒内通过拒绝采样加牛顿投影采样曲面上的点。
pub fn sample_surface(
  f : (Double, Double, Double) -> Double,
  fx : (Double, Double, Double) -> Double,
  fy : (Double, Double, Double) -> Double,
  fz : (Double, Double, Double) -> Double,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  z_lo : Double,
  z_hi : Double,
  n_samples : Int32,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  let n_side = if n_samples > 1 { n_samples } else { 2 }
  let dx = (x_hi - x_lo) / n_side.to_double()
  let dy = (y_hi - y_lo) / n_side.to_double()
  let dz = (z_hi - z_lo) / n_side.to_double()
  let mut x = x_lo
  while x < x_hi {
    let mut y = y_lo
    while y < y_hi {
      let mut z = z_lo
      while z < z_hi {
        let v = f(x, y, z)
        if v.abs() < 0.1 {
          let proj = project_to_surface(
            f,
            fx,
            fy,
            fz,
            @core.Point3D::new(x, y, z),
            10,
          )
          result.push(proj)
        }
        z += dz
      }
      y += dy
    }
    x += dx
  }
  result
}
