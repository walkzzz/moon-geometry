///|
/// Robust 3D orientation sign of tetrahedron a, b, c, d. / 鲁棒三维定向符号判定四面体 a, b, c, d 的方向。
pub fn robust_orient3d(
  ax : Double,
  ay : Double,
  az : Double,
  bx : Double,
  by : Double,
  bz : Double,
  cx : Double,
  cy : Double,
  cz : Double,
  dx : Double,
  dy : Double,
  dz : Double,
) -> Int32 {
  let adx = bx - ax
  let ady = by - ay
  let adz = bz - az
  let bdx = cx - ax
  let bdy = cy - ay
  let bdz = cz - az
  let cdx = dx - ax
  let cdy = dy - ay
  let cdz = dz - az
  let det = adx * (bdy * cdz - bdz * cdy) -
    ady * (bdx * cdz - bdz * cdx) +
    adz * (bdx * cdy - bdy * cdx)
  if det > 1.0e-12 {
    1
  } else if det < -1.0e-12 {
    -1
  } else {
    0
  }
}
