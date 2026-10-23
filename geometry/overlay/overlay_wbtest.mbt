///|
test "overlay basic" {
  let segs1 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
    ),
  ]
  let segs2 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 4.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let result = overlay(segs1, segs2)
  assert_true(overlay_vertex_count(result) >= 4)
}

///|
test "overlay no intersection" {
  let segs1 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 0.0),
    ),
  ]
  let segs2 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 5.0),
      @core.Point2D::new(1.0, 5.0),
    ),
  ]
  let result = overlay(segs1, segs2)
  assert_eq(overlay_vertex_count(result), 4)
  assert_eq(overlay_edge_count(result), 2)
}

///|
test "overlay edge count" {
  let segs1 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let segs2 = [
    @core.Segment::new(
      @core.Point2D::new(2.0, -2.0),
      @core.Point2D::new(2.0, 2.0),
    ),
  ]
  let result = overlay(segs1, segs2)
  assert_true(overlay_edge_count(result) >= 2)
}

///|
test "overlay vertices" {
  let segs1 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(2.0, 0.0),
    ),
  ]
  let segs2 : Array[@core.Segment] = []
  let result = overlay(segs1, segs2)
  assert_eq(overlay_vertex_count(result), 2)
}

///|
test "overlay parallel" {
  let segs1 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
  ]
  let segs2 = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 1.0),
      @core.Point2D::new(4.0, 1.0),
    ),
  ]
  let result = overlay(segs1, segs2)
  assert_eq(overlay_vertex_count(result), 4)
}
