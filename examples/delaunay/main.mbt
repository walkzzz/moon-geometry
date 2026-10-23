///|
/// Delaunay triangulation demo: create points, compute triangulation, print triangle count.
/// Delaunay 三角剖分演示：创建点集，计算三角剖分，打印三角形数量。
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
  let tris = @geo.delaunay_triangulation(points)
  println("Input points: \{points.length()}")
  println("Delaunay triangles: \{tris.length()}")
}
