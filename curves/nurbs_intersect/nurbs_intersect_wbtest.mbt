///|
/// Bounding box of three control points.
/// 三个控制点的包围盒测试。
test "nurbs_bbox basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let (minx, miny, maxx, maxy) = nurbs_bbox(pts)
  assert_true((minx - 0.0).abs() < 0.0001)
  assert_true((miny - 0.0).abs() < 0.0001)
  assert_true((maxx - 4.0).abs() < 0.0001)
  assert_true((maxy - 4.0).abs() < 0.0001)
}

///|
/// A horizontal line crossing a quadratic B-spline arch.
/// 水平线穿过二次 B 样条拱形。
test "nurbs_line_intersect basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let knots = [0.0, 0.0, 0.0, 1.0, 1.0, 1.0]
  let line_start = @core.Point2D::new(-1.0, 1.0)
  let line_end = @core.Point2D::new(3.0, 1.0)
  let result = nurbs_line_intersect(pts, knots, 2, line_start, line_end)
  assert_true(result.length() >= 1)
}

///|
/// Subdividing a quadratic curve yields two curves sharing the split point.
/// 细分二次曲线得到两段曲线，共享分割点。
test "nurbs_subdivide basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let knots = [0.0, 0.0, 0.0, 1.0, 1.0, 1.0]
  let (left_pts, _, right_pts, _) = nurbs_subdivide(pts, knots, 2, 0.5)
  assert_eq(left_pts.length(), 3)
  assert_eq(right_pts.length(), 3)
  assert_true(left_pts[2].approx_eq(right_pts[0], 0.0001))
}
