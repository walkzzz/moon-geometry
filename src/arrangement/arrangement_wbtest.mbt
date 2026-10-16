test "arrangement basic" {
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
  let arr = build_arrangement(segs)
  let ic = arrangement_intersection_count(arr)
  assert_eq(ic, 1)
}

test "arrangement no intersection" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 5.0),
      @core.Point2D::new(1.0, 5.0),
    ),
  ]
  let arr = build_arrangement(segs)
  let ic = arrangement_intersection_count(arr)
  assert_eq(ic, 0)
}

test "arrangement vertices" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(2.0, 0.0),
    ),
  ]
  let arr = build_arrangement(segs)
  let vs = arrangement_vertices(arr)
  assert_eq(vs.length(), 2)
}

test "arrangement edge count" {
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
  let arr = build_arrangement(segs)
  let ec = arrangement_edge_count(arr)
  assert_eq(ec, 3)
}

test "arrangement parallel" {
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
    ),
    @core.Segment::new(
      @core.Point2D::new(0.0, 1.0),
      @core.Point2D::new(4.0, 1.0),
    ),
  ]
  let arr = build_arrangement(segs)
  let ic = arrangement_intersection_count(arr)
  assert_eq(ic, 0)
}