test "convex_sum_points" {
  let p1 = [@core.Point2D::new(1.0, 0.0), @core.Point2D::new(0.0, 1.0)]
  let p2 = [@core.Point2D::new(2.0, 0.0), @core.Point2D::new(0.0, 2.0)]
  let result = point_set_sum(p1, p2)
  assert_eq(result.length(), 4)
}

test "convex_sum_difference" {
  let p1 = [@core.Point2D::new(3.0, 3.0)]
  let p2 = [@core.Point2D::new(1.0, 1.0)]
  let result = point_set_difference(p1, p2)
  assert_eq(result.length(), 1)
  assert_true(@core.approx_eq(result[0].x(), 2.0, 0.000000000001))
  assert_true(@core.approx_eq(result[0].y(), 2.0, 0.000000000001))
}

test "convex_sum_scale" {
  let points = [@core.Point2D::new(2.0, 4.0)]
  let result = point_set_scale(points, 0.5)
  assert_true(@core.approx_eq(result[0].x(), 1.0, 0.000000000001))
  assert_true(@core.approx_eq(result[0].y(), 2.0, 0.000000000001))
}

test "convex_sum_centroid" {
  let points = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  match point_set_centroid(points) {
    Some(p) => {
      assert_true(@core.approx_eq(p.x(), 2.0 / 3.0, 0.0001))
      assert_true(@core.approx_eq(p.y(), 2.0 / 3.0, 0.0001))
    }
    None => assert_true(false)
  }
}

test "convex_sum_equal" {
  let a = [@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0)]
  let b = [@core.Point2D::new(3.0, 4.0), @core.Point2D::new(1.0, 2.0)]
  assert_true(point_set_equal(a, b, 0.000000000001))
}