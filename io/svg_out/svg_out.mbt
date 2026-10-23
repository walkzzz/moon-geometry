///|
/// SVG output settings. / SVG 输出设置。
pub struct SvgSettings {
  width : Int32
  height : Int32
  stroke : String
  fill : String
  stroke_width : Double
}

///|
/// Default SVG settings. / 默认 SVG 设置。
pub fn SvgSettings::default() -> SvgSettings {
  { width: 400, height: 400, stroke: "black", fill: "none", stroke_width: 1.0, }
}

///|
/// Generate SVG header. / 生成 SVG 头部。
pub fn svg_header(settings : SvgSettings) -> String {
  "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"" +
  settings.width.to_string() +
  "\" height=\"" +
  settings.height.to_string() +
  "\">\n"
}

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
pub fn svg_circle(circle : @core.Circle, settings : SvgSettings) -> String {
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
