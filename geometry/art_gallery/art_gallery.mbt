///|
/// Upper bound on guards needed for an n-vertex polygon: floor(n/3). / n 顶点多边形所需守卫数上界：floor(n/3)。
pub fn art_gallery_guard_count(n : Int) -> Int {
  if n < 3 {
    return 0
  }
  n / 3
}

///|
/// Place guards at every 3rd vertex (heuristic). / 每隔 3 个顶点放置一个守卫（启发式）。
pub fn art_gallery_place_guards(
  poly : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let guards : Array[@core.Point2D] = []
  let step = 3
  for i in 0..<n {
    if i % step == 0 {
      guards.push(poly[i])
    }
  }
  guards
}

///|
/// Check if a set of guards covers all vertices of a polygon. / 检查守卫集合是否覆盖多边形所有顶点。
pub fn art_gallery_covers_vertices(
  poly : Array[@core.Point2D],
  guards : Array[@core.Point2D],
) -> Bool {
  let n = poly.length()
  if n < 3 || guards.length() == 0 {
    return false
  }
  for v in poly {
    let mut found = false
    for g in guards {
      if g.dist(v) < 0.000000000001 {
        found = true
        break
      }
    }
    if !found {
      return false
    }
  }
  true
}

///|
/// Minimum number of guards for a convex polygon (always 1). / 凸多边形最少守卫数（始终为 1）。
pub fn art_gallery_convex_guards() -> Int {
  1
}

///|
/// Estimate guard count for a specific polygon. / 估计特定多边形的守卫数。
pub fn art_gallery_estimate(
  poly : Array[@core.Point2D],
) -> Int {
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