///|
test "mercator forward origin" {
  let p = mercator_forward(0.0, 0.0)
  assert_true((p.x - 0.0).abs() <= 0.001)
  assert_true((p.y - 0.0).abs() <= 0.001)
}

///|
test "mercator forward equator" {
  let p = mercator_forward(0.0, 90.0)
  let expected = 6378137.0 * 1.5707963267948966
  assert_true((p.x - expected).abs() <= 0.001)
  assert_true((p.y - 0.0).abs() <= 0.001)
}

///|
test "mercator inverse roundtrip" {
  let lat0 = 45.0
  let lon0 = 120.0
  let p = mercator_forward(lat0, lon0)
  let (lat1, lon1) = mercator_inverse(p.x, p.y)
  assert_true((lat1 - lat0).abs() <= 0.0000001)
  assert_true((lon1 - lon0).abs() <= 0.0000001)
}

///|
test "mercator inverse origin" {
  let (lat, lon) = mercator_inverse(0.0, 0.0)
  assert_true((lat - 0.0).abs() <= 0.0000001)
  assert_true((lon - 0.0).abs() <= 0.0000001)
}

///|
test "web mercator forward inverse" {
  let p = web_mercator_forward(30.0, 60.0)
  let (lat, lon) = web_mercator_inverse(p.x, p.y)
  assert_true((lat - 30.0).abs() <= 0.0000001)
  assert_true((lon - 60.0).abs() <= 0.0000001)
}

///|
test "utm zone from longitude" {
  assert_eq(utm_zone_from_lon(0.0), 31)
  assert_eq(utm_zone_from_lon(-180.0), 1)
  assert_eq(utm_zone_from_lon(180.0), 60)
  assert_eq(utm_zone_from_lon(116.0), 50)
}

///|
test "utm central meridian" {
  assert_true((utm_central_meridian(31) - 3.0).abs() <= 0.0000001)
  assert_true((utm_central_meridian(1) - -177.0).abs() <= 0.0000001)
  assert_true((utm_central_meridian(50) - 117.0).abs() <= 0.0000001)
}

///|
test "utm forward equator" {
  let p = utm_forward_zone(0.0, 117.0, 50)
  assert_true((p.x - 500000.0).abs() <= 0.001)
  assert_true((p.y - 0.0).abs() <= 0.001)
}

///|
test "utm forward southern hemisphere" {
  let p = utm_forward_zone(-10.0, 117.0, 50)
  assert_true(p.y > 8000000.0)
  assert_true(p.y < 10000000.0)
}

///|
test "lambert conformal forward" {
  let p = lambert_conformal_forward(40.0, 100.0, 33.0, 45.0, 39.0, 96.0)
  assert_true(p.x.is_nan() == false)
  assert_true(p.y.is_nan() == false)
}

///|
test "lambert conformal at origin" {
  let p = lambert_conformal_forward(39.0, 96.0, 33.0, 45.0, 39.0, 96.0)
  assert_true((p.x - 0.0).abs() <= 0.001)
  assert_true((p.y - 0.0).abs() <= 0.001)
}

///|
test "albers equal area forward" {
  let p = albers_equal_area_forward(40.0, 100.0, 29.5, 45.5, 37.5, 96.0)
  assert_true(p.x.is_nan() == false)
  assert_true(p.y.is_nan() == false)
}

///|
test "albers equal area at origin" {
  let p = albers_equal_area_forward(37.5, 96.0, 29.5, 45.5, 37.5, 96.0)
  assert_true((p.x - 0.0).abs() <= 0.001)
  assert_true((p.y - 0.0).abs() <= 0.001)
}

///|
test "mercator scale at equator" {
  assert_true((mercator_scale(0.0) - 1.0).abs() <= 0.0000001)
}

///|
test "mercator scale at 60 degrees" {
  let s = mercator_scale(60.0)
  assert_true((s - 2.0).abs() <= 0.0000001)
}
