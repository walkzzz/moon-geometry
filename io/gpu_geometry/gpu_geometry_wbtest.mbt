///|
test "morton_code_2d" {
  let m = morton_code_2d(1, 0)
  assert_eq(m, 1)
}

///|
test "morton_code_2d both" {
  let m = morton_code_2d(1, 1)
  assert_eq(m, 3)
}

///|
test "meshlet_bounds" {
  let (center, r) = meshlet_bounds([(0.0, 0.0, 0.0), (2.0, 0.0, 0.0)])
  assert_true(center.0 > 0.99 && center.0 < 1.01)
  assert_true(r > 0.99 && r < 1.01)
}

///|
test "morton_code_2d larger" {
  let m = morton_code_2d(2, 0)
  assert_eq(m, 4)
  let m2 = morton_code_2d(0, 2)
  assert_eq(m2, 8)
}

///|
test "hilbert_d2xy d2" {
  assert_eq(hilbert_d2xy(2, 0), (0, 0))
  assert_eq(hilbert_d2xy(2, 1), (0, 2))
  assert_eq(hilbert_d2xy(2, 2), (2, 2))
  assert_eq(hilbert_d2xy(2, 3), (3, 1))
}

///|
test "hilbert_d2xy d4" {
  assert_eq(hilbert_d2xy(4, 0), (0, 0))
  assert_eq(hilbert_d2xy(4, 5), (6, 0))
}

///|
test "vertex_cache_optimize" {
  let indices = [0, 1, 2, 1, 2, 3]
  let result = vertex_cache_optimize(indices, 16)
  assert_eq(result.length(), 6)
  assert_eq(result[0], 0)
}

///|
test "meshlet_bounds empty" {
  let (center, r) = meshlet_bounds([])
  assert_true((center.0 - 0.0).abs() < 0.0001)
  assert_true((r - 0.0).abs() < 0.0001)
}

///|
test "meshlet_bounds single" {
  let (center, r) = meshlet_bounds([(1.0, 2.0, 3.0)])
  assert_true((center.0 - 1.0).abs() < 0.0001)
  assert_true((center.1 - 2.0).abs() < 0.0001)
  assert_true((center.2 - 3.0).abs() < 0.0001)
  assert_true((r - 0.0).abs() < 0.0001)
}
