///|
/// Convex hull demo: create random points, compute convex hull, print result.
/// 凸包演示：创建点集，计算凸包，打印结果。
fn main {
  let points = [
    @geo.Point2D::new(0.0, 0.0),
    @geo.Point2D::new(4.0, 0.0),
    @geo.Point2D::new(4.0, 4.0),
    @geo.Point2D::new(0.0, 4.0),
    @geo.Point2D::new(2.0, 2.0),
    @geo.Point2D::new(1.0, 1.0),
    @geo.Point2D::new(3.0, 1.0),
  ]
  let hull = @geo.convex_hull_andrew(points)
  println("Input points: \{points.length()}")
  println("Convex hull vertices: \{hull.length()}")
  for i in 0..<hull.length() {
    let p = hull[i]
    println("  (\{p.x()}, \{p.y()})")
  }
}
