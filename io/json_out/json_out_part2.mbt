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
  "{\"a\":" +
  point2d_to_json(t.a) +
  ",\"b\":" +
  point2d_to_json(t.b) +
  ",\"c\":" +
  point2d_to_json(t.c) +
  "}"
}
