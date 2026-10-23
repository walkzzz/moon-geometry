///|
/// Reeds-Shepp path segment. / Reeds-Shepp 路径段。
pub type RSSegment = @reed_shepp.RSSegment


///|
/// Reeds-Shepp path. / Reeds-Shepp 路径。
pub type RSPath = @reed_shepp.RSPath


///|
/// Reeds-Shepp pose. / Reeds-Shepp 位姿。
pub type RSPose = @reed_shepp.RSPose


///|
/// Construct a Reeds-Shepp pose. / 构造 Reeds-Shepp 位姿。
pub fn rs_pose_new(x : Double, y : Double, theta : Double) -> RSPose {
  @reed_shepp.RSPose::new(x, y, theta)
}


///|
/// Compute the shortest Reeds-Shepp path. / 计算最短 Reeds-Shepp 路径。
pub fn reed_shepp_shortest_path(
  start : RSPose,
  goal : RSPose,
  radius : Double,
) -> RSPath {
  @reed_shepp.reed_shepp_shortest_path(start, goal, radius)
}


///|
/// Sample points along a Reeds-Shepp path. / 沿 Reeds-Shepp 路径采样点。
pub fn reed_shepp_sample(
  path : RSPath,
  start : RSPose,
  num_samples : Int,
) -> Array[Point2D] {
  @reed_shepp.reed_shepp_sample(path, start, num_samples)
}


///|
/// Get the total length of a Reeds-Shepp path. / 获取 Reeds-Shepp 路径总长度。
pub fn reed_shepp_path_length(path : RSPath) -> Double {
  @reed_shepp.reed_shepp_path_length(path)
}
