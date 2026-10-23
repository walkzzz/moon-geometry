///|
/// Min and max elevation in the TIN. / TIN 中的最低和最高高程。
pub fn TIN::elevation_range(t : TIN) -> (Double, Double) {
  let n = t.points.length()
  if n == 0 {
    return (0.0, 0.0)
  }
  let mut zmin = t.points[0].z
  let mut zmax = t.points[0].z
  for i in 1..<n {
    let z = t.points[i].z
    if z < zmin {
      zmin = z
    }
    if z > zmax {
      zmax = z
    }
  }
  (zmin, zmax)
}
