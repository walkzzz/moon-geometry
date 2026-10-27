///|
test "step entity new" {
  let e = StepEntity::new("POINT", ["1.0", "2.0"])
  assert_eq(e.entity_type, "POINT")
  assert_eq(e.params.length(), 2)
  assert_eq(e.params[0], "1.0")
}

///|
test "step write step" {
  let entities = [
    StepEntity::new("POINT", ["1.0", "2.0"]),
    StepEntity::new("LINE", ["1", "2"]),
  ]
  let s = write_step(entities)
  assert_true(s.contains("ISO-10303-21"))
  assert_true(s.contains("#1 = POINT(1.0, 2.0)"))
  assert_true(s.contains("#2 = LINE(1, 2)"))
  assert_true(s.contains("END-ISO-10303-21"))
}

///|
test "step parse step" {
  let s = "#1 = POINT(1.0, 2.0);\n#2 = LINE(1, 2);\n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 2)
  assert_eq(parsed[0].entity_type, "POINT")
  assert_eq(parsed[0].params.length(), 2)
  assert_eq(parsed[1].entity_type, "LINE")
}

///|
test "step parse nested params" {
  let s = "#1 = CARTESIAN_POINT('', (0.0, 0.0, 0.0));\n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 1)
  assert_eq(parsed[0].entity_type, "CARTESIAN_POINT")
  assert_eq(parsed[0].params.length(), 2)
  assert_eq(parsed[0].params[1], "(0.0, 0.0, 0.0)")
}

///|
test "step parse empty" {
  let parsed = parse_step("")
  assert_eq(parsed.length(), 0)
}

///|
test "step roundtrip" {
  let entities = [
    StepEntity::new("POINT", ["1.0", "2.0"]),
    StepEntity::new("DIRECTION", ["(1.0, 0.0, 0.0)"]),
  ]
  let s = write_step(entities)
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 2)
  assert_eq(parsed[0].entity_type, "POINT")
  assert_eq(parsed[1].entity_type, "DIRECTION")
}

///|
test "step parse skip non entity lines" {
  let s = "ISO-10303-21;\nHEADER;\n\n#1 = POINT(1.0, 2.0);\n#2 NO_EQUALS\nENDSEC;\n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 1)
  assert_eq(parsed[0].entity_type, "POINT")
}

///|
test "step parse no paren with type" {
  let s = "#1 = SOMETYPE\n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 1)
  assert_eq(parsed[0].entity_type, "SOMETYPE")
  assert_eq(parsed[0].params.length(), 0)
}

///|
test "step parse no paren empty type" {
  let s = "#1 = \n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 0)
}

///|
test "step parse eq at end" {
  let s = "#1 ="
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 0)
}

///|
test "step parse unmatched paren at end" {
  let s = "#1 = TYPE("
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 1)
  assert_eq(parsed[0].entity_type, "TYPE")
}

///|
test "step parse empty params" {
  let s = "#1 = TYPE()\n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 1)
  assert_eq(parsed[0].entity_type, "TYPE")
  assert_eq(parsed[0].params.length(), 0)
}

///|
test "step parse trailing comma" {
  let s = "#1 = TYPE(a, b,)\n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 1)
  assert_eq(parsed[0].params.length(), 2)
  assert_eq(parsed[0].params[0], "a")
  assert_eq(parsed[0].params[1], "b")
}

///|
test "step parse multiple nested parens" {
  let s = "#1 = CP('', (0.0, 0.0, 0.0), (1.0, 1.0, 1.0));\n"
  let parsed = parse_step(s)
  assert_eq(parsed.length(), 1)
  assert_eq(parsed[0].params.length(), 3)
  assert_eq(parsed[0].params[2], "(1.0, 1.0, 1.0)")
}

///|
test "step write empty entities" {
  let s = write_step([])
  assert_true(s.contains("ISO-10303-21"))
  assert_true(s.contains("END-ISO-10303-21"))
}
