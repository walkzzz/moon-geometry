test "svg header" {
  let s = SvgSettings::default()
  let h = svg_header(s)
  assert_true(h.contains("<svg"))
  assert_true(h.contains("width=\"400\""))
}

test "svg footer" {
  let f = svg_footer()
  assert_true(f.contains("</svg>"))
}

test "svg circle" {
  let s = SvgSettings::default()
  let c = @core.Circle::new(@core.Point2D::new(50.0, 50.0), 25.0)
  let svg = svg_circle(c, s)
  assert_true(svg.contains("<circle"))
  assert_true(svg.contains("cx=\"50\""))
}

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