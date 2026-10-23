///|
/// Estimate 2D rotation and translation aligning source to target (Procrustes).
/// 估计对齐源到目标的 2D 旋转和平移（Procrustes）。
fn estimate_rigid(
  src : Array[@core.Point2D],
  tgt : Array[@core.Point2D],
  correspondences : Array[Int32],
) -> (Double, Double, Double) {
  let n = src.length()
  let mut sx = 0.0
  let mut sy = 0.0
  let mut tx = 0.0
  let mut ty = 0.0
  let mut cnt = 0.0
  for i in 0..<n {
    let j = correspondences[i]
    if j >= 0 {
      sx += src[i].x()
      sy += src[i].y()
      tx += tgt[j].x()
      ty += tgt[j].y()
      cnt += 1.0
    }
  }
  if cnt < 1.0 {
    return (0.0, 0.0, 0.0)
  }
  sx = sx / cnt
  sy = sy / cnt
  tx = tx / cnt
  ty = ty / cnt
  let mut num = 0.0
  let mut den = 0.0
  for i in 0..<n {
    let j = correspondences[i]
    if j >= 0 {
      let dx = src[i].x() - sx
      let dy = src[i].y() - sy
      let ex = tgt[j].x() - tx
      let ey = tgt[j].y() - ty
      num += dx * ey - dy * ex
      den += dx * ex + dy * ey
    }
  }
  let angle = if den.abs() < 0.000000000001 {
    0.0
  } else {
    @math.atan2(num, den)
  }
  (angle, tx - sx, ty - sy)
}
