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
    let p0 = if i == 0 {
      path[0]
    } else {
      path[i - 1]
    }
    let p1 = path[i]
    let p2 = path[i + 1]
    let p3 = if i + 2 < n {
      path[i + 2]
    } else {
      path[n - 1]
    }
    let start_sample = if i == 0 && config.preserve_endpoints {
      1
    } else {
      0
    }
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
  let b_x = 2.0 * s * p0.x() + (s - 3.0) * p1.x() + (3.0 - 2.0 * s) * p2.x() - s * p3.x()
  let c_x = -s * p0.x() + s * p2.x()
  let d_x = p1.x()
  let a_y = -s * p0.y() + (2.0 - s) * p1.y() + (s - 2.0) * p2.y() + s * p3.y()
  let b_y = 2.0 * s * p0.y() + (s - 3.0) * p1.y() + (3.0 - 2.0 * s) * p2.y() - s * p3.y()
  let c_y = -s * p0.y() + s * p2.y()
  let d_y = p1.y()
  @core.Point2D::new(a_x * t3 + b_x * t2 + c_x * t + d_x, a_y * t3 + b_y * t2 + c_y * t + d_y)
}
