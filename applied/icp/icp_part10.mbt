///|
/// Apply ICP result transformation to a point cloud.
/// 对点云应用 ICP 结果变换。
pub fn icp_apply(
  points : Array[@core.Point3D],
  result : IcpResult,
) -> Array[@core.Point3D] {
  let out : Array[@core.Point3D] = []
  for p in points {
    out.push(transform_point(result.rotation, result.translation, p))
  }
  out
}

///|
/// RMS error between two point clouds (point-to-point).
/// 两个点云间的 RMS 误差（点到点）。
pub fn icp_rms_error(
  source : Array[@core.Point3D],
  target : Array[@core.Point3D],
) -> Double {
  let n = source.length()
  if n == 0 {
    return 0.0
  }
  let mut sum_sq = 0.0
  for i in 0..<n {
    sum_sq += source[i].dist_sq(target[i])
  }
  (sum_sq / n.to_double()).sqrt()
}
