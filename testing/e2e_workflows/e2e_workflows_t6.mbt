///|
/// 端到端：正方形 → 缩放 → 面积检查
test "e2e: scale area pipeline" {
  let side = 4.0
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(side, 0.0),
    @core.Point2D::new(side, side),
    @core.Point2D::new(0.0, side),
  ])
  let original_area = @polygon.polygon_area(poly)
  let scale_factor = 2.5
  let scaled_verts = @core.map_points(poly.vertices, fn(v) {
    @transform.scale(v, scale_factor, scale_factor)
  })
  let scaled_poly = @core.Polygon::new(scaled_verts)
  let scaled_area = @polygon.polygon_area(scaled_poly)
  assert_true(
    approx_eq(scaled_area, original_area * scale_factor * scale_factor),
  )
}

///| E2E: Multiple transforms → Composition

///|
/// 端到端：多重变换 → 合成
test "e2e: transform composition" {
  let p = @core.Point2D::new(3.0, 4.0)
  let dx = 5.0
  let dy = 7.0
  let angle = 0.5235987755982989
  let p_t = @transform.translate(p, dx, dy)
  let p_tr = @transform.rotate(p_t, angle)
  let p_r = @transform.rotate(p, angle)
  let p_rt = @transform.translate(p_r, dx, dy)
  assert_true(!approx_eq(p_tr.x(), p_rt.x()))
}
