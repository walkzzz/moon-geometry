///|
/// Exact incircle predicate for points a, b, c, d. / 精确圆内判定，测试点 d 相对 a, b, c 外接圆的位置。
pub fn exact_incircle(
  ax : Double,
  ay : Double,
  bx : Double,
  by : Double,
  cx : Double,
  cy : Double,
  dx : Double,
  dy : Double,
) -> Int32 {
  let adx = ax - dx
  let ady = ay - dy
  let bdx = bx - dx
  let bdy = by - dy
  let cdx = cx - dx
  let cdy = cy - dy
  let alift = adx * adx + ady * ady
  let blift = bdx * bdx + bdy * bdy
  let clift = cdx * cdx + cdy * cdy
  let det = alift * (bdx * cdy - cdx * bdy) -
    blift * (adx * cdy - cdx * ady) +
    clift * (adx * bdy - bdx * ady)
  if det > 0.0 {
    1
  } else if det < 0.0 {
    -1
  } else {
    0
  }
}
