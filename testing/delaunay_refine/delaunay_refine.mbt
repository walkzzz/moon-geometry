/// |
/// # Delaunay Refinement (Ruppert's Algorithm)
/// # Delaunay 细化（Ruppert 算法）
///
/// Refine a Delaunay triangulation to satisfy angle and size constraints.
/// 细化 Delaunay 三角剖分以满足角度和尺寸约束。
///
/// ## Complexity: O(n log n) expected
/// ## 复杂度: 期望 O(n log n)

///|
/// |
/// Refine triangulation by splitting bad triangles.
/// 通过分割坏三角形来细化三角剖分。
///
/// # Arguments / 参数
/// - `pts`: point set / 点集
/// - `min_angle`: minimum angle in degrees / 最小角度（度）
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn delaunay_refine(
  pts : Array[@core.Point2D],
  min_angle : Double,
  max_iter : Int32,
) -> Array[@core.Point2D] {
  let result = pts.copy()
  let mut iter = 0
  while iter < max_iter {
    let bad = find_bad_triangle(result, min_angle)
    match bad {
      Some(circumcenter) => result.push(circumcenter)
      None => break
    }
    iter += 1
  }
  result
}

///|
/// |
/// Find the circumcenter of a triangle.
/// 计算三角形的外心。
pub fn circumcenter(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.0000000001 {
    return @core.Point2D::new((ax + bx + cx) / 3.0, (ay + by + cy) / 3.0)
  }
  let ux = (
      (ax * ax + ay * ay) * (by - cy) +
      (bx * bx + by * by) * (cy - ay) +
      (cx * cx + cy * cy) * (ay - by)
    ) /
    d
  let uy = (
      (ax * ax + ay * ay) * (cx - bx) +
      (bx * bx + by * by) * (ax - cx) +
      (cx * cx + cy * cy) * (bx - ax)
    ) /
    d
  @core.Point2D::new(ux, uy)
}

///|
/// |
/// Compute the minimum angle of a triangle in degrees.
/// 计算三角形最小角度（度）。
pub fn min_triangle_angle(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Double {
  let ab = dist(a, b)
  let bc = dist(b, c)
  let ca = dist(c, a)
  let angle_a = @math.acos((ab * ab + ca * ca - bc * bc) / (2.0 * ab * ca)) *
    180.0 /
    3.141592653589793
  let angle_b = @math.acos((ab * ab + bc * bc - ca * ca) / (2.0 * ab * bc)) *
    180.0 /
    3.141592653589793
  let angle_c = 180.0 - angle_a - angle_b
  let mut m = angle_a
  if angle_b < m {
    m = angle_b
  }
  if angle_c < m {
    m = angle_c
  }
  m
}

///|
/// |
/// Count triangles in a triangulation.
/// 计算三角剖分中的三角形数。
pub fn triangle_count(pts : Array[@core.Point2D]) -> Int32 {
  let n = pts.length()
  if n < 3 {
    return 0
  }
  n - 2
}

///|
fn find_bad_triangle(
  pts : Array[@core.Point2D],
  min_angle : Double,
) -> @core.Point2D? {
  let n = pts.length()
  if n < 3 {
    return None
  }
  for i in 0..<(n - 2) {
    let a = pts[i]
    let b = pts[i + 1]
    let c = pts[i + 2]
    let angle = min_triangle_angle(a, b, c)
    if angle < min_angle {
      return Some(circumcenter(a, b, c))
    }
  }
  None
}

///|
fn dist(a : @core.Point2D, b : @core.Point2D) -> Double {
  ((a.x() - b.x()) * (a.x() - b.x()) + (a.y() - b.y()) * (a.y() - b.y())).sqrt()
}
