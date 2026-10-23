///|
/// Generate SVG footer. / 生成 SVG 尾部。
pub fn svg_footer() -> String {
  "</svg>\n"
}


///|
/// Format a point as SVG coordinate. / 将点格式化为 SVG 坐标。
pub fn svg_point(p : @core.Point2D) -> String {
  p.x().to_string() + "," + p.y().to_string()
}


///|
/// Generate SVG circle element. / 生成 SVG 圆元素。
pub fn svg_circle(
  circle : @core.Circle,
  settings : SvgSettings,
) -> String {
  "<circle cx=\"" +
  circle.center.x().to_string() +
  "\" cy=\"" +
  circle.center.y().to_string() +
  "\" r=\"" +
  circle.radius.to_string() +
  "\" stroke=\"" +
  settings.stroke +
  "\" fill=\"" +
  settings.fill +
  "\" stroke-width=\"" +
  settings.stroke_width.to_string() +
  "\"/>\n"
}
