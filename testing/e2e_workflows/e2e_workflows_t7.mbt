///| E2E: Polygon → Perimeter → Triangle inequality

///|
/// 端到端：多边形 → 周长 → 三角不等式
test "e2e: perimeter consistency" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 8.0),
    @core.Point2D::new(0.0, 8.0),
  ])
  let perim = @polygon.polygon_perimeter(poly)
  assert_true(approx_eq(perim, 28.0))
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 48.0))
}

///| E2E: Convex hull → Convexity invariant
