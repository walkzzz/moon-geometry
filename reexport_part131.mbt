///|
/// Construct smoothing configuration. / 构造平滑配置。
pub fn smooth_config_new(
  num_samples : Int,
  tension : Double,
  preserve_endpoints : Bool,
) -> SmoothConfig {
  @path_smooth.SmoothConfig::new(num_samples, tension, preserve_endpoints)
}


///|
/// Smooth a path using Catmull-Rom spline. / 使用 Catmull-Rom 样条平滑路径。
pub fn smooth_path(path : Array[Point2D], config : SmoothConfig) -> Array[Point2D] {
  @path_smooth.smooth_path(path, config)
}


///|
/// Smooth a path using uniform cubic B-spline. / 使用均匀三次 B 样条平滑路径。
pub fn bspline_smooth(path : Array[Point2D], num_samples : Int) -> Array[Point2D] {
  @path_smooth.bspline_smooth(path, num_samples)
}


///|
/// Smooth a path while preserving specified keypoint indices. / 平滑路径同时保留指定关键点索引。
pub fn smooth_preserve_keypoints(
  path : Array[Point2D],
  keypoints : Array[Int],
  num_samples : Int,
) -> Array[Point2D] {
  @path_smooth.smooth_preserve_keypoints(path, keypoints, num_samples)
}


///|
/// Compute the total length of a path. / 计算路径总长度。
pub fn path_smooth_length(path : Array[Point2D]) -> Double {
  @path_smooth.path_length(path)
}


///|
/// Reduce path to key points. / 将路径简化为关键点。
pub fn simplify_path(path : Array[Point2D], eps : Double) -> Array[Point2D] {
  @path_smooth.simplify_path(path, eps)
}
