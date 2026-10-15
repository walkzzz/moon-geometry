test "polygon_offset_outward_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let offset = polygon_offset_outward(sq, 1.0)
  assert_true(offset.length() == 4)
  assert_true(offset[0].x() < 0.0)
  assert_true(offset[0].y() < 0.0)
}

test "polygon_offset_inward_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let offset = polygon_offset_inward(sq, 1.0)
  assert_true(offset.length() == 4)
  assert_true(offset[0].x() > 0.0)
  assert_true(offset[0].y() > 0.0)
}

test "polygon_offset_area_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = polygon_offset_area(sq, 1.0)
  let expected = 16.0 + 16.0 * 1.0 + 3.14159265358979323846 * 1.0 * 1.0
  assert_true((area - expected).abs() < 0.001)
}

test "polygon_offset_valid" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(1.5, 3.0),
  ]
  assert_true(polygon_offset_valid(tri, 0.5))
}

test "polygon_offset_empty" {
  let empty : Array[@core.Point2D] = []
  let offset = polygon_offset_outward(empty, 1.0)
  assert_true(offset.length() == 0)
}