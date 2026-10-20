test "greedy_triangulation" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(1.0, 0.0, 0.0), @core.Point3D::new(0.0, 1.0, 0.0)]
  let tris = greedy_triangulation(pts, 2.0)
  assert_true(tris.length() >= 1)
}

test "estimate_tangent_plane" {
  let c = @core.Point3D::new(0.0, 0.0, 0.0)
  let nb = [@core.Point3D::new(1.0, 0.0, 0.0), @core.Point3D::new(0.0, 1.0, 0.0)]
  let n = estimate_tangent_plane(c, nb)
  assert_true((n.x - 0.5).abs() < 0.001)
  assert_true((n.y - 0.5).abs() < 0.001)
}

test "recon_triangle_count" {
  let tris = [(0, 1, 2), (1, 2, 3)]
  assert_eq(recon_triangle_count(tris), 2)
}

test "recon_completeness" {
  let r = recon_completeness(8, 10)
  assert_true((r - 0.8).abs() < 0.001)
}
