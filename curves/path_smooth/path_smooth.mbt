///|
/// # Path Smoothing
/// # 路径平滑
///
/// B-spline based path smoothing with keypoint preservation for motion planning.
/// 基于样条的运动规划路径平滑（保留关键点）。
///
/// ## Complexity: O(n * k) where n = path length, k = samples per segment
/// ## 复杂度: O(n * k)，n = 路径长度，k = 每段采样数


///|
/// Smoothing configuration. / 平滑配置。
pub struct SmoothConfig {
  num_samples : Int
  tension : Double
  preserve_endpoints : Bool
}


///|
/// Construct smoothing configuration. / 构造平滑配置。
pub fn SmoothConfig::new(
  num_samples : Int,
  tension : Double,
  preserve_endpoints : Bool,
) -> SmoothConfig {
  { num_samples, tension, preserve_endpoints }
}
