///|
test "convex_sum_points" {
  let p1 = [@core.Point2D::new(1.0, 0.0), @core.Point2D::new(0.0, 1.0)]
  let p2 = [@core.Point2D::new(2.0, 0.0), @core.Point2D::new(0.0, 2.0)]
  let result = point_set_sum(p1, p2)
  assert_eq(result.length(), 4)
}

///|
test "convex_sum_difference" {
  let p1 = [@core.Point2D::new(3.0, 3.0)]
  let p2 = [@core.Point2D::new(1.0, 1.0)]
  let result = point_set_difference(p1, p2)
  assert_eq(result.length(), 1)
  assert_true(@core.approx_eq(result[0].x(), 2.0, 0.000000000001))
  assert_true(@core.approx_eq(result[0].y(), 2.0, 0.000000000001))
}

///|
test "convex_sum_scale" {
  let points = [@core.Point2D::new(2.0, 4.0)]
  let result = point_set_scale(points, 0.5)
  assert_true(@core.approx_eq(result[0].x(), 1.0, 0.000000000001))
  assert_true(@core.approx_eq(result[0].y(), 2.0, 0.000000000001))
}

///|
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

///|
test "convex_sum_equal" {
  let a = [@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0)]
  let b = [@core.Point2D::new(3.0, 4.0), @core.Point2D::new(1.0, 2.0)]
  assert_true(point_set_equal(a, b, 0.000000000001))
}

///|
test "convex_sum_translate" {
  let points = [@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0)]
  let result = point_set_translate(points, 10.0, -5.0)
  assert_true(@core.approx_eq(result[0].x(), 11.0, 0.000000000001))
  assert_true(@core.approx_eq(result[0].y(), -3.0, 0.000000000001))
  assert_true(@core.approx_eq(result[1].x(), 13.0, 0.000000000001))
  assert_true(@core.approx_eq(result[1].y(), -1.0, 0.000000000001))
}

///|
test "convex_sum_centroid empty returns none" {
  let points : Array[@core.Point2D] = []
  match point_set_centroid(points) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "convex_sum_equal different length" {
  let a = [@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0)]
  let b = [@core.Point2D::new(1.0, 2.0)]
  assert_false(point_set_equal(a, b, 0.000000000001))
}

///|
test "convex_sum_equal not equal no match" {
  let a = [@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0)]
  let b = [@core.Point2D::new(5.0, 6.0), @core.Point2D::new(7.0, 8.0)]
  assert_false(point_set_equal(a, b, 0.000000000001))
}

///|
test "convex_sum_equal with duplicates uses used flag" {
  let a = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let b = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  assert_true(point_set_equal(a, b, 0.000000000001))
}

///|
test "convex_sum_equal with duplicates not enough" {
  let a = [@core.Point2D::new(1.0, 1.0), @core.Point2D::new(1.0, 1.0)]
  let b = [@core.Point2D::new(1.0, 1.0), @core.Point2D::new(2.0, 2.0)]
  assert_false(point_set_equal(a, b, 0.000000000001))
}

///|
test "convex_sum_sum empty sets" {
  let p1 : Array[@core.Point2D] = []
  let p2 = [@core.Point2D::new(1.0, 1.0)]
  let result = point_set_sum(p1, p2)
  assert_eq(result.length(), 0)
}

///|
test "convex_sum_scale empty" {
  let points : Array[@core.Point2D] = []
  let result = point_set_scale(points, 2.0)
  assert_eq(result.length(), 0)
}

///|
test "convex_sum_translate empty" {
  let points : Array[@core.Point2D] = []
  let result = point_set_translate(points, 1.0, 1.0)
  assert_eq(result.length(), 0)
}
