///| Empty polygon area is 0 | 空多边形面积为0
test "boundary: empty polygon area" {
  let poly = @core.Polygon::new([])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}


///| Single point polygon area is 0 | 单点多边形面积为0
test "boundary: single point polygon" {
  let poly = @core.Polygon::new([@core.Point2D::new(5.0, 3.0)])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}


///| Two point polygon (degenerate) area is 0 | 两点多边形面积为0
test "boundary: two point polygon" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}


///| Collinear points polygon area is 0 | 共线点多边形面积为0
test "boundary: collinear points area" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}


///| Convex hull of single point | 单点凸包
test "boundary: hull of single point" {
  let pts = [@core.Point2D::new(3.0, 7.0)]
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 1)
}


///| Convex hull of two points | 两点凸包
test "boundary: hull of two points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 2)
}


///| Convex hull of identical points | 相同点凸包
test "boundary: hull of identical points" {
  let pts = [
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 1)
}

// ============================================================
// 2. Numerical Stability Tests | 数值稳定性测试
// ============================================================
