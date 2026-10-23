///|
/// Procrustes alignment: find rotation, translation, scale minimizing
/// sum ||tgt_i - (s * R * src_i + t)||^2.
/// Procrustes 对齐：求使 sum ||tgt_i - (s*R*src_i + t)||^2 最小的旋转、平移、缩放。
pub fn procrustes(
  src : Array[@core.Point2D],
  tgt : Array[@core.Point2D],
) -> ProcrustesResult {
  let n = src.length()
  if n == 0 || n != tgt.length() {
    return ProcrustesResult::new(0.0, 0.0, 0.0, 1.0, 0.0)
  }
  let src_c = centroid(src)
  let tgt_c = centroid(tgt)
  let mut num = 0.0
  let mut den = 0.0
  let mut src_norm_sq = 0.0
  let mut tgt_norm_sq = 0.0
  for i in 0..<n {
    let dx = src[i].x() - src_c.x()
    let dy = src[i].y() - src_c.y()
    let ex = tgt[i].x() - tgt_c.x()
    let ey = tgt[i].y() - tgt_c.y()
    num += dx * ey - dy * ex
    den += dx * ex + dy * ey
    src_norm_sq += dx * dx + dy * dy
    tgt_norm_sq += ex * ex + ey * ey
  }
  let rotation = if den.abs() < 0.000000000001 && num.abs() < 0.000000000001 {
    0.0
  } else {
    @math.atan2(num, den)
  }
  let scale = if src_norm_sq < 0.000000000001 {
    1.0
  } else {
    (tgt_norm_sq / src_norm_sq).sqrt()
  }
  let c = @math.cos(rotation)
  let s = @math.sin(rotation)
  let tx = tgt_c.x() - scale * (c * src_c.x() - s * src_c.y())
  let ty = tgt_c.y() - scale * (s * src_c.x() + c * src_c.y())
  let mut err_sq = 0.0
  for i in 0..<n {
    let px = scale * (c * src[i].x() - s * src[i].y()) + tx
    let py = scale * (s * src[i].x() + c * src[i].y()) + ty
    let dx = tgt[i].x() - px
    let dy = tgt[i].y() - py
    err_sq += dx * dx + dy * dy
  }
  let error = (err_sq / n.to_double()).sqrt()
  ProcrustesResult::new(rotation, tx, ty, scale, error)
}
