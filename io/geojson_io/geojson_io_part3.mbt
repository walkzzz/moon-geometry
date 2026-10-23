///|
/// Write a GeoJSON MultiPolygon. / 写 GeoJSON 多多边形。
pub fn geojson_multipolygon(
  polygons : Array[Array[Array[@core.Point2D]]],
) -> String {
  let mut out = "{\"type\":\"MultiPolygon\",\"coordinates\":["
  for i in 0..<polygons.length() {
    if i > 0 {
      out += ","
    }
    out += "["
    for j in 0..<polygons[i].length() {
      if j > 0 {
        out += ","
      }
      out += pts_to_json(polygons[i][j])
    }
    out += "]"
  }
  out + "]}"
}

///|
/// Write any GeoJSON geometry. / 写任意 GeoJSON 几何。
pub fn geojson_write(geom : GeoJsonGeometry) -> String {
  match geom {
    GeoPoint(p) => geojson_point(p)
    GeoLineString(pts) => geojson_linestring(pts)
    GeoPolygon(rings) => geojson_polygon(rings)
    GeoMultiPoint(pts) => geojson_multipoint(pts)
    GeoMultiLineString(lines) => geojson_multilinestring(lines)
    GeoMultiPolygon(polys) => geojson_multipolygon(polys)
  }
}
