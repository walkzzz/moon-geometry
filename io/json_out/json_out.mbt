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
