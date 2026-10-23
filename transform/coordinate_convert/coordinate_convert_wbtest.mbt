///|
test "wgs84 to ecef origin" {
  let g = Geodetic::new(0.0, 0.0, 0.0)
  let e = wgs84_to_ecef(g)
  assert_true((e.x - 6378137.0).abs() <= 0.001)
  assert_true((e.y - 0.0).abs() <= 0.001)
  assert_true((e.z - 0.0).abs() <= 0.001)
}

///|
test "wgs84 to ecef north pole" {
  let g = Geodetic::new(90.0, 0.0, 0.0)
  let e = wgs84_to_ecef(g)
  assert_true((e.x - 0.0).abs() <= 0.001)
  assert_true((e.y - 0.0).abs() <= 0.001)
  assert_true(e.z > 6350000.0)
}

///|
test "ecef to wgs84 roundtrip" {
  let g = Geodetic::new(45.0, 90.0, 100.0)
  let e = wgs84_to_ecef(g)
  let g2 = ecef_to_wgs84(e)
  assert_true((g2.lat - 45.0).abs() <= 0.0000001)
  assert_true((g2.lon - 90.0).abs() <= 0.0000001)
  assert_true((g2.h - 100.0).abs() <= 0.001)
}

///|
test "ecef to wgs84 origin" {
  let e = ECEF::new(6378137.0, 0.0, 0.0)
  let g = ecef_to_wgs84(e)
  assert_true((g.lat - 0.0).abs() <= 0.0000001)
  assert_true((g.lon - 0.0).abs() <= 0.0000001)
  assert_true((g.h - 0.0).abs() <= 0.001)
}

///|
test "cgcs2000 to ecef origin" {
  let g = Geodetic::new(0.0, 0.0, 0.0)
  let e = cgcs2000_to_ecef(g)
  assert_true((e.x - 6378137.0).abs() <= 0.001)
  assert_true((e.y - 0.0).abs() <= 0.001)
  assert_true((e.z - 0.0).abs() <= 0.001)
}

///|
test "cgcs2000 roundtrip" {
  let g = Geodetic::new(30.0, 120.0, 50.0)
  let e = cgcs2000_to_ecef(g)
  let g2 = ecef_to_cgcs2000(e)
  assert_true((g2.lat - 30.0).abs() <= 0.0000001)
  assert_true((g2.lon - 120.0).abs() <= 0.0000001)
  assert_true((g2.h - 50.0).abs() <= 0.001)
}

///|
test "wgs84 to cgcs2000 roundtrip" {
  let g = Geodetic::new(40.0, 116.0, 30.0)
  let g2 = wgs84_to_cgcs2000(g)
  let g3 = cgcs2000_to_wgs84(g2)
  assert_true((g3.lat - 40.0).abs() <= 0.0000001)
  assert_true((g3.lon - 116.0).abs() <= 0.0000001)
  assert_true((g3.h - 30.0).abs() <= 0.001)
}

///|
test "wgs84 cgcs2000 nearly identical" {
  let g = Geodetic::new(40.0, 116.0, 0.0)
  let g2 = wgs84_to_cgcs2000(g)
  assert_true((g2.lat - g.lat).abs() < 0.001)
  assert_true((g2.lon - g.lon).abs() < 0.001)
}

///|
test "ecef distance same point" {
  let e = ECEF::new(6378137.0, 0.0, 0.0)
  assert_true((ecef_distance(e, e) - 0.0).abs() <= 0.001)
}

///|
test "ecef distance basic" {
  let e1 = ECEF::new(6378137.0, 0.0, 0.0)
  let e2 = ECEF::new(0.0, 6378137.0, 0.0)
  let d = ecef_distance(e1, e2)
  let expected = 6378137.0 * 1.4142135623730951
  assert_true((d - expected).abs() <= 0.001)
}
