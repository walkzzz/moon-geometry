///|
/// Generate SVG polygon element from points. / 由点生成 SVG 多边形元素。
pub fn svg_polygon(
  points : Array[@core.Point2D],
  settings : SvgSettings,
) -> String {
  svg_shape("polygon", points, settings)
}

///|
/// Generate SVG line element. / 生成 SVG 线段元素。
pub fn svg_line(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  settings : SvgSettings,
) -> String {
  "<line x1=\"" +
  p1.x().to_string() +
  "\" y1=\"" +
  p1.y().to_string() +
  "\" x2=\"" +
  p2.x().to_string() +
  "\" y2=\"" +
  p2.y().to_string() +
  "\" stroke=\"" +
  settings.stroke +
  "\" stroke-width=\"" +
  settings.stroke_width.to_string() +
  "\"/>\n"
}

///|
/// Generate SVG polyline element. / 生成 SVG 折线元素。
pub fn svg_polyline(
  points : Array[@core.Point2D],
  settings : SvgSettings,
) -> String {
  svg_shape("polyline", points, settings)
}
