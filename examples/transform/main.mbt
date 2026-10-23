///|
/// Geometric transform demo: create a polygon, apply affine transform, print before/after.
/// 几何变换演示：创建多边形，应用仿射变换，打印变换前后。
fn main {
  let poly = [
    @geo.Point2D::new(0.0, 0.0),
    @geo.Point2D::new(2.0, 0.0),
    @geo.Point2D::new(2.0, 2.0),
    @geo.Point2D::new(0.0, 2.0),
  ]
  println("Before transform:")
  for i in 0..<poly.length() {
    let p = poly[i]
    println("  (\{p.x()}, \{p.y()})")
  }
  // Affine: (x,y) -> (a*x+b*y+c, d*x+e*y+f), scale 2x and translate (1,1)
  let transformed = @geo.affine_transform_points(
    poly, 2.0, 0.0, 1.0, 0.0, 2.0, 1.0,
  )
  println("After affine transform (scale 2x, translate 1,1):")
  for i in 0..<transformed.length() {
    let p = transformed[i]
    println("  (\{p.x()}, \{p.y()})")
  }
}
