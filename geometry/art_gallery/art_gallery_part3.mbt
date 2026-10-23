///|
/// Minimum number of guards for a convex polygon (always 1). / 凸多边形最少守卫数（始终为 1）。
pub fn art_gallery_convex_guards() -> Int32 {
  1
}

///|
/// Estimate guard count for a specific polygon. / 估计特定多边形的守卫数。
pub fn art_gallery_estimate(poly : Array[@core.Point2D]) -> Int32 {
  let n = poly.length()
  if n < 3 {
    return 0
  }
  let guards = art_gallery_place_guards(poly)
  if guards.length() == 0 {
    return 1
  }
  guards.length()
}
