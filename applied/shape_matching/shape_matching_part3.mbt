///|
/// Find closest point in target to a source point. / 在目标中找离源点最近的点。
fn closest_idx(
  target : Array[@core.Point2D],
  p : @core.Point2D,
) -> Int {
  let mut best = 0
  let mut best_d = 1.7976931348623157e+308
  for j in 0..<target.length() {
    let d = p.dist_sq(target[j])
    if d < best_d {
      best_d = d
      best = j
    }
  }
  best
}
