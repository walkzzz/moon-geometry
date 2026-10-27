///|
test "bezier2: eval at endpoints" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let p0 = b.eval(0.0)
  let p1 = b.eval(1.0)
  assert_true(@core.approx_eq(p0.x(), 0.0, 0.001))
  assert_true(@core.approx_eq(p0.y(), 0.0, 0.001))
  assert_true(@core.approx_eq(p1.x(), 3.0, 0.001))
  assert_true(@core.approx_eq(p1.y(), 0.0, 0.001))
}

///|
test "bezier2: eval at midpoint" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
  )
  let p = b.eval(0.5)
  assert_true(@core.approx_eq(p.x(), 1.0, 0.001))
  assert_true(@core.approx_eq(p.y(), 3.0, 0.001))
}

///|
test "bezier2: derivative at endpoints" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let d0 = b.derivative(0.0)
  assert_true(@core.approx_eq(d0.x(), 2.0, 0.001))
  assert_true(@core.approx_eq(d0.y(), 4.0, 0.001))
}

///|
test "bezier2: length of straight line" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(6.0, 8.0),
  )
  let l = b.length()
  assert_true(@core.approx_eq(l, 10.0, 0.01))
}

///|
test "bezier2: bbox" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
  )
  let (min_x, min_y, max_x, max_y) = b.bbox()
  assert_true(@core.approx_eq(min_x, 0.0, 0.001))
  assert_true(@core.approx_eq(max_x, 4.0, 0.001))
  assert_true(@core.approx_eq(min_y, 0.0, 0.001))
  assert_true(max_y >= 2.0)
}

///|
test "bezier2: subdivide" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let (left, right) = b.subdivide(0.5)
  let mid = b.eval(0.5)
  let left_end = left.eval(1.0)
  let right_start = right.eval(0.0)
  assert_true(@core.approx_eq(left_end.x(), mid.x(), 0.001))
  assert_true(@core.approx_eq(left_end.y(), mid.y(), 0.001))
  assert_true(@core.approx_eq(right_start.x(), mid.x(), 0.001))
  assert_true(@core.approx_eq(right_start.y(), mid.y(), 0.001))
}

///|
test "bezier3: eval at endpoints" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let p0 = b.eval(0.0)
  let p1 = b.eval(1.0)
  assert_true(@core.approx_eq(p0.x(), 0.0, 0.001))
  assert_true(@core.approx_eq(p0.y(), 0.0, 0.001))
  assert_true(@core.approx_eq(p1.x(), 3.0, 0.001))
  assert_true(@core.approx_eq(p1.y(), 0.0, 0.001))
}

///|
test "bezier3: eval at midpoint" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
  )
  let p = b.eval(0.5)
  assert_true(@core.approx_eq(p.x(), 2.0, 0.001))
  assert_true(@core.approx_eq(p.y(), 3.0, 0.001))
}

///|
test "bezier3: derivative at start" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let d = b.derivative(0.0)
  assert_true(@core.approx_eq(d.x(), 3.0, 0.001))
  assert_true(@core.approx_eq(d.y(), 9.0, 0.001))
}

///|
test "bezier3: length of straight line" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 1.5),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(6.0, 4.5),
  )
  let l = b.length()
  assert_true(@core.approx_eq(l, 7.5, 0.05))
}

///|
test "bezier3: bbox" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(4.0, 0.0),
  )
  let (min_x, min_y, max_x, max_y) = b.bbox()
  assert_true(@core.approx_eq(min_x, 0.0, 0.01))
  assert_true(@core.approx_eq(max_x, 4.0, 0.01))
  assert_true(@core.approx_eq(min_y, 0.0, 0.01))
  assert_true(max_y > 0.0)
}

///|
test "bezier3: subdivide" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let (left, right) = b.subdivide(0.5)
  let mid = b.eval(0.5)
  let left_end = left.eval(1.0)
  let right_start = right.eval(0.0)
  assert_true(@core.approx_eq(left_end.x(), mid.x(), 0.001))
  assert_true(@core.approx_eq(left_end.y(), mid.y(), 0.001))
  assert_true(@core.approx_eq(right_start.x(), mid.x(), 0.001))
  assert_true(@core.approx_eq(right_start.y(), mid.y(), 0.001))
}

///|
test "bezier2: degenerate single point" {
  let p = @core.Point2D::new(3.0, 5.0)
  let b = Bezier2::new(p, p, p)
  let v = b.eval(0.5)
  assert_true(@core.approx_eq(v.x(), 3.0, 0.001))
  assert_true(@core.approx_eq(v.y(), 5.0, 0.001))
  assert_true(@core.approx_eq(b.length(), 0.0, 0.001))
}

///|
test "bezier3: degenerate single point" {
  let p = @core.Point2D::new(2.0, 7.0)
  let b = Bezier3::new(p, p, p, p)
  let v = b.eval(0.5)
  assert_true(@core.approx_eq(v.x(), 2.0, 0.001))
  assert_true(@core.approx_eq(v.y(), 7.0, 0.001))
  assert_true(@core.approx_eq(b.length(), 0.0, 0.001))
}

///|
test "bezier2: bbox x-extremum below min" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  )
  let (min_x, min_y, max_x, max_y) = b.bbox()
  assert_true(@core.approx_eq(min_x, -1.0, 0.001))
  assert_true(@core.approx_eq(max_x, 0.0, 0.001))
  assert_true(@core.approx_eq(min_y, 0.0, 0.001))
  assert_true(@core.approx_eq(max_y, 0.0, 0.001))
}

///|
test "bezier2: bbox x-extremum above max" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  )
  let (min_x, _, max_x, _) = b.bbox()
  assert_true(@core.approx_eq(min_x, 0.0, 0.001))
  assert_true(@core.approx_eq(max_x, 1.0, 0.001))
}

///|
test "bezier2: bbox y-extremum below min" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, -2.0),
    @core.Point2D::new(0.0, 0.0),
  )
  let (_, min_y, _, max_y) = b.bbox()
  assert_true(@core.approx_eq(min_y, -1.0, 0.001))
  assert_true(@core.approx_eq(max_y, 0.0, 0.001))
}

///|
test "bezier2: bbox dx-branch t out of range" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let (_, _, max_x, _) = b.bbox()
  assert_true(@core.approx_eq(max_x, 3.0, 0.001))
}

///|
test "bezier2: bbox dy-branch t out of range" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(0.0, 3.0),
  )
  let (_, _, _, max_y) = b.bbox()
  assert_true(@core.approx_eq(max_y, 3.0, 0.001))
}

///|
test "bezier2: bbox p2 below min" {
  let b = Bezier2::new(
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 0.0),
  )
  let (min_x, min_y, max_x, max_y) = b.bbox()
  assert_true(@core.approx_eq(min_x, 0.0, 0.001))
  assert_true(@core.approx_eq(min_y, 0.0, 0.001))
  assert_true(@core.approx_eq(max_x, 2.0, 0.001))
  assert_true(@core.approx_eq(max_y, 2.0, 0.001))
}

///|
test "bezier2: bbox p2 above max y" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
  )
  let (_, _, max_x, max_y) = b.bbox()
  assert_true(@core.approx_eq(max_x, 2.0, 0.001))
  assert_true(@core.approx_eq(max_y, 2.0, 0.001))
}

///|
test "bezier2: derivative at end" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let d = b.derivative(1.0)
  assert_true(@core.approx_eq(d.x(), 4.0, 0.001))
  assert_true(@core.approx_eq(d.y(), -4.0, 0.001))
}

///|
test "bezier3: derivative at end" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let d = b.derivative(1.0)
  assert_true(@core.approx_eq(d.x(), 3.0, 0.001))
  assert_true(@core.approx_eq(d.y(), -9.0, 0.001))
}

///|
test "bezier2: subdivide at endpoints" {
  let b = Bezier2::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let (left, _) = b.subdivide(0.0)
  let start = left.eval(0.0)
  assert_true(@core.approx_eq(start.x(), 0.0, 0.001))
  assert_true(@core.approx_eq(start.y(), 0.0, 0.001))
}

///|
test "bezier3: subdivide at endpoints" {
  let b = Bezier3::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(3.0, 0.0),
  )
  let (_, right) = b.subdivide(1.0)
  let end = right.eval(1.0)
  assert_true(@core.approx_eq(end.x(), 3.0, 0.001))
  assert_true(@core.approx_eq(end.y(), 0.0, 0.001))
}
