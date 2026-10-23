///|
/// Point-to-plane ICP registration.
/// 点到面 ICP 配准。
///
/// # Arguments / 参数
/// - `source`: source point cloud / 源点云
/// - `target`: target point cloud / 目标点云
/// - `normals`: normals of target points / 目标点法向量
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn icp_point_to_plane(
  source : Array[@core.Point3D],
  target : Array[@core.Point3D],
  normals : Array[@core.Point3D],
  max_iter : Int32,
) -> IcpResult {
  let n = source.length()
  if n == 0 || target.length() == 0 {
    return IcpResult::new(
      mat3_identity(),
      @core.Point3D::new(0.0, 0.0, 0.0),
      0.0,
      0,
    )
  }
  let aligned : Array[@core.Point3D] = []
  for p in source {
    aligned.push(p)
  }
  let mut cur_rot = mat3_identity()
  let mut cur_trans = @core.Point3D::new(0.0, 0.0, 0.0)
  let mut last_error = 1.7976931348623157e+308
  let mut iter_done = 0
  for iter in 0..<max_iter {
    iter_done = iter + 1
    let ata : Array[Array[Double]] = []
    for _ in 0..<6 {
      ata.push(Array::make(6, 0.0))
    }
    let atb : Array[Double] = Array::make(6, 0.0)
    let mut err_sq = 0.0
    for i in 0..<n {
      let j = closest_idx(target, aligned[i])
      let nj = normals[j]
      let d = aligned[i].sub(target[j])
      let cross = aligned[i].cross(nj)
      let row = [cross.x, cross.y, cross.z, nj.x, nj.y, nj.z]
      let rhs = -(nj.x * d.x + nj.y * d.y + nj.z * d.z)
      err_sq += rhs * rhs
      for a_idx in 0..<6 {
        for b_idx in 0..<6 {
          ata[a_idx][b_idx] = ata[a_idx][b_idx] + row[a_idx] * row[b_idx]
        }
        atb[a_idx] = atb[a_idx] + row[a_idx] * rhs
      }
    }
    match solve_linear(ata, atb) {
      Some(x) => {
        let w = @core.Point3D::new(x[0], x[1], x[2])
        let t = @core.Point3D::new(x[3], x[4], x[5])
        let r = rodrigues(w)
        cur_rot = mat3_mul(r, cur_rot)
        cur_trans = mat3_vec(r, cur_trans).add(t)
        for i in 0..<n {
          aligned[i] = transform_point(r, t, aligned[i])
        }
      }
      None => continue
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
