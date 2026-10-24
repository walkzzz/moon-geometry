///|
test "svg header" {
  let s = SvgSettings::default()
  let h = svg_header(s)
  assert_true(h.contains("<svg"))
  assert_true(h.contains("width=\"400\""))
}

///|
test "svg footer" {
  let f = svg_footer()
  assert_true(f.contains("</svg>"))
}

///|
test "svg circle" {
  let s = SvgSettings::default()
  let c = @core.Circle::new(@core.Point2D::new(50.0, 50.0), 25.0)
  let svg = svg_circle(c, s)
  assert_true(svg.contains("<circle"))
  assert_true(svg.contains("cx=\"50\""))
}

///|
test "svg polygon" {
  let s = SvgSettings::default()
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(100.0, 0.0),
    @core.Point2D::new(50.0, 100.0),
  ]
  let svg = svg_polygon(pts, s)
  assert_true(svg.contains("<polygon"))
  assert_true(svg.contains("0,0"))
}

///|
test "svg document" {
  let s = SvgSettings::default()
  let polys : Array[Array[@core.Point2D]] = [
    [
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(100.0, 0.0),
      @core.Point2D::new(50.0, 100.0),
    ],
  ]
  let doc = svg_document(polys, s)
  assert_true(doc.contains("<svg"))
  assert_true(doc.contains("</svg>"))
  assert_true(doc.contains("<polygon"))
}
///|
test "svg_point" {
  let p = @core.Point2D::new(10.0, 20.0)
  let s = svg_point(p)
  assert_true(s.contains("10"))
  assert_true(s.contains("20"))
  assert_true(s.contains(","))
}

///|
test "svg_line" {
  let s = SvgSettings::default()
  let p1 = @core.Point2D::new(0.0, 0.0)
  let p2 = @core.Point2D::new(100.0, 100.0)
  let svg = svg_line(p1, p2, s)
  assert_true(svg.contains("<line"))
  assert_true(svg.contains("x1=\"0\""))
  assert_true(svg.contains("x2=\"100\""))
}

///|
test "svg_polyline" {
  let s = SvgSettings::default()
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(50.0, 50.0),
    @core.Point2D::new(100.0, 0.0),
  ]
  let svg = svg_polyline(pts, s)
  assert_true(svg.contains("<polyline"))
  assert_true(svg.contains("0,0"))
}

///|
test "svg_settings default values" {
  let s = SvgSettings::default()
  assert_eq(s.width, 400)
  assert_eq(s.height, 400)
  assert_eq(s.stroke, "black")
  assert_eq(s.fill, "none")
}

///|
test "svg_document empty" {
  let s = SvgSettings::default()
  let polys : Array[Array[@core.Point2D]] = []
  let doc = svg_document(polys, s)
  assert_true(doc.contains("<svg"))
  assert_true(doc.contains("</svg>"))
}
