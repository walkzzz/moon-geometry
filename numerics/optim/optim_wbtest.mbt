///|
test "smallest enclosing circle single" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  let c = smallest_enclosing_circle(pts)
  assert_true((c.center.x() - 1.0).abs() < 0.001)
  assert_true((c.center.y() - 2.0).abs() < 0.001)
}

///|
test "smallest enclosing circle two" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let c = smallest_enclosing_circle(pts)
  assert_true((c.center.x() - 2.0).abs() < 0.001)
  assert_true((c.radius - 2.0).abs() < 0.001)
}

///|
test "smallest enclosing circle three" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let c = smallest_enclosing_circle(pts)
  assert_true(c.radius > 0.0)
}

///|
test "min area rect" {
  let pts = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(3.0, 7.0),
  ]
  let r = min_area_rect(pts)
  assert_true((r.min_x - 1.0).abs() < 0.001)
  assert_true((r.max_x - 5.0).abs() < 0.001)
}

///|
test "centroid" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(0.0, 6.0),
  ]
  let c = centroid(pts)
  assert_true((c.x() - 2.0).abs() < 0.001)
  assert_true((c.y() - 2.0).abs() < 0.001)
}
///|
test "smallest enclosing circle empty" {
  let c = smallest_enclosing_circle([])
  assert_true((c.center.x() - 0.0).abs() < 0.001)
  assert_true((c.center.y() - 0.0).abs() < 0.001)
  assert_true(c.radius.abs() < 0.001)
}

///|
test "smallest enclosing circle collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let c = smallest_enclosing_circle(pts)
  assert_true((c.center.x() - 2.0).abs() < 0.01)
  assert_true((c.radius - 2.0).abs() < 0.01)
}

///|
test "smallest enclosing circle square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let c = smallest_enclosing_circle(pts)
  assert_true((c.center.x() - 2.0).abs() < 0.01)
  assert_true((c.center.y() - 2.0).abs() < 0.01)
}

///|
test "min area rect empty" {
  let r = min_area_rect([])
  assert_true((r.min_x - 0.0).abs() < 0.001)
  assert_true((r.max_x - 0.0).abs() < 0.001)
}

///|
test "min area rect single" {
  let r = min_area_rect([@core.Point2D::new(3.0, 5.0)])
  assert_true((r.min_x - 3.0).abs() < 0.001)
  assert_true((r.max_x - 3.0).abs() < 0.001)
  assert_true((r.min_y - 5.0).abs() < 0.001)
}

///|
test "min area rect negative" {
  let pts = [
    @core.Point2D::new(-3.0, -5.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let r = min_area_rect(pts)
  assert_true((r.min_x - -3.0).abs() < 0.001)
  assert_true((r.max_x - 2.0).abs() < 0.001)
  assert_true((r.min_y - -5.0).abs() < 0.001)
}

///|
test "centroid empty" {
  let c = centroid([])
  assert_true((c.x() - 0.0).abs() < 0.001)
  assert_true((c.y() - 0.0).abs() < 0.001)
}

///|
test "centroid single" {
  let c = centroid([@core.Point2D::new(3.0, 7.0)])
  assert_true((c.x() - 3.0).abs() < 0.001)
  assert_true((c.y() - 7.0).abs() < 0.001)
}

///|
test "closest_to_centroid empty" {
  match closest_to_centroid([]) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "closest_to_centroid single" {
  match closest_to_centroid([@core.Point2D::new(3.0, 5.0)]) {
    Some(p) => {
      assert_true((p.x() - 3.0).abs() < 0.001)
      assert_true((p.y() - 5.0).abs() < 0.001)
    }
    None => assert_true(false)
  }
}

///|
test "closest_to_centroid basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
  ]
  match closest_to_centroid(pts) {
    Some(p) => assert_true((p.x() - 5.0).abs() < 0.001)
    None => assert_true(false)
  }
}

///|
test "closest_to_centroid symmetric" {
  let pts = [
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  match closest_to_centroid(pts) {
    Some(_) => assert_true(true)
    None => assert_true(false)
  }
}

///|
test "circle_from_one basic" {
  let p = @core.Point2D::new(3.0, 4.0)
  let c = circle_from_one(p)
  assert_true((c.center.x() - 3.0).abs() < 0.001)
  assert_true((c.center.y() - 4.0).abs() < 0.001)
  assert_true(c.radius.abs() < 0.001)
}

///|
test "circle_from_two basic" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(4.0, 0.0)
  let c = circle_from_two(p1, p2)
  assert_true((c.center.x() - 2.0).abs() < 0.001)
  assert_true((c.center.y() - 0.0).abs() < 0.001)
  assert_true((c.radius - 2.0).abs() < 0.001)
}

///|
test "circle_from_two same point" {
  let p = @core.Point2D::new(3.0, 5.0)
  let c = circle_from_two(p, p)
  assert_true((c.center.x() - 3.0).abs() < 0.001)
  assert_true(c.radius.abs() < 0.001)
}

///|
test "circle_from_three basic" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(4.0, 0.0)
  let p3 = @core.Point2D::new(2.0, 2.0)
  let c = circle_from_three(p1, p2, p3)
  assert_true(c.radius > 0.0)
}

///|
test "circle_from_three collinear" {
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(2.0, 0.0)
  let p3 = @core.Point2D::new(4.0, 0.0)
  let c = circle_from_three(p1, p2, p3)
  assert_true(c.radius >= 0.0)
}

///|
test "circle_contains inside" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let p = @core.Point2D::new(3.0, 0.0)
  assert_true(circle_contains(c, p))
}

///|
test "circle_contains outside" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let p = @core.Point2D::new(5.0, 0.0)
  assert_false(circle_contains(c, p))
}

///|
test "circle_contains boundary" {
  let c = @core.Circle::new(@core.Point2D::new(0.0, 0.0), 5.0)
  let p = @core.Point2D::new(5.0, 0.0)
  assert_true(circle_contains(c, p))
}
