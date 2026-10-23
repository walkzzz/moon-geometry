///|
/// Generate complete SVG document for a set of polygons. / 为多边形集生成完整 SVG 文档。
pub fn svg_document(
  polygons : Array[Array[@core.Point2D]],
  settings : SvgSettings,
) -> String {
  let mut doc = svg_header(settings)
  for poly in polygons {
    doc += svg_polygon(poly, settings)
  }
  doc + svg_footer()
}