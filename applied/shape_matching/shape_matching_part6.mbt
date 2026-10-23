///|
/// 2D ICP shape matching: iteratively align source to target.
/// 二维 ICP 形状匹配：迭代对齐源到目标。
///
/// Returns array of target indices for each source point.
/// 返回每个源点对应的目标点索引。
pub fn shape_matching_icp(
  source : Array[@core.Point2D],
  target : Array[@core.Point2D],
  max_iter : Int32,
) -> Array[Int32] {
  let n = source.length()
  let aligned : Array[@core.Point2D] = []
  for p in source {
    aligned.push(p)
  }
  for _ in 0..<max_iter {
    let correspondences : Array[Int32] = []
    for p in aligned {
      correspondences.push(closest_idx(target, p))
    }
    let (angle, tx, ty) = estimate_rigid(aligned, target, correspondences)
    if angle.abs() < 0.0000001 && tx.abs() < 0.0000001 && ty.abs() < 0.0000001 {
      break
    }
    for i in 0..<n {
      aligned[i] = apply_rigid(aligned[i], angle, tx, ty)
    }
  }
  let result : Array[Int32] = []
  for p in aligned {
    result.push(closest_idx(target, p))
  }
  result
}
