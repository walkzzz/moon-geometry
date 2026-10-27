///|
test "point buffer vertex count" {
  let p = @core.Point2D::new(0.0, 0.0)
  let buf = point_buffer(p, 5.0, 8)
  assert_eq(buf.size(), 8)
}

///|
test "point buffer radius" {
  let p = @core.Point2D::new(0.0, 0.0)
  let buf = point_buffer(p, 5.0, 8)
  for i in 0..<buf.size() {
    let v = buf.get(i)
    let d = (v.x * v.x + v.y * v.y).sqrt()
    assert_true(@core.approx_eq(d, 5.0, 0.001))
  }
}

///|
test "point buffer centered" {
  let center = @core.Point2D::new(3.0, 4.0)
  let buf = point_buffer(center, 2.0, 6)
  for i in 0..<buf.size() {
    let v = buf.get(i)
    let dx = v.x - 3.0
    let dy = v.y - 4.0
    let d = (dx * dx + dy * dy).sqrt()
    assert_true(@core.approx_eq(d, 2.0, 0.001))
  }
}

///|
test "point buffer min segments" {
  let p = @core.Point2D::new(0.0, 0.0)
  let buf = point_buffer(p, 1.0, 1)
  assert_eq(buf.size(), 3)
}

///|
test "segment buffer basic" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(10.0, 0.0)
  let buf = segment_buffer(a, b, 2.0, 4)
  assert_true(buf.size() >= 8)
}

///|
test "segment buffer degenerate" {
  let a = @core.Point2D::new(5.0, 5.0)
  let b = @core.Point2D::new(5.0, 5.0)
  let buf = segment_buffer(a, b, 3.0, 4)
  assert_true(buf.size() >= 6)
}

///|
test "polyline buffer single point" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let buf = polyline_buffer(pts, 5.0, 8)
  assert_true(buf.size() >= 8)
}

///|
test "polyline buffer multi segment" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
  ]
  let buf = polyline_buffer(pts, 1.0, 4)
  assert_true(buf.size() > 0)
}

///|
test "minkowski sum basic" {
  let square = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let small = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let result = minkowski_sum_convex(square, small)
  assert_true(result.size() > 0)
}

///|
test "convex polygon buffer" {
  let square = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let buf = convex_polygon_buffer(square, 1.0, 8)
  assert_true(buf.size() > 0)
}

///|
test "polygon offset buffer" {
  let square = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let buf = polygon_offset_buffer(square, 0.5)
  assert_eq(buf.size(), 4)
}

///|
test "segment buffer min cap segments" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(10.0, 0.0)
  let buf = segment_buffer(a, b, 2.0, 0)
  assert_true(buf.size() >= 8)
}

///|
test "segment buffer vertical" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 10.0)
  let buf = segment_buffer(a, b, 2.0, 4)
  assert_true(buf.size() >= 8)
}

///|
test "polyline buffer empty" {
  let pts : Array[@core.Point2D] = []
  let buf = polyline_buffer(pts, 5.0, 8)
  assert_eq(buf.size(), 0)
}

///|
test "minkowski sum empty first" {
  let empty = @core.Polygon::new([])
  let small = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let result = minkowski_sum_convex(empty, small)
  assert_eq(result.size(), 0)
}

///|
test "minkowski sum empty second" {
  let small = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let empty = @core.Polygon::new([])
  let result = minkowski_sum_convex(small, empty)
  assert_eq(result.size(), 0)
}

///|
test "minkowski sum triangles" {
  let tri1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
  ])
  let tri2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let result = minkowski_sum_convex(tri1, tri2)
  assert_true(result.size() > 0)
}

///|
test "polygon offset buffer empty" {
  let empty = @core.Polygon::new([])
  let buf = polygon_offset_buffer(empty, 1.0)
  assert_eq(buf.size(), 0)
}

///|
test "polygon offset buffer degenerate" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(5.0, 5.0),
  ])
  let buf = polygon_offset_buffer(poly, 1.0)
  assert_eq(buf.size(), 3)
}

///|
test "convex polygon buffer empty" {
  let empty = @core.Polygon::new([])
  let buf = convex_polygon_buffer(empty, 1.0, 8)
  assert_eq(buf.size(), 0)
}
