///|
/// Dubins pose. / Dubins 位姿。
pub type DubinsPose = @dubins.DubinsPose


///|
/// Construct a Dubins pose. / 构造 Dubins 位姿。
pub fn dubins_pose_new(x : Double, y : Double, theta : Double) -> DubinsPose {
  @dubins.DubinsPose::new(x, y, theta)
}


///|
/// Compute the shortest Dubins path. / 计算最短 Dubins 路径。
pub fn dubins_shortest_path(
  start : DubinsPose,
  goal : DubinsPose,
  radius : Double,
) -> DubinsPath {
  @dubins.dubins_shortest_path(start, goal, radius)
}


///|
/// Sample points along a Dubins path. / 沿 Dubins 路径采样点。
pub fn dubins_sample(
  path : DubinsPath,
  start : DubinsPose,
  num_samples : Int,
) -> Array[Point2D] {
  @dubins.dubins_sample(path, start, num_samples)
}


///|
/// Get the total length of a Dubins path. / 获取 Dubins 路径总长度。
pub fn dubins_path_length(path : DubinsPath) -> Double {
  @dubins.dubins_path_length(path)
}


///|
/// Count segments in a Dubins path. / 统计 Dubins 路径段数。
pub fn dubins_segment_count(path : DubinsPath) -> Int {
  @dubins.dubins_segment_count(path)
}

// ---------------------------------------------------------------------------
// reed_shepp: Reeds-Shepp curves / Reeds-Shepp 曲线
// ---------------------------------------------------------------------------


///|
/// Reeds-Shepp path segment type. / Reeds-Shepp 路径段类型。
pub type RSSegmentType = @reed_shepp.RSSegmentType
