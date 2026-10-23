///|
test "zone empty" {
  let line = @core.Line::new(0.0, 1.0, -2.0)
  let segs : Array[@core.Segment] = []
  let z = compute_zone(line, segs)
  assert_eq(zone_crossed_count(z), 0)
}

///|
test "zone basic" {
  let line = @core.Line::new(0.0, 1.0, -2.0)
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
    ),
  ]
  let z = compute_zone(line, segs)
  assert_eq(zone_crossed_count(z), 1)
}

///|
test "zone no crossing" {
  let line = @core.Line::new(0.0, 1.0, -10.0)
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let z = compute_zone(line, segs)
  assert_eq(zone_crossed_count(z), 0)
}

///|
test "zone complexity" {
  let line = @core.Line::new(0.0, 1.0, -2.0)
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
  let z = compute_zone(line, segs)
  let c = zone_complexity(z)
  assert_true(c >= 1)
}

///|
test "zone bound" {
  let bound = zone_complexity_bound(10)
  assert_eq(bound, 51)
}
