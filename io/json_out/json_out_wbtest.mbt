test "point2d to json" {
  let p = @core.Point2D::new(3.0, 4.0)
  let json = point2d_to_json(p)
  assert_true(json.contains("\"x\":3"))
  assert_true(json.contains("\"y\":4"))
}

test "point3d to json" {
  let p = @core.Point3D::new(1.0, 2.0, 3.0)
  let json = point3d_to_json(p)
  assert_true(json.contains("\"x\":1"))
  assert_true(json.contains("\"z\":3"))
}

test "circle to json" {
  let c = @core.Circle::new(@core.Point2D::new(5.0, 5.0), 10.0)
  let json = circle_to_json(c)
  assert_true(json.contains("\"radius\":10"))
}

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

test "scene to json" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let segs : Array[@core.Segment] = []
  let circs : Array[@core.Circle] = []
  let json = scene_to_json(pts, segs, circs)
  assert_true(json.contains("\"points\""))
  assert_true(json.contains("\"segments\""))
  assert_true(json.contains("\"circles\""))
}