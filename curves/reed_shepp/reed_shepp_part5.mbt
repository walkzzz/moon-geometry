///|
/// Get the total length of a Reeds-Shepp path. / 获取 Reeds-Shepp 路径总长度。
pub fn reed_shepp_path_length(path : RSPath) -> Double {
  path.total_length * path.radius
}


///|
/// Count segments in a Reeds-Shepp path. / 统计 Reeds-Shepp 路径段数。
pub fn reed_shepp_segment_count(path : RSPath) -> Int {
  path.segments.length()
}


///|
/// Check if a Reeds-Shepp path contains backward motion. / 检查 Reeds-Shepp 路径是否包含后退运动。
pub fn reed_shepp_has_backward(path : RSPath) -> Bool {
  for i in 0..<path.segments.length() {
    if !path.segments[i].forward && path.segments[i].length > 0.0 {
      return true
    }
  }
  false
}