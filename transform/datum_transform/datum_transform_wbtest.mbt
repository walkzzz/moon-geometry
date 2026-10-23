///|
test "helmert7 identity" {
  let h = helmert7_identity()
  let (x, y, z) = apply_helmert7(h, 100.0, 200.0, 300.0)
  assert_true((x - 100.0).abs() <= 0.001)
  assert_true((y - 200.0).abs() <= 0.001)
  assert_true((z - 300.0).abs() <= 0.001)
}

///|
test "helmert7 translation only" {
  let h = Helmert7::new(10.0, 20.0, 30.0, 0.0, 0.0, 0.0, 0.0)
  let (x, y, z) = apply_helmert7(h, 0.0, 0.0, 0.0)
  assert_true((x - 10.0).abs() <= 0.001)
  assert_true((y - 20.0).abs() <= 0.001)
  assert_true((z - 30.0).abs() <= 0.001)
}

///|
test "helmert7 scale" {
  let h = Helmert7::new(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0)
  let (x, y, z) = apply_helmert7(h, 1000.0, 0.0, 0.0)
  assert_true((x - 1000.01).abs() <= 0.0001)
  assert_true((y - 0.0).abs() <= 0.001)
  assert_true((z - 0.0).abs() <= 0.001)
}

///|
test "helmert7 rotation z" {
  let h = Helmert7::new(0.0, 0.0, 0.0, 0.0, 0.0, 1.5707963267948966, 0.0)
  let (x, y, z) = apply_helmert7(h, 100.0, 0.0, 0.0)
  assert_true((x - 0.0).abs() <= 0.1)
  assert_true((y - 100.0).abs() <= 0.1)
  assert_true((z - 0.0).abs() <= 0.001)
}

///|
test "helmert3 translation" {
  let h = Helmert3::new(5.0, 10.0, 15.0)
  let (x, y, z) = apply_helmert3(h, 100.0, 200.0, 300.0)
  assert_true((x - 105.0).abs() <= 0.001)
  assert_true((y - 210.0).abs() <= 0.001)
  assert_true((z - 315.0).abs() <= 0.001)
}

///|
test "helmert3 inverse" {
  let h = Helmert3::new(5.0, 10.0, 15.0)
  let inv = inverse_helmert3(h)
  let (x, y, z) = apply_helmert3(inv, 105.0, 210.0, 315.0)
  assert_true((x - 100.0).abs() <= 0.001)
  assert_true((y - 200.0).abs() <= 0.001)
  assert_true((z - 300.0).abs() <= 0.001)
}

///|
test "helmert7 inverse identity" {
  let h = helmert7_identity()
  let inv = inverse_helmert7(h)
  let (x, y, z) = apply_helmert7(inv, 100.0, 200.0, 300.0)
  assert_true((x - 100.0).abs() <= 0.001)
  assert_true((y - 200.0).abs() <= 0.001)
  assert_true((z - 300.0).abs() <= 0.001)
}

///|
test "helmert7 inverse translation" {
  let h = Helmert7::new(10.0, 20.0, 30.0, 0.0, 0.0, 0.0, 0.0)
  let inv = inverse_helmert7(h)
  let (x, y, z) = apply_helmert7(inv, 110.0, 220.0, 330.0)
  assert_true((x - 100.0).abs() <= 0.001)
  assert_true((y - 200.0).abs() <= 0.001)
  assert_true((z - 300.0).abs() <= 0.001)
}

///|
test "wgs84 cgcs2000 params near zero" {
  let h = wgs84_to_cgcs2000_params()
  let (x, y, z) = apply_helmert7(h, 6378137.0, 0.0, 0.0)
  assert_true((x - 6378137.0).abs() <= 0.001)
  assert_true((y - 0.0).abs() <= 0.001)
  assert_true((z - 0.0).abs() <= 0.001)
}

///|
test "compose helmert7 identity" {
  let id = helmert7_identity()
  let h = Helmert7::new(10.0, 20.0, 30.0, 0.0, 0.0, 0.0, 0.0)
  let comp = compose_helmert7(id, h)
  let (x, y, z) = apply_helmert7(comp, 0.0, 0.0, 0.0)
  assert_true((x - 10.0).abs() <= 0.001)
  assert_true((y - 20.0).abs() <= 0.001)
  assert_true((z - 30.0).abs() <= 0.001)
}
