///|
test "de9im_intersects" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_intersects(a, b))
}

///|
test "de9im_contains" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_contains(a, b))
}

///|
test "de9im_disjoint" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let b = (@core.Point2D::new(2.0, 2.0), @core.Point2D::new(3.0, 3.0))
  assert_true(de9im_disjoint(a, b))
}

///|
test "de9im_within" {
  let a = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  let b = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  assert_true(de9im_within(a, b))
}

///|
test "de9im_touches edge contact" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(2.0, 0.0), @core.Point2D::new(4.0, 2.0))
  assert_true(de9im_touches(a, b))
}

///|
test "de9im_touches overlapping not touching" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_false(de9im_touches(a, b))
}

///|
test "de9im_touches disjoint not touching" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let b = (@core.Point2D::new(5.0, 5.0), @core.Point2D::new(6.0, 6.0))
  assert_false(de9im_touches(a, b))
}

///|
test "de9im_touches vertical edge contact" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(0.0, 2.0), @core.Point2D::new(2.0, 4.0))
  assert_true(de9im_touches(a, b))
}

///|
test "de9im_intersects disjoint" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let b = (@core.Point2D::new(5.0, 5.0), @core.Point2D::new(6.0, 6.0))
  assert_false(de9im_intersects(a, b))
}

///|
test "de9im_contains not contained" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_false(de9im_contains(a, b))
}

///|
test "de9im_disjoint overlapping" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_false(de9im_disjoint(a, b))
}

///|
test "de9im_within not within" {
  let a = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  let b = (@core.Point2D::new(1.0, 1.0), @core.Point2D::new(3.0, 3.0))
  assert_false(de9im_within(a, b))
}
