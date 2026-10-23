///| E2E: Point set → Both hull algorithms → Compare

///| 端到端：点集 → 两种凸包算法 → 比较
test "e2e: hull algorithm comparison" {
  let pts = [
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(5.0, 1.0),
    @core.Point2D::new(8.0, 4.0),
    @core.Point2D::new(6.0, 7.0),
    @core.Point2D::new(3.0, 8.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(4.0, 5.0),
  ]
  let hull_a = @hull.convex_hull_andrew(pts)
  let hull_g = @hull.convex_hull_graham(pts)
  let poly_a = @core.Polygon::new(hull_a)
  let poly_g = @core.Polygon::new(hull_g)
  let area_a = @polygon.polygon_area(poly_a)
  let area_g = @polygon.polygon_area(poly_g)
  assert_eq(hull_a.length(), hull_g.length())
  assert_true(@core.approx_eq(area_a, area_g, 1.0e-8))
}


///| E2E: Square → Scale → Area check