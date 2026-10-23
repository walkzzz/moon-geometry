///|
pub fn point3d_to_json(p : Point3D) -> String {
  @json_out.point3d_to_json(p)
}

///|
pub fn segment_to_json(s : Segment) -> String {
  @json_out.segment_to_json(s)
}

///|
pub fn circle_to_json(c : Circle) -> String {
  @json_out.circle_to_json(c)
}

///|
pub fn rectangle_to_json(r : Rectangle) -> String {
  @json_out.rectangle_to_json(r)
}

///|
pub fn polygon_to_json(p : Polygon) -> String {
  @json_out.polygon_to_json(p)
}

///|
pub fn points_to_json(pts : Array[Point2D]) -> String {
  @json_out.points_to_json(pts)
}

///|
pub fn triangle_to_json(t : Triangle) -> String {
  @json_out.triangle_to_json(t)
}