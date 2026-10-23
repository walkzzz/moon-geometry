///|
test "trapezoidal map empty" {
  let segs : Array[@core.Segment] = []
  let map = build_trapezoidal_map(segs)
  assert_eq(trapezoidal_count(map), 1)
}

///|
test "trapezoidal map basic" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let map = build_trapezoidal_map(segs)
  assert_true(trapezoidal_count(map) >= 1)
}

///|
test "trapezoidal locate" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let map = build_trapezoidal_map(segs)
  let idx = trapezoidal_locate(map, @core.Point2D::new(2.0, 1.0))
  assert_true(idx >= 0)
}

///|
test "trapezoidal above segment" {
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  )
  let above = trapezoidal_above_segment(seg, @core.Point2D::new(2.0, 1.0))
  assert_true(above)
  let below = trapezoidal_above_segment(seg, @core.Point2D::new(2.0, -1.0))
  assert_false(below)
}

///|
test "trapezoidal expected count" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(2.0, 0.0),
      @core.Point2D::new(3.0, 0.0),
    ),
  ]
  let map = build_trapezoidal_map(segs)
  assert_eq(trapezoidal_expected_count(map), 7)
}
