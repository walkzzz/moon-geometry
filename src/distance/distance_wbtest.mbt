///|
test "point_to_segment_distance point on segment" {
  let p = @core.Point2D::new(2.0, 0.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  assert_true(
    @core.approx_eq(point_to_segment_distance(p, seg), 0.0, 0.000000001),
  )
}

///|
test "point_to_segment_distance perpendicular" {
  let p = @core.Point2D::new(2.0, 3.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  assert_true(
    @core.approx_eq(point_to_segment_distance(p, seg), 3.0, 0.000000001),
  )
}

///|
test "point_to_segment_distance before start" {
  let p = @core.Point2D::new(-3.0, 0.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  assert_true(
    @core.approx_eq(point_to_segment_distance(p, seg), 3.0, 0.000000001),
  )
}

///|
test "point_to_segment_distance after end" {
  let p = @core.Point2D::new(7.0, 0.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  assert_true(
    @core.approx_eq(point_to_segment_distance(p, seg), 3.0, 0.000000001),
  )
}

///|
test "point_to_segment_distance degenerate" {
  let p = @core.Point2D::new(3.0, 4.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  )
  assert_true(
    @core.approx_eq(point_to_segment_distance(p, seg), 5.0, 0.000000001),
  )
}

///|
test "point_to_segment_distance diagonal" {
  let p = @core.Point2D::new(0.0, 4.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
  )
  let d = point_to_segment_distance(p, seg)
  assert_true(d > 0.0 && d < 4.0)
}

///|
test "point_to_polygon_distance inside" {
  let p = @core.Point2D::new(2.0, 2.0)
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(
    @core.approx_eq(point_to_polygon_distance(p, poly), 0.0, 0.000000001),
  )
}

///|
test "point_to_polygon_distance outside" {
  let p = @core.Point2D::new(6.0, 2.0)
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(
    @core.approx_eq(point_to_polygon_distance(p, poly), 2.0, 0.000000001),
  )
}

///|
test "point_to_polygon_distance on boundary" {
  let p = @core.Point2D::new(2.0, 0.0)
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(
    @core.approx_eq(point_to_polygon_distance(p, poly), 0.0, 0.000000001),
  )
}

///|
test "point_to_polygon_distance triangle" {
  let p = @core.Point2D::new(5.0, 5.0)
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ])
  let d = point_to_polygon_distance(p, poly)
  assert_true(d > 0.0)
}

///|
test "segment_to_segment_distance overlapping" {
  let s1 = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  let s2 = @core.Segment::new(
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
  )
  assert_true(
    @core.approx_eq(segment_to_segment_distance(s1, s2), 0.0, 0.000000001),
  )
}

///|
test "segment_to_segment_distance parallel" {
  let s1 = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  let s2 = @core.Segment::new(
    @core.Point2D::new(0.0, 3.0),
    @core.Point2D::new(4.0, 3.0),
  )
  assert_true(
    @core.approx_eq(segment_to_segment_distance(s1, s2), 3.0, 0.000000001),
  )
}

///|
test "segment_to_segment_distance disjoint" {
  let s1 = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  )
  let s2 = @core.Segment::new(
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(6.0, 5.0),
  )
  let d = segment_to_segment_distance(s1, s2)
  assert_true(d > 5.0)
}

///|
test "polygon_to_polygon_distance overlapping" {
  let p1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p2 = @core.Polygon::new([
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ])
  assert_true(
    @core.approx_eq(polygon_to_polygon_distance(p1, p2), 0.0, 0.000000001),
  )
}

///|
test "polygon_to_polygon_distance separate" {
  let p1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let p2 = @core.Polygon::new([
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(7.0, 0.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
  ])
  assert_true(
    @core.approx_eq(polygon_to_polygon_distance(p1, p2), 3.0, 0.000000001),
  )
}

///|
test "point_to_line_distance basic" {
  let p = @core.Point2D::new(0.0, 3.0)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  assert_true(
    @core.approx_eq(point_to_line_distance(p, line), 3.0, 0.000000001),
  )
}

///|
test "point_to_line_distance on line" {
  let p = @core.Point2D::new(5.0, 0.0)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  assert_true(
    @core.approx_eq(point_to_line_distance(p, line), 0.0, 0.000000001),
  )
}

///|
test "point_to_segment_distance at endpoint" {
  let p = @core.Point2D::new(0.0, 0.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  assert_true(
    @core.approx_eq(point_to_segment_distance(p, seg), 0.0, 0.000000001),
  )
}

///|
test "point_to_segment_distance on segment" {
  let p = @core.Point2D::new(2.0, 0.0)
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  assert_true(
    @core.approx_eq(point_to_segment_distance(p, seg), 0.0, 0.000000001),
  )
}

///|
test "segment_to_segment_distance parallel extra" {
  let s1 = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  let s2 = @core.Segment::new(
    @core.Point2D::new(0.0, 3.0),
    @core.Point2D::new(4.0, 3.0),
  )
  assert_true(
    @core.approx_eq(segment_to_segment_distance(s1, s2), 3.0, 0.000000001),
  )
}

///|
test "point_to_polygon_distance outside extra" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let p = @core.Point2D::new(6.0, 2.0)
  assert_true(
    @core.approx_eq(point_to_polygon_distance(p, poly), 2.0, 0.000000001),
  )
}
