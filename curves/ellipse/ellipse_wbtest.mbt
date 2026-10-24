///|
test "ellipse: area" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let a = e.area()
  assert_true(@core.approx_eq(a, 47.1238898, 0.001))
}

///|
test "ellipse: perimeter" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let p = e.perimeter()
  assert_true(@core.approx_eq(p, 25.526, 0.01))
}

///|
test "ellipse: eccentricity" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let ecc = e.eccentricity()
  assert_true(@core.approx_eq(ecc, 0.8, 0.001))
}

///|
test "ellipse: eccentricity of circle" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 4.0, 4.0, 0.0)
  let ecc = e.eccentricity()
  assert_true(@core.approx_eq(ecc, 0.0, 0.001))
}

///|
test "ellipse: contains inside" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let p = @core.Point2D::new(2.0, 1.0)
  assert_true(e.contains(p))
}

///|
test "ellipse: contains outside" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let p = @core.Point2D::new(6.0, 0.0)
  assert_false(e.contains(p))
}

///|
test "ellipse: contains on boundary" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let p = @core.Point2D::new(5.0, 0.0)
  assert_true(e.contains(p))
}

///|
test "ellipse: contains center" {
  let e = Ellipse::new(@core.Point2D::new(3.0, 4.0), 5.0, 3.0, 0.0)
  let p = @core.Point2D::new(3.0, 4.0)
  assert_true(e.contains(p))
}

///|
test "ellipse: contains rotated" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 2.0, 1.5707963)
  let p = @core.Point2D::new(0.0, 4.0)
  assert_true(e.contains(p))
}

///|
test "ellipse: on boundary" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let p = @core.Point2D::new(0.0, 3.0)
  assert_true(e.on_boundary(p, 0.001))
}

///|
test "ellipse: foci" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let (f1, f2) = e.foci()
  let expected_c = (25.0 - 9.0).sqrt()
  assert_true(@core.approx_eq(f1.x(), expected_c, 0.001))
  assert_true(@core.approx_eq(f2.x(), -expected_c, 0.001))
}

///|
test "ellipse: foci of circle" {
  let e = Ellipse::new(@core.Point2D::new(2.0, 3.0), 4.0, 4.0, 0.0)
  let (f1, f2) = e.foci()
  assert_true(@core.approx_eq(f1.x(), 2.0, 0.001))
  assert_true(@core.approx_eq(f1.y(), 3.0, 0.001))
  assert_true(@core.approx_eq(f2.x(), 2.0, 0.001))
  assert_true(@core.approx_eq(f2.y(), 3.0, 0.001))
}

///|
test "ellipse: area of circle" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 3.0, 3.0, 0.0)
  let a = e.area()
  assert_true(@core.approx_eq(a, 28.2743339, 0.001))
}

///|
test "ellipse: contains far outside" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 2.0, 1.0, 0.0)
  let p = @core.Point2D::new(100.0, 100.0)
  assert_false(e.contains(p))
}

///|
test "ellipse: line_intersect horizontal two points" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  let pts = e.line_intersect(line)
  assert_true(pts.length() == 2)
}

///|
test "ellipse: line_intersect vertical two points" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let line = @core.Line::new(1.0, 0.0, 0.0)
  let pts = e.line_intersect(line)
  assert_true(pts.length() == 2)
}

///|
test "ellipse: line_intersect no intersection" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let line = @core.Line::new(0.0, 1.0, -10.0)
  let pts = e.line_intersect(line)
  assert_true(pts.length() == 0)
}

///|
test "ellipse: line_intersect tangent one point" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let line = @core.Line::new(0.0, 1.0, -3.0)
  let pts = e.line_intersect(line)
  assert_true(pts.length() == 1)
}

///|
test "ellipse: line_intersect rotated ellipse" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.7853981)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  let pts = e.line_intersect(line)
  assert_true(pts.length() == 2)
}

///|
test "ellipse: line_intersect offset center" {
  let e = Ellipse::new(@core.Point2D::new(2.0, 1.0), 5.0, 3.0, 0.0)
  let line = @core.Line::new(0.0, 1.0, -1.0)
  let pts = e.line_intersect(line)
  assert_true(pts.length() == 2)
}

///|
test "ellipse: line_intersect degenerate line" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let line = @core.Line::new(0.0, 0.0, 1.0)
  let pts = e.line_intersect(line)
  assert_true(pts.length() == 0)
}

///|
test "ellipse: line_intersect verifies on boundary" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  let pts = e.line_intersect(line)
  for p in pts {
    assert_true(e.on_boundary(p, 0.001))
  }
}

///|
test "ellipse: on_boundary outside point" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 5.0, 3.0, 0.0)
  let p = @core.Point2D::new(2.0, 1.0)
  assert_false(e.on_boundary(p, 0.001))
}

///|
test "ellipse: eccentricity a less than b" {
  let e = Ellipse::new(@core.Point2D::new(0.0, 0.0), 3.0, 5.0, 0.0)
  let ecc = e.eccentricity()
  assert_true(@core.approx_eq(ecc, 0.0, 0.001))
}

///|
test "ellipse: foci rotated" {
  let e = Ellipse::new(@core.Point2D::new(1.0, 1.0), 5.0, 3.0, 1.5707963)
  let (f1, f2) = e.foci()
  let expected_c = (25.0 - 9.0).sqrt()
  let dist1 = (f1.x() - 1.0) * (f1.x() - 1.0) + (f1.y() - 1.0) * (f1.y() - 1.0)
  assert_true(@core.approx_eq(dist1.sqrt(), expected_c, 0.001))
  let dist2 = (f2.x() - 1.0) * (f2.x() - 1.0) + (f2.y() - 1.0) * (f2.y() - 1.0)
  assert_true(@core.approx_eq(dist2.sqrt(), expected_c, 0.001))
}
