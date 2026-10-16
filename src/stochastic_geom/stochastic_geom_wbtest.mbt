test "poisson point count" {
  assert_eq(poisson_point_count(2.0, 3.0), 6.0)
}

test "boolean model coverage" {
  let c = boolean_model_coverage(0.0, 1.0)
  assert_eq(c, 0.0)
}

test "voronoi cell expected area" {
  assert_eq(voronoi_cell_expected_area(5.0), 0.2)
}
