///|
/// Smooth a path while preserving specified keypoint indices. / 平滑路径同时保留指定关键点索引。
///
/// # Arguments / 参数
/// - `path`: input path / 输入路径
/// - `keypoints`: indices of points to preserve exactly / 需精确保留的点索引
/// - `num_samples`: samples per segment / 每段采样数
pub fn smooth_preserve_keypoints(
  path : Array[@core.Point2D],
  keypoints : Array[Int32],
  num_samples : Int32,
) -> Array[@core.Point2D] {
  let n = path.length()
  if n < 2 {
    return path
  }
  let sorted_kp : Array[Int32] = []
  for i in 0..<keypoints.length() {
    sorted_kp.push(keypoints[i])
  }
  sorted_kp.sort_by(fn(a, b) { if a < b { -1 } else if a > b { 1 } else { 0 } })
  let segments : Array[(Int32, Int32)] = []
  let mut prev = 0
  for i in 0..<sorted_kp.length() {
    let kp = sorted_kp[i]
    if kp > prev && kp < n {
      segments.push((prev, kp))
      prev = kp
    }
  }
  if prev < n - 1 {
    segments.push((prev, n - 1))
  }
  let result : Array[@core.Point2D] = []
  for seg in 0..<segments.length() {
    let (start, end) = segments[seg]
    result.push(path[start])
    if end - start > 1 {
      let sub_path : Array[@core.Point2D] = []
      for i in start..<(end + 1) {
        sub_path.push(path[i])
      }
      let smoothed = smooth_path(
        sub_path,
        SmoothConfig::new(num_samples, 0.0, true),
      )
      for i in 1..<smoothed.length() {
        result.push(smoothed[i])
      }
    } else {
      result.push(path[end])
    }
  }
  result
}
