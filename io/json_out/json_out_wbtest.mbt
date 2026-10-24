///|
test "point2d to json" {
  let p = @core.Point2D::new(3.0, 4.0)
  let json = point2d_to_json(p)
  assert_true(json.contains("\"x\":3"))
  assert_true(json.contains("\"y\":4"))
}

///|
test "point3d to json" {
  let p = @core.Point3D::new(1.0, 2.0, 3.0)
  let json = point3d_to_json(p)
  assert_true(json.contains("\"x\":1"))
  assert_true(json.contains("\"z\":3"))
}

///|
test "circle to json" {
  let c = @core.Circle::new(@core.Point2D::new(5.0, 5.0), 10.0)
  let json = circle_to_json(c)
  assert_true(json.contains("\"radius\":10"))
}

///|
test "polygon to json" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let poly = @core.Polygon::new(pts)
  let json = polygon_to_json(poly)
  assert_true(json.contains("["))
  assert_true(json.contains("]"))
}

///|
test "scene to json" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let segs : Array[@core.Segment] = []
  let circs : Array[@core.Circle] = []
  let json = scene_to_json(pts, segs, circs)
  assert_true(json.contains("\"points\""))
  assert_true(json.contains("\"segments\""))
  assert_true(json.contains("\"circles\""))
}

///|
test "segment to json" {
  let s = @core.Segment::new(
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 4.0),
  )
  let json = segment_to_json(s)
  assert_true(json.contains("\"start\""))
  assert_true(json.contains("\"end\""))
  assert_true(json.contains("\"x\":1"))
  assert_true(json.contains("\"x\":3"))
}

///|
test "rectangle to json" {
  let r = @core.Rectangle::new(0.0, 1.0, 2.0, 3.0)
  let json = rectangle_to_json(r)
  assert_true(json.contains("\"min_x\":0"))
  assert_true(json.contains("\"min_y\":1"))
  assert_true(json.contains("\"max_x\":2"))
  assert_true(json.contains("\"max_y\":3"))
}

///|
test "points to json" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let json = points_to_json(pts)
  assert_true(json.contains("["))
  assert_true(json.contains("]"))
  assert_true(json.contains("\"x\":1"))
}

///|
test "points to json empty" {
  let pts : Array[@core.Point2D] = []
  let json = points_to_json(pts)
  assert_eq(json, "[]")
}

///|
test "triangle to json" {
  let t = @core.Triangle::new(
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  )
  let json = triangle_to_json(t)
  assert_true(json.contains("\"a\""))
  assert_true(json.contains("\"b\""))
  assert_true(json.contains("\"c\""))
}
///|
test "point2d to json negative" {
  let p = @core.Point2D::new(-3.0, -4.5)
  let json = point2d_to_json(p)
  assert_true(json.contains("\"x\":-3"))
  assert_true(json.contains("\"y\":-4.5"))
}

///|
test "point3d to json negative" {
  let p = @core.Point3D::new(-1.0, -2.0, -3.0)
  let json = point3d_to_json(p)
  assert_true(json.contains("\"x\":-1"))
  assert_true(json.contains("\"y\":-2"))
  assert_true(json.contains("\"z\":-3"))
}

///|
test "polygon to json single vertex" {
  let pts = [@core.Point2D::new(5.0, 5.0)]
  let poly = @core.Polygon::new(pts)
  let json = polygon_to_json(poly)
  assert_true(json.contains("\"x\":5"))
  assert_true(json.contains("\"y\":5"))
}

///|
test "points to json single" {
  let pts = [@core.Point2D::new(7.0, 8.0)]
  let json = points_to_json(pts)
  assert_true(json.contains("\"x\":7"))
  assert_true(json.contains("\"y\":8"))
}

///|
test "scene to json all empty" {
  let pts : Array[@core.Point2D] = []
  let segs : Array[@core.Segment] = []
  let circs : Array[@core.Circle] = []
  let json = scene_to_json(pts, segs, circs)
  assert_true(json.contains("\"points\":[]"))
  assert_true(json.contains("\"segments\":[]"))
  assert_true(json.contains("\"circles\":[]"))
}

///|
test "scene to json multi elements" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let segs = [
    @core.Segment::new(
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 0.0),
    ),
  ]
  let circs = [@core.Circle::new(@core.Point2D::new(0.0, 0.0), 1.0)]
  let json = scene_to_json(pts, segs, circs)
  assert_true(json.contains("\"points\""))
  assert_true(json.contains("\"segments\""))
  assert_true(json.contains("\"circles\""))
  assert_true(json.contains("\"radius\":1"))
}

///|
test "triangle to json negative coords" {
  let t = @core.Triangle::new(
    @core.Point2D::new(-1.0, -1.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
  )
  let json = triangle_to_json(t)
  assert_true(json.contains("\"a\""))
  assert_true(json.contains("\"b\""))
  assert_true(json.contains("\"c\""))
  assert_true(json.contains("\"x\":-1"))
}

///|
test "circle to json negative radius" {
  let c = @core.Circle::new(@core.Point2D::new(-5.0, -5.0), -10.0)
  let json = circle_to_json(c)
  assert_true(json.contains("\"radius\":-10"))
}

///|
test "rectangle to json negatives" {
  let r = @core.Rectangle::new(-5.0, -5.0, 5.0, 5.0)
  let json = rectangle_to_json(r)
  assert_true(json.contains("\"min_x\":-5"))
  assert_true(json.contains("\"max_x\":5"))
}
