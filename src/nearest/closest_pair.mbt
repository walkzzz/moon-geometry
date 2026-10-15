///|
/// Brute-force closest pair O(n^2). Used as fallback and for validation.
fn closest_pair_brute(
  pts : Array[@core.Point2D],
  lo : Int,
  hi : Int,
) -> (@core.Point2D, @core.Point2D, Double)? {
  if hi <= lo {
    return None
  }
  let mut best = pts[lo].dist_sq(pts[lo + 1])
  let mut bi = lo
  let mut bj = lo + 1
  for i in lo..<hi {
    for j in (i + 1)..<=hi {
      let d = pts[i].dist_sq(pts[j])
      if d < best {
        best = d
        bi = i
        bj = j
      }
    }
  }
  Some((pts[bi], pts[bj], best.sqrt()))
}

///|
/// Closest pair of points via divide and conquer. O(n log n).
/// Returns the closest pair and their distance, or None if fewer than 2 points.
/// 返回最近点对及其距离，少于 2 点返回 None。
pub fn closest_pair(points : Array[@core.Point2D]) -> (@core.Point2D, @core.Point2D, Double)? {
  let n = points.length()
  if n < 2 {
    return None
  }
  if n <= 3 {
    return closest_pair_brute(points, 0, n - 1)
  }
  let pts = points.copy()
  pts.sort_by(fn(a, b) {
    if a.x < b.x {
      -1
    } else if a.x > b.x {
      1
    } else if a.y < b.y {
      -1
    } else if a.y > b.y {
      1
    } else {
      0
    }
  })
  closest_pair_rec(pts, 0, n - 1)
}

///|
/// Recursive core of closest pair divide and conquer.
fn closest_pair_rec(
  pts : Array[@core.Point2D],
  lo : Int,
  hi : Int,
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
