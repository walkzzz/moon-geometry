///|
/// Write a GeoJSON Polygon. / 写 GeoJSON 多边形。
pub fn geojson_polygon(rings : Array[Array[@core.Point2D]]) -> String {
  let mut out = "{\"type\":\"Polygon\",\"coordinates\":["
  for i in 0..<rings.length() {
    if i > 0 {
      out += ","
    }
    out += pts_to_json(rings[i])
  }
  out + "]}"
}

///|
/// Write a GeoJSON MultiPoint. / 写 GeoJSON 多点。
pub fn geojson_multipoint(points : Array[@core.Point2D]) -> String {
  "{\"type\":\"MultiPoint\",\"coordinates\":" + pts_to_json(points) + "}"
}

///|
/// Write a GeoJSON MultiLineString. / 写 GeoJSON 多线串。
pub fn geojson_multilinestring(lines : Array[Array[@core.Point2D]]) -> String {
  let mut out = "{\"type\":\"MultiLineString\",\"coordinates\":["
  for i in 0..<lines.length() {
    if i > 0 {
      out += ","
    }
    out += pts_to_json(lines[i])
  }
  out + "]}"
}
