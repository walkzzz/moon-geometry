test "euclidean_fallback" {
  let a = @core.Point3D::new(0.0, 0.0, 0.0)
  let b = @core.Point3D::new(3.0, 4.0, 0.0)
  assert_true((euclidean_fallback(a, b) - 5.0).abs() < 0.001)
}

test "dijkstra_geodesic" {
  let adj = [(0, 1, 1.0), (1, 2, 2.0), (0, 2, 4.0)]
  let d = dijkstra_geodesic(3, adj, 0, 2)
  assert_true((d - 3.0).abs() < 0.001)
}
