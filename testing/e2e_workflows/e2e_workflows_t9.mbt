///|
/// 端到端：距离矩阵 → 对称性检查
test "e2e: distance matrix symmetry" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(6.0, 8.0),
    @core.Point2D::new(-2.0, 5.0),
  ]
  for i in 0..<pts.length() {
    for j in 0..<pts.length() {
      let d_ij = pts[i].dist(pts[j])
      let d_ji = pts[j].dist(pts[i])
      assert_true(approx_eq(d_ij, d_ji))
    }
  }
}
