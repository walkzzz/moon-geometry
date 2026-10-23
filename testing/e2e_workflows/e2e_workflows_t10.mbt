///| E2E: Transform chain → Identity recovery

///|
/// 端到端：变换链 → 恒等恢复
test "e2e: transform chain identity" {
  let p = @core.Point2D::new(7.0, 3.0)
  let p1 = @transform.translate(p, 10.0, 20.0)
  let p2 = @transform.rotate(p1, 1.5707963267948966)
  let p3 = @transform.scale(p2, 2.0, 2.0)
  let p4 = @transform.scale(p3, 0.5, 0.5)
  let p5 = @transform.rotate(p4, -1.5707963267948966)
  let p6 = @transform.translate(p5, -10.0, -20.0)
  assert_true(@core.approx_eq(p.x(), p6.x(), 1.0e-8))
  assert_true(@core.approx_eq(p.y(), p6.y(), 1.0e-8))
}
