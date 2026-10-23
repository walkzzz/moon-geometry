///|
/// Hull of convex polygon is itself | 凸多边形的凸包为自身
test "extreme: hull of convex polygon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_eq(hull.length(), 4)
}

///|
/// Graham and Andrew hull agree on size | Graham 和 Andrew 凸包大小一致
test "extreme: graham andrew agreement" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let hull_a = @hull.convex_hull_andrew(pts)
  let hull_g = @hull.convex_hull_graham(pts)
  assert_eq(hull_a.length(), hull_g.length())
}
