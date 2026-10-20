///|
test "sweep_line: no intersections" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 2.0),
      @core.Point2D::new(1.0, 2.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 4.0),
      @core.Point2D::new(1.0, 4.0),
    ),
  ]
  assert_false(has_any_intersection(segs))
  assert_eq(count_intersections(segs), 0)
}

///|
test "sweep_line: one intersection" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 4.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  assert_true(has_any_intersection(segs))
  assert_eq(count_intersections(segs), 1)
}

///|
test "sweep_line: multiple intersections" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 4.0),
      @core.Point2D::new(4.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 2.0),
      @core.Point2D::new(4.0, 2.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(2.0, 0.0),
      @core.Point2D::new(2.0, 4.0),
    ),
  ]
  assert_true(has_any_intersection(segs))
  assert_eq(count_intersections(segs), 6)
}

///|
test "sweep_line: find all intersections" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 4.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let pairs = find_all_intersections(segs)
  assert_eq(pairs.length(), 1)
  assert_eq(pairs[0], (0, 1))
}

///|
test "sweep_line: find intersection points" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 4.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let pts = find_intersection_points(segs)
  assert_eq(pts.length(), 1)
  let (_, _, p) = pts[0]
  assert_true(@core.approx_eq(p.x(), 2.0, 0.01))
  assert_true(@core.approx_eq(p.y(), 2.0, 0.01))
}

///|
test "sweep_line: empty segments" {
  let segs : Array[@core.Segment] = []
  assert_false(has_any_intersection(segs))
  assert_eq(count_intersections(segs), 0)
  assert_eq(find_all_intersections(segs).length(), 0)
}

///|
test "sweep_line: single segment" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 1.0),
    ),
  ]
  assert_false(has_any_intersection(segs))
}

///|
test "sweep_line: sharing endpoint not intersection" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(2.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(2.0, 0.0),
      @core.Point2D::new(2.0, 2.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(2.0, 2.0),
      @core.Point2D::new(0.0, 2.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 2.0),
      @core.Point2D::new(0.0, 0.0),
    ),
  ]
  assert_true(is_simple_polygon_chain(segs))
}

///|
test "sweep_line: self-intersecting chain" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(4.0, 4.0),
      @core.Point2D::new(0.0, 4.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 4.0),
      @core.Point2D::new(4.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(4.0, 0.0),
      @core.Point2D::new(0.0, 0.0),
    ),
  ]
  assert_false(is_simple_polygon_chain(segs))
}

///|
test "sweep_line: parallel segments no intersection" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 1.0),
      @core.Point2D::new(4.0, 1.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 2.0),
      @core.Point2D::new(4.0, 2.0),
    ),
  ]
  assert_false(has_any_intersection(segs))
  assert_eq(count_intersections(segs), 0)
}

///|
test "sweep_line: collinear overlapping" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(2.0, 0.0),
      @core.Point2D::new(6.0, 0.0),
    ),
  ]
  assert_true(has_any_intersection(segs))
}
