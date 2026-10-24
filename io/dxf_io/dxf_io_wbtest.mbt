///|
test "dxf empty document" {
  let d = DxfDocument::new()
  assert_eq(DxfDocument::entity_count(d), 0)
}

///|
test "dxf write line" {
  let d = DxfDocument::new()
  d.entities.push(
    DxfLine(
      @core.Point3D::new(1.0, 2.0, 3.0),
      @core.Point3D::new(4.0, 5.0, 6.0),
    ),
  )
  let s = dxf_write(d)
  assert_true(s.contains("LINE"))
  assert_true(s.contains("ENTITIES"))
  assert_true(s.contains("EOF"))
}

///|
test "dxf write circle" {
  let d = DxfDocument::new()
  d.entities.push(DxfCircle(@core.Point2D::new(1.0, 2.0), 5.0))
  let s = dxf_write(d)
  assert_true(s.contains("CIRCLE"))
  assert_true(s.contains("5"))
}

///|
test "dxf parse line" {
  let text = "0\nSECTION\n2\nENTITIES\n0\nLINE\n10\n1\n20\n2\n30\n3\n11\n4\n21\n5\n31\n6\n0\nENDSEC\n0\nEOF\n"
  let d = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d), 1)
}

///|
test "dxf parse circle" {
  let text = "0\nSECTION\n2\nENTITIES\n0\nCIRCLE\n10\n1\n20\n2\n40\n5\n0\nENDSEC\n0\nEOF\n"
  let d = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d), 1)
}

///|
test "dxf parse multiple" {
  let text = "0\nSECTION\n2\nENTITIES\n0\nLINE\n10\n0\n20\n0\n30\n0\n11\n1\n21\n0\n31\n0\n0\nCIRCLE\n10\n0\n20\n0\n40\n1\n0\nENDSEC\n0\nEOF\n"
  let d = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d), 2)
}

///|
test "dxf write polyline" {
  let d = DxfDocument::new()
  d.entities.push(
    DxfPolyline([
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 0.0),
      @core.Point2D::new(1.0, 1.0),
    ]),
  )
  let s = dxf_write(d)
  assert_true(s.contains("LWPOLYLINE"))
  assert_true(s.contains("3"))
}

///|
test "dxf parse polyline" {
  let text = "0\nSECTION\n2\nENTITIES\n0\nLWPOLYLINE\n90\n2\n10\n0\n20\n0\n10\n1\n20\n1\n0\nENDSEC\n0\nEOF\n"
  let d = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d), 1)
}

///|
test "dxf roundtrip line" {
  let d = DxfDocument::new()
  d.entities.push(
    DxfLine(
      @core.Point3D::new(1.0, 2.0, 3.0),
      @core.Point3D::new(4.0, 5.0, 6.0),
    ),
  )
  let text = dxf_write(d)
  let d2 = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d2), 1)
}

///|
test "dxf write contains section" {
  let d = DxfDocument::new()
  let s = dxf_write(d)
  assert_true(s.contains("SECTION"))
  assert_true(s.contains("ENDSEC"))
}
///|
test "pd positive integer" {
  assert_true((pd("42".to_string_view()) - 42.0).abs() < 0.001)
}

///|
test "pd negative integer" {
  assert_true((pd("-42".to_string_view()) - -42.0).abs() < 0.001)
}

///|
test "pd decimal" {
  assert_true((pd("3.14".to_string_view()) - 3.14).abs() < 0.001)
}

///|
test "pd negative decimal" {
  assert_true((pd("-3.14".to_string_view()) - -3.14).abs() < 0.001)
}

///|
test "pd empty" {
  assert_true(pd("".to_string_view()) == 0.0)
}

///|
test "pd with plus sign" {
  assert_true((pd("+42".to_string_view()) - 42.0).abs() < 0.001)
}

///|
test "pi positive integer" {
  assert_eq(pi("42".to_string_view()), 42)
}

///|
test "pi negative integer" {
  assert_eq(pi("-42".to_string_view()), -42)
}

///|
test "pi empty" {
  assert_eq(pi("".to_string_view()), 0)
}

///|
test "pi with plus sign" {
  assert_eq(pi("+42".to_string_view()), 42)
}

///|
test "dxf parse unknown entity" {
  let text = "0\nSECTION\n2\nENTITIES\n0\nUNKNOWN\n10\n1\n20\n2\n0\nENDSEC\n0\nEOF\n"
  let d = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d), 0)
}

///|
test "dxf parse empty text" {
  let d = dxf_parse("")
  assert_eq(DxfDocument::entity_count(d), 0)
}

///|
test "dxf write multiple entities" {
  let d = DxfDocument::new()
  d.entities.push(
    DxfLine(
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 1.0, 1.0),
    ),
  )
  d.entities.push(DxfCircle(@core.Point2D::new(2.0, 2.0), 3.0))
  let s = dxf_write(d)
  assert_true(s.contains("LINE"))
  assert_true(s.contains("CIRCLE"))
}

///|
test "dxf parse with whitespace" {
  let text = "0\nSECTION\n2\nENTITIES\n0\nLINE\n10\n  1  \n20\n2\n30\n3\n11\n4\n21\n5\n31\n6\n0\nENDSEC\n0\nEOF\n"
  let d = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d), 1)
}

///|
test "dxf roundtrip circle" {
  let d = DxfDocument::new()
  d.entities.push(DxfCircle(@core.Point2D::new(1.5, 2.5), 3.5))
  let text = dxf_write(d)
  let d2 = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d2), 1)
}

///|
test "dxf parse negative coords" {
  let text = "0\nSECTION\n2\nENTITIES\n0\nLINE\n10\n-1.5\n20\n-2.5\n30\n0\n11\n3.5\n21\n4.5\n31\n0\n0\nENDSEC\n0\nEOF\n"
  let d = dxf_parse(text)
  assert_eq(DxfDocument::entity_count(d), 1)
}
