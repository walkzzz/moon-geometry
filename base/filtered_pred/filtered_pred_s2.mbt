///| Static error bound from coordinate magnitudes. / 由坐标幅值计算静态误差界。
pub fn static_filter_bound(coords : Array[Double]) -> Double {
  let mut maxv = 0.0
  for c in coords {
    let a = c.abs()
    if a > maxv {
      maxv = a
    }
  }
  maxv * maxv * maxv * 3.33e-16
}
