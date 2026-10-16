test "segment_by_height" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.1), @core.Point3D::new(1.0, 0.0, 0.2), @core.Point3D::new(0.0, 1.0, 2.0)]
  let (g, ng) = segment_by_height(pts, 1.0)
  assert_eq(g.length(), 2)
  assert_eq(ng.length(), 1)
}

test "segment_count" {
  let clusters = [[0, 1], [2, 3, 4], [5]]
  assert_eq(segment_count(clusters), 3)
}
