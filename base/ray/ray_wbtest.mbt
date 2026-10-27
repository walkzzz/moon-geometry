///|
test "ray_new" {
  let r = Ray::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0))
  assert_true(@core.approx_eq(r.origin.x(), 0.0, 0.000000000001))
  assert_true(@core.approx_eq(r.dir.x(), 1.0, 0.000000000001))
}

///|
test "ray_from_points" {
  let r = Ray::from_points(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  )
  assert_true(@core.approx_eq(r.dir.x(), 3.0, 0.000000000001))
  assert_true(@core.approx_eq(r.dir.y(), 4.0, 0.000000000001))
}

///|
test "ray_eval" {
  let r = Ray::new(@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0))
  let p = Ray::eval(r, 2.0)
  assert_true(@core.approx_eq(p.x(), 7.0, 0.000000000001))
  assert_true(@core.approx_eq(p.y(), 10.0, 0.000000000001))
}

///|
test "ray_segment_intersect_hit" {
  let r = Ray::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0))
  let seg = @core.Segment::new(
    @core.Point2D::new(2.0, -1.0),
    @core.Point2D::new(2.0, 1.0),
  )
  match ray_segment_intersect(r, seg) {
    Some(p) => {
      assert_true(@core.approx_eq(p.x(), 2.0, 0.000000000001))
      assert_true(@core.approx_eq(p.y(), 0.0, 0.000000000001))
    }
    None => assert_true(false)
  }
}

///|
test "ray_segment_intersect_miss" {
  let r = Ray::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0))
  let seg = @core.Segment::new(
    @core.Point2D::new(-2.0, -1.0),
    @core.Point2D::new(-2.0, 1.0),
  )
  match ray_segment_intersect(r, seg) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray_line_intersect" {
  let r = Ray::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let line = @core.Line::new(1.0, 0.0, -3.0)
  match ray_line_intersect(r, line) {
    Some(p) => assert_true(@core.approx_eq(p.x(), 3.0, 0.000000000001))
    None => assert_true(false)
  }
}

///|
test "ray_polygon_contains" {
  let r = Ray::new(@core.Point2D::new(0.5, 0.5), @core.Point2D::new(1.0, 0.0))
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  assert_true(ray_polygon_contains(r, poly))
}

///|
test "ray_polygon_not_contains" {
  let r = Ray::new(@core.Point2D::new(5.0, 5.0), @core.Point2D::new(1.0, 0.0))
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  assert_false(ray_polygon_contains(r, poly))
}

///|
test "ray_polygon_intersect" {
  let r = Ray::new(@core.Point2D::new(0.5, 0.5), @core.Point2D::new(1.0, 0.0))
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let hits = ray_polygon_intersect(r, poly)
  assert_true(hits.length() > 0)
}

///|
test "ray_polygon_intersect_miss" {
  let r = Ray::new(@core.Point2D::new(5.0, 5.0), @core.Point2D::new(1.0, 0.0))
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ])
  let hits = ray_polygon_intersect(r, poly)
  assert_true(hits.length() == 0)
}

///|
test "ray_segment_intersect_parallel" {
  let r = Ray::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0))
  let seg = @core.Segment::new(
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  )
  match ray_segment_intersect(r, seg) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray_line_intersect_parallel" {
  let r = Ray::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0))
  let line = @core.Line::new(0.0, 1.0, -1.0)
  match ray_line_intersect(r, line) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "ray_eval_zero_t" {
  let r = Ray::new(@core.Point2D::new(2.0, 3.0), @core.Point2D::new(1.0, 1.0))
  let p = Ray::eval(r, 0.0)
  assert_true(@core.approx_eq(p.x(), 2.0, 0.000000000001))
  assert_true(@core.approx_eq(p.y(), 3.0, 0.000000000001))
}
