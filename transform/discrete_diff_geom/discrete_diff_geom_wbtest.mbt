///|
test "discrete connection" {
  let r = discrete_connection([1.0, 2.0, 3.0])
  assert_eq(r, 6.0)
}

///|
test "parallel transport" {
  let (x, y) = parallel_transport(1.0, 0.0, 1.5707963267948966)
  assert_true(x.abs() < 0.0001)
  assert_true(y > 0.99)
}

///|
test "discrete curvature" {
  let k = discrete_curvature2d([1.0, 1.0, 1.0])
  let expected = 2.0 * @math.PI - 3.0
  assert_true((k - expected).abs() < 1.0e-10)
}
///|
test "holonomy" {
  let h = holonomy([1.0, 2.0, 3.0])
  assert_true((h - 6.0).abs() < 0.001)
}

///|
test "holonomy wrap" {
  let h = holonomy([@math.PI, @math.PI, @math.PI])
  assert_true((h - @math.PI).abs() < 0.001)
}

///|
test "gauss map normals" {
  let result = gauss_map_normals([0.5, 0.3, 0.2])
  assert_eq(result.length(), 3)
  assert_true((result[0] - 0.5).abs() < 0.0001)
  assert_true((result[1] - 0.8).abs() < 0.0001)
  assert_true((result[2] - 1.0).abs() < 0.0001)
}

///|
test "discrete connection empty" {
  let r = discrete_connection([])
  assert_true(r.abs() < 0.0001)
}
