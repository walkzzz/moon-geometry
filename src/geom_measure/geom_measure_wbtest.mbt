test "hausdorff measure 1d" {
  assert_eq(hausdorff_measure_1d(5.0), 5.0)
}

test "density 2d" {
  let d = density_2d(3.141592653589793, 1.0)
  assert_true(d > 0.99 && d < 1.01)
}

test "rectifiable length" {
  let l = rectifiable_length([(0.0, 3.0, 0.0, 4.0)])
  assert_eq(l, 5.0)
}
