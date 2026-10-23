///| 端到端：凸包 → 凸性不变量
test "e2e: hull convexity invariant" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 2.0),
    @core.Point2D::new(3.0, 8.0),
    @core.Point2D::new(1.0, 4.0),
    @core.Point2D::new(7.0, 5.0),
    @core.Point2D::new(4.0, 1.0),
    @core.Point2D::new(2.0, 6.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  let hull_poly = @core.Polygon::new(hull)
  assert_true(@polygon.is_convex(hull_poly))
  let hull_g = @hull.convex_hull_graham(pts)
  let hull_g_poly = @core.Polygon::new(hull_g)
  assert_true(@polygon.is_convex(hull_g_poly))
}


///| E2E: Distance matrix → Symmetry check