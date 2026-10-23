///|
pub fn svg_header(s : SvgSettings) -> String {
  @svg_out.svg_header(s)
}

///|
pub fn svg_footer() -> String {
  @svg_out.svg_footer()
}

///|
pub fn svg_circle(c : Circle, s : SvgSettings) -> String {
  @svg_out.svg_circle(c, s)
}

///|
pub fn svg_polygon(pts : Array[Point2D], s : SvgSettings) -> String {
  @svg_out.svg_polygon(pts, s)
}

///|
pub fn svg_line(p1 : Point2D, p2 : Point2D, s : SvgSettings) -> String {
  @svg_out.svg_line(p1, p2, s)
}

///|
pub fn svg_document(polys : Array[Array[Point2D]], s : SvgSettings) -> String {
  @svg_out.svg_document(polys, s)
}

// ---------------------------------------------------------------------------
// json_out: JSON output / JSON 输出
// ---------------------------------------------------------------------------

///|
pub fn point2d_to_json(p : Point2D) -> String {
  @json_out.point2d_to_json(p)
}