///|
/// Tolerance-based geometry demo: create near-coincident points, use ToleranceCtx to detect them.
/// 容差几何演示：创建近似重合的点，使用 ToleranceCtx 检测。
fn main {
  let tol = @geo.tolerance_ctx_loose()
  let a = @geo.Point2D::new(1.0, 2.0)
  let b = @geo.Point2D::new(1.0000001, 2.0000001)
  let c = @geo.Point2D::new(1.5, 2.0)
  println("Point a: (1.0, 2.0)")
  println("Point b: (1.0000001, 2.0000001)")
  println("Point c: (1.5, 2.0)")
  println("a coincide b (loose tol): \{@geo.points_coincide(a, b, tol)}")
  println("a coincide c (loose tol): \{@geo.points_coincide(a, c, tol)}")
  let strict_tol = @geo.tolerance_ctx_strict()
  println("a coincide b (strict tol): \{@geo.points_coincide(a, b, strict_tol)}")
  let p1 = @geo.Point2D::new(0.0, 0.0)
  let p2 = @geo.Point2D::new(1.0, 0.0)
  let p3 = @geo.Point2D::new(2.0, 0.0)
  println("p1,p2,p3 collinear: \{@geo.points_collinear(p1, p2, p3, tol)}")
}