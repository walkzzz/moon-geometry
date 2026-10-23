///| E2E: Polygon → Transform → Inverse → Restore

///|
/// 端到端：多边形 → 变换 → 逆变换 → 恢复
test "e2e: transform inverse pipeline" {
  let original = @core.Polygon::new([
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
    @core.Point2D::new(5.0, 6.0),
    @core.Point2D::new(1.0, 6.0),
  ])
  let dx = 10.0
  let dy = 20.0
  let angle = 0.7853981633974483
  let transformed_verts = @core.map_points(original.vertices, fn(v) {
    @transform.rotate(@transform.translate(v, dx, dy), angle)
  })
  let transformed = @core.Polygon::new(transformed_verts)
  let restored_verts = @core.map_points(transformed.vertices, fn(v) {
    @transform.translate(@transform.rotate(v, -angle), -dx, -dy)
  })
  let restored = @core.Polygon::new(restored_verts)
  for i in 0..<original.size() {
    assert_true(
      @core.approx_eq(
        original.vertices[i].x(),
        restored.vertices[i].x(),
        1.0e-8,
      ),
    )
    assert_true(
      @core.approx_eq(
        original.vertices[i].y(),
        restored.vertices[i].y(),
        1.0e-8,
      ),
    )
  }
}
