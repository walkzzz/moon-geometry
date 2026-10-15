test "polygon_kernel_convex" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let kernel = polygon_kernel(sq)
  assert_true(kernel.length() >= 3)
}

test "is_star_shaped_convex" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_star_shaped(sq))
}

test "is_star_shaped_concave" {
  let star = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(0.0, 6.0),
    @core.Point2D::new(1.0, 3.0),
  ]
  assert_true(is_star_shaped(star))
}

test "polygon_kernel_area" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let area = polygon_kernel_area(sq)
  assert_true(area > 1.0)
}

test "kernel_point" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pt = kernel_point(sq)
  assert_true(pt.is_some())
}