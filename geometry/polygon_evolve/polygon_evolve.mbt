/// |
/// # Curve Shortening Flow
/// # 曲率流（曲线缩短流）
///
/// Evolve a polygon by moving each vertex inward proportional to curvature.
/// 通过将每个顶点按曲率比例向内移动来演化多边形。
///
/// ## Complexity: O(n × steps)
/// ## 复杂度: O(n × steps)

///|
/// |
/// Perform curve shortening flow for multiple steps.
/// 执行多步曲率流。
///
/// # Arguments / 参数
/// - `pts`: initial polygon vertices / 初始多边形顶点
/// - `steps`: number of evolution steps / 演化步数
/// - `dt`: time step / 时间步长
///
/// Returns the sequence of polygons at each step.
/// 返回每一步的多边形序列。
pub fn curve_shortening_flow(
  pts : Array[@core.Point2D],
  steps : Int32,
  dt : Double,
) -> Array[Array[@core.Point2D]] {
  let result : Array[Array[@core.Point2D]] = []
  let n = pts.length()
  if n < 3 || steps < 1 {
    result.push(pts.copy())
    return result
  }
  let mut current = pts.copy()
  for _ in 0..<steps {
    result.push(current.copy())
    current = evolve_step(current, dt)
    if current.length() < 3 {
      break
    }
  }
  result
}

///|
/// |
/// Perform a single evolution step.
/// 执行单步演化。
///
/// Each vertex moves by curvature × dt.
/// 每个顶点按曲率 × dt 移动。
pub fn evolve_step(
  pts : Array[@core.Point2D],
  dt : Double,
) -> Array[@core.Point2D] {
  let n = pts.length()
  let result : Array[@core.Point2D] = []
  if n < 3 {
    return pts.copy()
  }
  for i in 0..<n {
    let prev = pts[(i - 1 + n) % n]
    let cur = pts[i]
    let next = pts[(i + 1) % n]
    let laplace_x = prev.x() - 2.0 * cur.x() + next.x()
    let laplace_y = prev.y() - 2.0 * cur.y() + next.y()
    let new_x = cur.x() + laplace_x * dt
    let new_y = cur.y() + laplace_y * dt
    result.push(@core.Point2D::new(new_x, new_y))
  }
  result
}

///|
/// |
/// Compute the perimeter of a polygon at each evolution step.
/// 计算每个演化步骤的多边形周长。
pub fn flow_perimeters(
  pts : Array[@core.Point2D],
  steps : Int32,
  dt : Double,
) -> Array[Double] {
  let result : Array[Double] = []
  let flow = curve_shortening_flow(pts, steps, dt)
  for i in 0..<flow.length() {
    result.push(perimeter(flow[i]))
  }
  result
}

///|
/// |
/// Compute the area of a polygon at each evolution step.
/// 计算每个演化步骤的多边形面积。
pub fn flow_areas(
  pts : Array[@core.Point2D],
  steps : Int32,
  dt : Double,
) -> Array[Double] {
  let result : Array[Double] = []
  let flow = curve_shortening_flow(pts, steps, dt)
  for i in 0..<flow.length() {
    result.push(signed_area(flow[i]).abs())
  }
  result
}

///|
fn perimeter(pts : Array[@core.Point2D]) -> Double {
  let n = pts.length()
  let mut sum = 0.0
  for i in 0..<n {
    let a = pts[i]
    let b = pts[(i + 1) % n]
    let dx = b.x() - a.x()
    let dy = b.y() - a.y()
    sum += (dx * dx + dy * dy).sqrt()
  }
  sum
}

///|
fn signed_area(pts : Array[@core.Point2D]) -> Double {
  let n = pts.length()
  let mut sum = 0.0
  for i in 0..<n {
    let a = pts[i]
    let b = pts[(i + 1) % n]
    sum += a.x() * b.y() - b.x() * a.y()
  }
  sum / 2.0
}
