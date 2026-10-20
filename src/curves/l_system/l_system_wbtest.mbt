test "l_system step basic" {
  let rules = [LRule::new("F", "F+F")]
  let system = LSystem::new("F", rules)
  let result = lsystem_step(system, "F")
  assert_true(result == "F+F")
}

test "l_system iterate koch" {
  let rules = [LRule::new("F", "F-F++F-F")]
  let system = LSystem::new("F", rules)
  let s = lsystem_iterate(system, 1)
  assert_true(s == "F-F++F-F")
}

test "l_system iterate two steps" {
  let rules = [LRule::new("F", "FF")]
  let system = LSystem::new("F", rules)
  let s = lsystem_iterate(system, 2)
  assert_true(s == "FFFF")
}

test "l_system turtle interpret line" {
  let pts = turtle_interpret("F", 1.5707963267948966, 1.0)
  assert_eq(pts.length(), 2)
  assert_true(pts[0].x().abs() < 0.000000001)
  assert_true(pts[0].y().abs() < 0.000000001)
  assert_true((pts[1].x() - 1.0).abs() < 0.000000001)
}

test "l_system turtle turn" {
  let pts = turtle_interpret("F+F", 1.5707963267948966, 1.0)
  assert_eq(pts.length(), 3)
  assert_true((pts[1].x() - 1.0).abs() < 0.000000001)
  assert_true((pts[2].y() - 1.0).abs() < 0.000000001)
}

test "l_system koch snowflake" {
  let pts = koch_snowflake(2, 1.0)
  assert_true(pts.length() > 3)
}

test "l_system sierpinski arrowhead" {
  let pts = sierpinski_arrowhead(3, 1.0)
  assert_true(pts.length() > 3)
}

test "l_system dragon curve" {
  let pts = dragon_curve(5, 1.0)
  assert_true(pts.length() > 3)
}

test "l_system fractal plant" {
  let pts = fractal_plant(3, 1.0)
  assert_true(pts.length() > 1)
}

test "l_system count segments" {
  let rules = [LRule::new("F", "FF")]
  let system = LSystem::new("F", rules)
  let s = lsystem_iterate(system, 3)
  assert_eq(count_segments(s), 8)
}

test "l_system bracket push pop" {
  let pts = turtle_interpret("F[+F]F", 1.5707963267948966, 1.0)
  assert_true(pts.length() > 3)
}