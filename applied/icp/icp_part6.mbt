///|
/// Point-to-point ICP registration.
/// 点到点 ICP 配准。
///
/// # Arguments / 参数
/// - `source`: source point cloud / 源点云
/// - `target`: target point cloud / 目标点云
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn icp_point_to_point(
  source : Array[@core.Point3D],
  target : Array[@core.Point3D],
  max_iter : Int,
) -> IcpResult {
  let n = source.length()
  if n == 0 || target.length() == 0 {
    return IcpResult::new(mat3_identity(), @core.Point3D::new(0.0, 0.0, 0.0), 0.0, 0)
  }
  let rot = mat3_identity()
  let trans = @core.Point3D::new(0.0, 0.0, 0.0)
  let aligned : Array[@core.Point3D] = []
  for p in source {
    aligned.push(p)
  }
  let mut cur_rot = rot
  let mut cur_trans = trans
  let mut last_error = 1.7976931348623157e+308
  let mut iter_done = 0
  for iter in 0..<max_iter {
    iter_done = iter + 1
    let match_tgt : Array[@core.Point3D] = []
    let match_idx : Array[Int] = []
    for p in aligned {
      let j = closest_idx(target, p)
      match_idx.push(j)
      match_tgt.push(target[j])
    }
    let src_c = centroid3d(aligned)
    let tgt_c = centroid3d(match_tgt)
    let src_centered : Array[@core.Point3D] = []
    let tgt_centered : Array[@core.Point3D] = []
    for i in 0..<n {
      src_centered.push(aligned[i].sub(src_c))
      tgt_centered.push(match_tgt[i].sub(tgt_c))
    }
    let r = kabsch(src_centered, tgt_centered)
    let t = tgt_c.sub(mat3_vec(r, src_c))
    cur_rot = mat3_mul(r, cur_rot)
    cur_trans = mat3_vec(r, cur_trans).add(t)
    let mut err_sq = 0.0
    for i in 0..<n {
      aligned[i] = transform_point(r, t, aligned[i])
      let d = aligned[i].dist(match_tgt[i])
      err_sq += d * d
    }
    let err = (err_sq / n.to_double()).sqrt()
    if (last_error - err).abs() < 0.0000001 {
      last_error = err
      break
    }
    last_error = err
  }
  IcpResult::new(cur_rot, cur_trans, last_error, iter_done)
}
