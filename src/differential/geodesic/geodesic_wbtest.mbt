test "haversine same point" {
  let d = haversine_distance(45.0, 90.0, 45.0, 90.0)
  assert_true(((d) - (0.0)).abs() <= (0.001))
}

test "haversine known distance" {
  let d = haversine_distance(0.0, 0.0, 0.0, 1.0)
  let expected = 6378137.0 * 0.017453292519943295
  assert_true(((d) - (expected)).abs() <= (1.0))
}

test "haversine quarter meridian" {
  let d = haversine_distance(0.0, 0.0, 90.0, 0.0)
  let expected = 6378137.0 * 1.5707963267948966
  assert_true(((d) - (expected)).abs() <= (1.0))
}

test "haversine symmetry" {
  let d1 = haversine_distance(45.0, 90.0, 30.0, 120.0)
  let d2 = haversine_distance(30.0, 120.0, 45.0, 90.0)
  assert_true(((d1) - (d2)).abs() <= (0.001))
}

test "spherical distance same point" {
  let d = spherical_distance(45.0, 90.0, 45.0, 90.0)
  assert_true(((d) - (0.0)).abs() <= (0.001))
}

test "spherical vs haversine agree" {
  let d1 = spherical_distance(40.0, -73.0, 51.0, -0.1)
  let d2 = haversine_distance(40.0, -73.0, 51.0, -0.1)
  assert_true(((d1) - (d2)).abs() <= (1.0))
}

test "initial bearing north" {
  let b = initial_bearing(0.0, 0.0, 10.0, 0.0)
  assert_true(((b) - (0.0)).abs() <= (0.001))
}

test "initial bearing east" {
  let b = initial_bearing(0.0, 0.0, 0.0, 10.0)
  assert_true(((b) - (90.0)).abs() <= (0.001))
}

test "initial bearing south" {
  let b = initial_bearing(10.0, 0.0, 0.0, 0.0)
  assert_true(((b) - (180.0)).abs() <= (0.001))
}

test "destination point north" {
  let (lat, lon) = destination_point(0.0, 0.0, 0.0, 1000000.0)
  assert_true(lat > 0.0)
  assert_true(((lon) - (0.0)).abs() <= (0.001))
}

test "destination point roundtrip" {
  let lat0 = 45.0
  let lon0 = 90.0
  let bearing = 135.0
  let dist = 500000.0
  let (lat1, lon1) = destination_point(lat0, lon0, bearing, dist)
  let back = haversine_distance(lat0, lon0, lat1, lon1)
  assert_true(((back) - (dist)).abs() <= (1.0))
}

test "vincenty same point" {
  let d = vincenty_distance(45.0, 90.0, 45.0, 90.0)
  assert_true(((d) - (0.0)).abs() <= (0.001))
}

test "vincenty known distance" {
  let d = vincenty_distance(0.0, 0.0, 0.0, 1.0)
  assert_true(d > 0.0 && d < 120000.0)
}

test "vincenty vs haversine close" {
  let dv = vincenty_distance(40.0, -73.0, 51.0, -0.1)
  let dh = haversine_distance(40.0, -73.0, 51.0, -0.1)
  let diff = (dv - dh).abs() / dh
  assert_true(diff < 0.01)
}

test "is antipodal false" {
  assert_true(!is_antipodal(45.0, 90.0, 46.0, 91.0))
}

test "is antipodal true" {
  assert_true(is_antipodal(45.0, 90.0, -45.0, -90.0))
}