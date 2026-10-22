///|
/// Export a Point2D as JSON. / 将 Point2D 导出为 JSON。
pub fn point2d_to_json(p : @core.Point2D) -> String {
  "{\"x\":" + p.x().to_string() + ",\"y\":" + p.y().to_string() + "}"
}

///|
/// Export a Point3D as JSON. / 将 Point3D 导出为 JSON。
pub fn point3d_to_json(p : @core.Point3D) -> String {
  "{\"x\":" + p.x.to_string() + ",\"y\":" + p.y.to_string() + ",\"z\":" + p.z.to_string() + "}"
}

///|
/// Export a Segment as JSON. / 将 Segment 导出为 JSON。
pub fn segment_to_json(s : @core.Segment) -> String {
  "{\"start\":" + point2d_to_json(s.start) + ",\"end\":" + point2d_to_json(s.end) + "}"
}

///|
/// Export a Circle as JSON. / 将 Circle 导出为 JSON。
pub fn circle_to_json(c : @core.Circle) -> String {
  "{\"center\":" +
  point2d_to_json(c.center) +
  ",\"radius\":" +
  c.radius.to_string() +
  "}"
}

///|
/// Export a Rectangle as JSON. / 将 Rectangle 导出为 JSON。
pub fn rectangle_to_json(r : @core.Rectangle) -> String {
  "{\"min_x\":" +
  r.min_x.to_string() +
  ",\"min_y\":" +
  r.min_y.to_string() +
  ",\"max_x\":" +
  r.max_x.to_string() +
  ",\"max_y\":" +
  r.max_y.to_string() +
  "}"
}

///|
/// Export a Polygon as JSON. / 将 Polygon 导出为 JSON。
pub fn polygon_to_json(poly : @core.Polygon) -> String {
  let mut verts = "["
  for i in 0..<poly.size() {
    verts += point2d_to_json(poly.get(i))
    if i < poly.size() - 1 {
      verts += ","
    }
  }
  verts + "]"
}

///|
/// Export an array of Point2D as JSON. / 将 Point2D 数组导出为 JSON。
pub fn points_to_json(points : Array[@core.Point2D]) -> String {
  let mut result = "["
  for i in 0..<points.length() {
    result += point2d_to_json(points[i])
    if i < points.length() - 1 {
      result += ","
    }
  }
  result + "]"
}

///|
/// Export a Triangle as JSON. / 将 Triangle 导出为 JSON。
pub fn triangle_to_json(t : @core.Triangle) -> String {
  "{\"a\":" + point2d_to_json(t.a) + ",\"b\":" + point2d_to_json(t.b) + ",\"c\":" + point2d_to_json(t.c) + "}"
}

///|
/// Export a complete geometry scene as JSON. / 将完整几何场景导出为 JSON。
pub fn scene_to_json(
  points : Array[@core.Point2D],
  segments : Array[@core.Segment],
  circles : Array[@core.Circle],
) -> String {
  let mut pts = "["
  for i in 0..<points.length() {
    pts += point2d_to_json(points[i])
    if i < points.length() - 1 {
      pts += ","
    }
  }
  pts += "]"
  let mut segs = "["
  for i in 0..<segments.length() {
    segs += segment_to_json(segments[i])
    if i < segments.length() - 1 {
      segs += ","
    }
  }
  segs += "]"
  let mut circs = "["
  for i in 0..<circles.length() {
    circs += circle_to_json(circles[i])
    if i < circles.length() - 1 {
      circs += ","
    }
  }
  circs += "]"
  "{\"points\":" + pts + ",\"segments\":" + segs + ",\"circles\":" + circs + "}"
}