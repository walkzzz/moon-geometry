test "isomap_dist self" {
  let dists = [[0.0, 1.0], [1.0, 0.0]]
  let d = isomap_dist(dists, 0, 0)
  assert_true(d.abs() < 0.0001)
}
test "laplacian_weight self" {
  let w = laplacian_weight((0.0, 0.0), (0.0, 0.0), 1.0)
  assert_true(w > 0.99 && w < 1.01)
}
test "lle_weight sum" {
  let w = lle_weight([(0.0, 0.0), (1.0, 0.0)], (0.5, 0.0))
  let mut s = 0.0
  for i in 0..<w.length() { s += w[i] }
  assert_true(s > 0.99 && s < 1.01)
}
