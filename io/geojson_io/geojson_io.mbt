///|
/// GeoJSON geometry variants (RFC 7946).
/// GeoJSON 几何变体（RFC 7946）。
pub(all) enum GeoJsonGeometry {
  GeoPoint(@core.Point2D)
  GeoLineString(Array[@core.Point2D])
  GeoPolygon(Array[Array[@core.Point2D]])
  GeoMultiPoint(Array[@core.Point2D])
  GeoMultiLineString(Array[Array[@core.Point2D]])
  GeoMultiPolygon(Array[Array[Array[@core.Point2D]]])
}


///|
/// Internal JSON value for parsing. / 解析用内部 JSON 值。
pub(all) enum JsonValue {
  JNumber(Double)
  JArray(Array[JsonValue])
}


///|
/// Write a GeoJSON Point. / 写 GeoJSON 点。
pub fn geojson_point(p : @core.Point2D) -> String {
  "{\"type\":\"Point\",\"coordinates\":[" +
  p.x().to_string() +
  "," +
  p.y().to_string() +
  "]}"
}


///|
/// Write a GeoJSON LineString. / 写 GeoJSON 线串。
pub fn geojson_linestring(points : Array[@core.Point2D]) -> String {
  "{\"type\":\"LineString\",\"coordinates\":" + pts_to_json(points) + "}"
}
