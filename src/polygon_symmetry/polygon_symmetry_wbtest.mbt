test "has_reflection_symmetry_square" {
  let sq = [
    @core.Point2D::new(-2.0, -2.0),
    @core.Point2D::new(2.0, -2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(-2.0, 2.0),
  ]
  assert_true(has_reflection_symmetry(sq, 0.0))
  assert_true(has_reflection_symmetry(sq, 3.14159265358979323846 / 2.0))
}

test "has_rotation_symmetry_square" {
  let sq = [
    @core.Point2D::new(-2.0, -2.0),
    @core.Point2D::new(2.0, -2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(-2.0, 2.0),
  ]
  assert_true(has_rotation_symmetry(sq, 4))
  assert_false(has_rotation_symmetry(sq, 3))
}

test "polygon_symmetry_order_square" {
  let sq = [
    @core.Point2D::new(-2.0, -2.0),
    @core.Point2D::new(2.0, -2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(-2.0, 2.0),
  ]
  let order = polygon_symmetry_order(sq)
  assert_true(order == 4)
}

test "polygon_symmetry_order_triangle" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let order = polygon_symmetry_order(tri)
  assert_true(order == 1)
}

test "has_any_symmetry" {
  let sq = [
    @core.Point2D::new(-2.0, -2.0),
    @core.Point2D::new(2.0, -2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(-2.0, 2.0),
  ]
  assert_true(has_any_symmetry(sq))
}