test "project_onto_line" {
  let p = project_onto_line((1.0, 0.0), (1.0, 0.0))
  assert_true(p > 0.99 && p < 1.01)
}
test "pca_1d_variance" {
  let v = pca_1d_variance([1.0, 2.0, 3.0])
  assert_true(v > 0.0)
}
test "explained_variance_ratio" {
  let r = explained_variance_ratio([3.0, 1.0], 1)
  assert_true(r > 0.74 && r < 0.76)
}
