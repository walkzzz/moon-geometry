test "de9im_intersects" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_intersects(a, b))
}

test "de9im_contains" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_contains(a, b))
}

test "de9im_disjoint" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let b = (@core.Point2D::new(2.0, 2.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_disjoint(a, b))
}

test "de9im_within" {
  let a = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  let b = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  assert_true(de9im_within(a, b))
}
