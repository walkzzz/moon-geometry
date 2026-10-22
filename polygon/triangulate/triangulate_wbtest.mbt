///|
test "triangulate: triangle returns one triangle" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(4.0, 0.0)
  let p3 = @core.Point2D::new(2.0, 3.0)
  let poly = @core.Polygon::new([p1, p2, p3])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 1)
  assert_eq(tris[0], (0, 1, 2))
}

///|
test "triangulate: square returns two triangles" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(4.0, 0.0)
  let p2 = @core.Point2D::new(4.0, 4.0)
  let p3 = @core.Point2D::new(0.0, 4.0)
  let poly = @core.Polygon::new([p0, p1, p2, p3])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 2)
}

///|
test "triangulate: pentagon returns three triangles" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(4.0, 0.0)
  let p2 = @core.Point2D::new(5.0, 3.0)
  let p3 = @core.Point2D::new(2.0, 5.0)
  let p4 = @core.Point2D::new(-1.0, 3.0)
  let poly = @core.Polygon::new([p0, p1, p2, p3, p4])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 3)
}

///|
test "triangulate: hexagon returns four triangles" {
  let p0 = @core.Point2D::new(6.0, 0.0)
  let p1 = @core.Point2D::new(3.0, 5.196)
  let p2 = @core.Point2D::new(-3.0, 5.196)
  let p3 = @core.Point2D::new(-6.0, 0.0)
  let p4 = @core.Point2D::new(-3.0, -5.196)
  let p5 = @core.Point2D::new(3.0, -5.196)
  let poly = @core.Polygon::new([p0, p1, p2, p3, p4, p5])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 4)
}

///|
test "triangulate: concave polygon" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(6.0, 0.0)
  let p2 = @core.Point2D::new(6.0, 6.0)
  let p3 = @core.Point2D::new(3.0, 2.0)
  let p4 = @core.Point2D::new(0.0, 6.0)
  let poly = @core.Polygon::new([p0, p1, p2, p3, p4])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 3)
}

///|
test "triangulate: degenerate empty polygon" {
  let poly = @core.Polygon::new([])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 0)
}

///|
test "triangulate: degenerate single point" {
  let p0 = @core.Point2D::new(1.0, 1.0)
  let poly = @core.Polygon::new([p0])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 0)
}

///|
test "triangulate: degenerate two points" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(1.0, 1.0)
  let poly = @core.Polygon::new([p0, p1])
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), 0)
}

///|
test "triangulate: all indices valid and unique per triangle" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(5.0, 0.0)
  let p2 = @core.Point2D::new(6.0, 4.0)
  let p3 = @core.Point2D::new(3.0, 6.0)
  let p4 = @core.Point2D::new(-1.0, 4.0)
  let poly = @core.Polygon::new([p0, p1, p2, p3, p4])
  let tris = triangulate_polygon(poly)
  for tri in tris {
    let (a, b, c) = tri
    assert_true(a >= 0 && a < 5)
    assert_true(b >= 0 && b < 5)
    assert_true(c >= 0 && c < 5)
    assert_true(a != b && b != c && a != c)
  }
}

///|
test "triangulate: fan triangulation of convex polygon count" {
  let n = 8
  let pts : Array[@core.Point2D] = [
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(7.0710678, 7.0710678),
    @core.Point2D::new(0.0, 10.0),
    @core.Point2D::new(-7.0710678, 7.0710678),
    @core.Point2D::new(-10.0, 0.0),
    @core.Point2D::new(-7.0710678, -7.0710678),
    @core.Point2D::new(0.0, -10.0),
    @core.Point2D::new(7.0710678, -7.0710678),
  ]
  let poly = @core.Polygon::new(pts)
  let tris = triangulate_polygon(poly)
  assert_eq(tris.length(), n - 2)
}
