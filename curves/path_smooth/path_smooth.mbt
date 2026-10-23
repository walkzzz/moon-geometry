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
  num_samples : Int32
  tension : Double
  preserve_endpoints : Bool
}

///|
/// Construct smoothing configuration. / 构造平滑配置。
pub fn SmoothConfig::new(
  num_samples : Int32,
  tension : Double,
  preserve_endpoints : Bool,
) -> SmoothConfig {
  { num_samples, tension, preserve_endpoints, }
}

///|
/// Smooth a path using Catmull-Rom spline interpolation. / 使用 Catmull-Rom 样条插值平滑路径。
///
/// # Arguments / 参数
/// - `path`: input path points / 输入路径点
/// - `config`: smoothing configuration / 平滑配置
pub fn smooth_path(
  path : Array[@core.Point2D],
  config : SmoothConfig,
) -> Array[@core.Point2D] {
  let n = path.length()
  if n < 2 {
    return path
  }
  if n == 2 {
    return path
  }
  let result : Array[@core.Point2D] = []
  if config.preserve_endpoints {
    result.push(path[0])
  }
  for i in 0..<(n - 1) {
    let p0 = if i == 0 { path[0] } else { path[i - 1] }
    let p1 = path[i]
    let p2 = path[i + 1]
    let p3 = if i + 2 < n { path[i + 2] } else { path[n - 1] }
    let start_sample = if i == 0 && config.preserve_endpoints { 1 } else { 0 }
    for s in start_sample..<config.num_samples {
      let t = s.to_double() / config.num_samples.to_double()
      let pt = catmull_rom_point(p0, p1, p2, p3, t, config.tension)
      result.push(pt)
    }
  }
  if config.preserve_endpoints {
    result.push(path[n - 1])
  }
  result
}

///|
fn catmull_rom_point(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  t : Double,
  tension : Double,
) -> @core.Point2D {
  let t2 = t * t
  let t3 = t2 * t
  let s = (1.0 - tension) / 2.0
  let a_x = -s * p0.x() + (2.0 - s) * p1.x() + (s - 2.0) * p2.x() + s * p3.x()
  let b_x = 2.0 * s * p0.x() +
    (s - 3.0) * p1.x() +
    (3.0 - 2.0 * s) * p2.x() -
    s * p3.x()
  let c_x = -s * p0.x() + s * p2.x()
  let d_x = p1.x()
  let a_y = -s * p0.y() + (2.0 - s) * p1.y() + (s - 2.0) * p2.y() + s * p3.y()
  let b_y = 2.0 * s * p0.y() +
    (s - 3.0) * p1.y() +
    (3.0 - 2.0 * s) * p2.y() -
    s * p3.y()
  let c_y = -s * p0.y() + s * p2.y()
  let d_y = p1.y()
  @core.Point2D::new(
    a_x * t3 + b_x * t2 + c_x * t + d_x,
    a_y * t3 + b_y * t2 + c_y * t + d_y,
  )
}

///|
/// Smooth a path using uniform cubic B-spline. / 使用均匀三次 B 样条平滑路径。
pub fn bspline_smooth(
  path : Array[@core.Point2D],
  num_samples : Int32,
) -> Array[@core.Point2D] {
  let n = path.length()
  if n < 2 {
    return path
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<(n - 1) {
    let p0 = if i == 0 { path[0] } else { path[i - 1] }
    let p1 = path[i]
    let p2 = path[i + 1]
    let p3 = if i + 2 < n { path[i + 2] } else { path[n - 1] }
    for s in 0..<num_samples {
      let t = s.to_double() / num_samples.to_double()
      let pt = bspline_point(p0, p1, p2, p3, t)
      result.push(pt)
    }
  }
  result.push(path[n - 1])
  result
}

///|
fn bspline_point(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  t : Double,
) -> @core.Point2D {
  let t2 = t * t
  let t3 = t2 * t
  let b0 = (1.0 - t) * (1.0 - t) * (1.0 - t) / 6.0
  let b1 = (3.0 * t3 - 6.0 * t2 + 4.0) / 6.0
  let b2 = (-3.0 * t3 + 3.0 * t2 + 3.0 * t + 1.0) / 6.0
  let b3 = t3 / 6.0
  @core.Point2D::new(
    b0 * p0.x() + b1 * p1.x() + b2 * p2.x() + b3 * p3.x(),
    b0 * p0.y() + b1 * p1.y() + b2 * p2.y() + b3 * p3.y(),
  )
}

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

///|
/// Compute the total length of a path. / 计算路径总长度。
pub fn path_length(path : Array[@core.Point2D]) -> Double {
  let mut sum = 0.0
  for i in 1..<path.length() {
    sum += path[i - 1].dist(path[i])
  }
  sum
}

///|
/// Reduce path to key points by removing collinear points. / 通过移除共线点将路径简化为关键点。
pub fn simplify_path(
  path : Array[@core.Point2D],
  eps : Double,
) -> Array[@core.Point2D] {
  let n = path.length()
  if n <= 2 {
    return path
  }
  let result : Array[@core.Point2D] = [path[0]]
  for i in 1..<(n - 1) {
    let prev = path[i - 1]
    let cur = path[i]
    let next = path[i + 1]
    let area = ((cur.x() - prev.x()) * (next.y() - prev.y()) -
    (cur.y() - prev.y()) * (next.x() - prev.x())).abs()
    if area > eps {
      result.push(cur)
    }
  }
  result.push(path[n - 1])
  result
}

///|
/// Compute the maximum deviation between original and smoothed path. / 计算原始路径与平滑路径间的最大偏差。
pub fn path_max_deviation(
  original : Array[@core.Point2D],
  smoothed : Array[@core.Point2D],
) -> Double {
  let mut max_dev = 0.0
  for i in 0..<original.length() {
    let mut min_dist = 1000000000000.0
    for j in 0..<smoothed.length() {
      let d = original[i].dist(smoothed[j])
      if d < min_dist {
        min_dist = d
      }
    }
    if min_dist > max_dev {
      max_dev = min_dist
    }
  }
  max_dev
}
