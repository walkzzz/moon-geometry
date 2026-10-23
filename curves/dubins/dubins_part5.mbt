///|
/// Get the total length of a Dubins path. / 获取 Dubins 路径总长度。
pub fn dubins_path_length(path : DubinsPath) -> Double {
  path.total_length * path.radius
}

///|
/// Count segments in a Dubins path. / 统计 Dubins 路径段数。
pub fn dubins_segment_count(path : DubinsPath) -> Int32 {
  path.segments.length()
}
