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
