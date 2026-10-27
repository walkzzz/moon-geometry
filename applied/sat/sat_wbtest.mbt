///|
test "sat_collide_polygons overlapping" {
  let poly1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let poly2 = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ]
  let result = sat_collide_polygons(poly1, poly2)
  assert_true(result.collides)
  assert_true(result.overlap > 0.0)
}

///|
test "sat_collide_polygons disjoint" {
  let poly1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let poly2 = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(6.0, 5.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(5.0, 6.0),
  ]
  let result = sat_collide_polygons(poly1, poly2)
  assert_false(result.collides)
}

///|
test "sat_collide_polygons identical" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let result = sat_collide_polygons(poly, poly)
  assert_true(result.collides)
}

///|
test "sat_contains_point inside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(sat_contains_point(poly, @core.Point2D::new(2.0, 2.0)))
}

///|
test "sat_contains_point outside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  assert_false(sat_contains_point(poly, @core.Point2D::new(5.0, 5.0)))
}

///|
test "sat_collide_circles overlapping" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(1.0, 0.0)
  let result = sat_collide_circles(c1, 1.0, c2, 1.0)
  assert_true(result.collides)
  assert_true(result.overlap > 0.0)
}

///|
test "sat_collide_circles disjoint" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(5.0, 0.0)
  let result = sat_collide_circles(c1, 1.0, c2, 1.0)
  assert_false(result.collides)
}

///|
test "sat_collide_polygon_circle overlapping" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(3.0, 3.0)
  let result = sat_collide_polygon_circle(poly, center, 2.0)
  assert_true(result.collides)
}

///|
test "sat_collide_polygon_circle disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let center = @core.Point2D::new(10.0, 10.0)
  let result = sat_collide_polygon_circle(poly, center, 1.0)
  assert_false(result.collides)
}

///|
test "sat_mtv basic" {
  let result = SATResult::new(true, 2.0, 1.0, 0.0)
  let mtv = sat_mtv(result)
  assert_true((mtv.x() - 2.0).abs() < 0.001)
}

///|
test "sat_separating_axis basic" {
  let result = SATResult::new(false, 0.0, 0.6, 0.8)
  let axis = sat_separating_axis(result)
  assert_true((axis.x() - 0.6).abs() < 0.001)
  assert_true((axis.y() - 0.8).abs() < 0.001)
}

///|
test "sat_collide_polygons axes2 separating" {
  // 覆盖 L65: poly1 的边轴都不分离, poly2 的边轴(x 轴)分离 => 在 axes2 循环返回 false
  // poly1 菱形(45° 边法向), poly2 轴对齐正方形在右侧 => poly1 边法向投影重叠, poly2 x 轴分离
  let poly1 = [
    @core.Point2D::new(0.0, -2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
  ]
  let poly2 = [
    @core.Point2D::new(2.5, -1.0),
    @core.Point2D::new(3.5, -1.0),
    @core.Point2D::new(3.5, 1.0),
    @core.Point2D::new(2.5, 1.0),
  ]
  let result = sat_collide_polygons(poly1, poly2)
  assert_false(result.collides)
}

///|
test "sat_collide_polygons axes2 updates min_overlap" {
  // 覆盖 L68: axes2 循环中 overlap>0 且 overlap<min_overlap 时更新
  // poly1 菱形(45° 边法向), poly2 轴对齐正方形部分嵌入 =>
  //   axes1(45°) 穿透≈1.061, axes2(x 轴) 穿透=1.0 < 1.061 => 触发更新
  let poly1 = [
    @core.Point2D::new(0.0, -2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
  ]
  let poly2 = [
    @core.Point2D::new(1.0, -0.5),
    @core.Point2D::new(2.0, -0.5),
    @core.Point2D::new(2.0, 0.5),
    @core.Point2D::new(1.0, 0.5),
  ]
  let result = sat_collide_polygons(poly1, poly2)
  assert_true(result.collides)
  assert_true(result.overlap > 0.0)
}

///|
test "sat_collide_circles coincident centers" {
  // 覆盖 L165,166 的 else 分支: dist<=eps (圆心重合) 且碰撞 => ax=1.0, ay=0.0
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(0.0, 0.0)
  let result = sat_collide_circles(c1, 1.0, c2, 1.0)
  assert_true(result.collides)
  assert_true((result.axis_x - 1.0).abs() < 0.001)
  assert_true((result.axis_y - 0.0).abs() < 0.001)
}

///|
test "sat_collide_polygon_circle vertex axis separates" {
  // 覆盖 L213 (顶点轴分离返回 false) 与 L216 (顶点轴 overlap<min_overlap 更新)
  // 菱形 + 圆在右侧: 边轴(45°)都重叠, 顶点(2,0)方向的轴分离
  let poly = [
    @core.Point2D::new(0.0, -2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
  ]
  let center = @core.Point2D::new(2.5, 0.0)
  let result = sat_collide_polygon_circle(poly, center, 0.4)
  assert_false(result.collides)
}

///|
test "sat_collide_polygon_circle center at vertex" {
  // 覆盖 L203: 圆心与多边形顶点重合 => dist<eps 的 continue
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(0.0, 0.0)
  let result = sat_collide_polygon_circle(poly, center, 0.5)
  assert_true(result.collides)
}
