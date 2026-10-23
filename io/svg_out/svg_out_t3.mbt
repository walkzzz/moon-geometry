///|
/// Generate SVG polygon or polyline element. / 生成 SVG 多边形或折线元素。
fn svg_shape(
  tag : String,
  points : Array[@core.Point2D],
  settings : SvgSettings,
) -> String {
  let mut pts = ""
  for i in 0..<points.length() {
    pts += svg_point(points[i])
    if i < points.length() - 1 {
      pts += " "
    }
  }
  "<" +
  tag +
  " points=\"" +
  pts +
  "\" stroke=\"" +
  settings.stroke +
  "\" fill=\"" +
  settings.fill +
  "\" stroke-width=\"" +
  settings.stroke_width.to_string() +
  "\"/>\n"
}
