test "robust_circumcenter" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 0.0)
  let c = @core.Point2D::new(1.0, 1.0)
  let center = robust_circumcenter(a, b, c)
  assert_true((center.x() - 1.0).abs() < 0.001)
}

test "robust_intersection" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 2.0)
  let c = @core.Point2D::new(0.0, 2.0)
  let d = @core.Point2D::new(2.0, 0.0)
  let p = robust_intersection(a, b, c, d)
  assert_true((p.x() - 1.0).abs() < 0.001)
  assert_true((p.y() - 1.0).abs() < 0.001)
}

test "robust_midpoint" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 4.0)
  let m = robust_midpoint(a, b)
  assert_true((m.x() - 1.0).abs() < 0.001)
  assert_true((m.y() - 2.0).abs() < 0.001)
}
