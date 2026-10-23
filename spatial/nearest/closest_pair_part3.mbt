///|
/// Recursive core of closest pair divide and conquer.
/// 最近点对分治法的递归核心。
fn closest_pair_rec(
  pts : Array[@core.Point2D],
  lo : Int32,
  hi : Int32,
) -> (@core.Point2D, @core.Point2D, Double)? {
  if hi - lo < 3 {
    return closest_pair_brute(pts, lo, hi)
  }
  let mid = (lo + hi) / 2
  let midx = pts[mid].x
  let left = closest_pair_rec(pts, lo, mid)
  let right = closest_pair_rec(pts, mid + 1, hi)
  let (init_p1, init_p2, init_sq) = match (left, right) {
    (Some((p1, p2, d)), Some((q1, q2, e))) =>
      if d < e {
        (p1, p2, d * d)
      } else {
        (q1, q2, e * e)
      }
    (Some((p1, p2, d)), None) => (p1, p2, d * d)
    (None, Some((q1, q2, e))) => (q1, q2, e * e)
    (None, None) => return None
  }
  let mut bp1 = init_p1
  let mut bp2 = init_p2
  let mut best_sq = init_sq
  let best_d = best_sq.sqrt()
  // Collect points within strip [midx - d, midx + d]
  let strip : Array[@core.Point2D] = []
  for i in lo..<=hi {
    if (pts[i].x - midx).abs() < best_d {
      strip.push(pts[i])
    }
  }
  // Sort strip by y
  strip.sort_by(fn(a, b) {
    if a.y < b.y {
      -1
    } else if a.y > b.y {
      1
    } else {
      0
    }
  })
  for i in 0..<strip.length() {
    let mut j = i + 1
    while j < strip.length() && strip[j].y - strip[i].y < best_sq.sqrt() {
      let d = strip[i].dist_sq(strip[j])
      if d < best_sq {
        best_sq = d
        bp1 = strip[i]
        bp2 = strip[j]
      }
      j += 1
    }
  }
  Some((bp1, bp2, best_sq.sqrt()))
}
