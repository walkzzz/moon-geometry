test "kmeans_assign" {
  let c = kmeans_assign((0.0, 0.0), [(0.0, 0.0), (10.0, 10.0)])
  assert_eq(c, 0)
}
test "dbscan_eps_neighbors" {
  let n = dbscan_eps_neighbors([(0.0, 0.0), (0.5, 0.0), (10.0, 10.0)], 0, 1.0)
  assert_eq(n.length(), 1)
}
test "silhouette_score" {
  let s = silhouette_score(1.0, 2.0)
  assert_true(s > 0.49 && s < 0.51)
}
