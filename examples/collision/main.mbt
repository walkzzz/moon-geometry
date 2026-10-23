///|
/// Collision detection demo: create two polygons, check collision, print result.
/// 碰撞检测演示：创建两个多边形，检测碰撞，打印结果。
fn main {
  let poly1 = [
    @geo.Point2D::new(0.0, 0.0),
    @geo.Point2D::new(2.0, 0.0),
    @geo.Point2D::new(2.0, 2.0),
    @geo.Point2D::new(0.0, 2.0),
  ]
  let poly2 = [
    @geo.Point2D::new(1.0, 1.0),
    @geo.Point2D::new(3.0, 1.0),
    @geo.Point2D::new(3.0, 3.0),
    @geo.Point2D::new(1.0, 3.0),
  ]
  let collide = @geo.polygon_polygon_collide(poly1, poly2)
  println("Polygon 1: square [0,2]x[0,2]")
  println("Polygon 2: square [1,3]x[1,3]")
  println("Collide: \{collide}")
  let poly3 = [
    @geo.Point2D::new(5.0, 5.0),
    @geo.Point2D::new(7.0, 5.0),
    @geo.Point2D::new(7.0, 7.0),
    @geo.Point2D::new(5.0, 7.0),
  ]
  let collide2 = @geo.polygon_polygon_collide(poly1, poly3)
  println("Polygon 3: square [5,7]x[5,7]")
  println("Collide with poly1: \{collide2}")
}