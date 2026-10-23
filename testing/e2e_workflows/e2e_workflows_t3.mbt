///| 端到端：点集 → 凸包 → 面积 → 包含检查
test "e2e: convex hull pipeline" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(7.0, 3.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  let hull_poly = @core.Polygon::new(hull)
  let area = @polygon.polygon_area(hull_poly)
  assert_true(area > 99.0 && area < 101.0)
  assert_true(@polygon.is_convex(hull_poly))
  let interior_pts = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(7.0, 3.0),
  ]
  for p in interior_pts {
    assert_true(@polygon.point_in_polygon(p, hull_poly))
  }
}
