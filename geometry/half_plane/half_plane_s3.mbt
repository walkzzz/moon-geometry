///|
/// Intersection of multiple half-planes. Returns convex polygon vertices (CCW) or empty. / 半平面交。
pub fn half_plane_intersect(planes : Array[HalfPlane]) -> Array[@core.Point2D] {
  let big = 1000000.0
  let polygon : Array[@core.Point2D] = [
    @core.Point2D::new(-big, -big),
    @core.Point2D::new(big, -big),
    @core.Point2D::new(big, big),
    @core.Point2D::new(-big, big),
  ]
  let mut result = polygon
  for i in 0..<planes.length() {
    result = clip_by_half_plane(result, planes[i])
    if result.length() == 0 {
      return []
    }
  }
  result
}

fn clip_by_half_plane(
  poly : Array[@core.Point2D],
  hp : HalfPlane,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let cur = poly[i]
    let nxt = poly[(i + 1) % n]
    let cur_in = HalfPlane::contains(hp, cur)
    let nxt_in = HalfPlane::contains(hp, nxt)
    if cur_in {
      result.push(cur)
    }
    if cur_in != nxt_in {
      let dc = HalfPlane::eval(hp, cur)
      let dn = HalfPlane::eval(hp, nxt)
      let t = dc / (dc - dn)
      result.push(
        @core.Point2D::new(cur.x() + (nxt.x() - cur.x()) * t, cur.y() + (nxt.y() - cur.y()) * t),
      )
    }
  }
  result
}