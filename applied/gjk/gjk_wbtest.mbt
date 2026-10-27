///|
test "gjk_collide_polygons overlapping" {
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
  let result = gjk_collide_polygons(poly1, poly2)
  assert_true(result.collides)
}

///|
test "gjk_collide_polygons disjoint" {
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
  let result = gjk_collide_polygons(poly1, poly2)
  assert_false(result.collides)
}

///|
test "gjk_collide_circles overlapping" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(1.0, 0.0)
  let result = gjk_collide_circles(c1, 1.0, c2, 1.0)
  assert_true(result.collides)
}

///|
test "gjk_collide_circles disjoint" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(5.0, 0.0)
  let result = gjk_collide_circles(c1, 1.0, c2, 1.0)
  assert_false(result.collides)
}

///|
test "gjk_collide_polygon_circle overlapping" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(3.0, 3.0)
  let result = gjk_collide_polygon_circle(poly, center, 2.0)
  assert_true(result.collides)
}

///|
test "gjk_collide_polygon_circle disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let center = @core.Point2D::new(10.0, 10.0)
  let result = gjk_collide_polygon_circle(poly, center, 1.0)
  assert_false(result.collides)
}

///|
test "gjk_point_in_polygon inside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let p = @core.Point2D::new(2.0, 2.0)
  let result = gjk_point_in_polygon(p, poly)
  assert_true(result.collides)
}

///|
test "gjk_point_in_polygon outside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let p = @core.Point2D::new(5.0, 5.0)
  let result = gjk_point_in_polygon(p, poly)
  assert_false(result.collides)
}

///|
test "gjk_collide_polygons touching" {
  let poly1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let poly2 = [
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let result = gjk_collide_polygons(poly1, poly2)
  assert_true(result.collides)
}

///|
test "gjk_collide_circles same center" {
  let c = @core.Point2D::new(0.0, 0.0)
  let result = gjk_collide_circles(c, 1.0, c, 1.0)
  assert_true(result.collides)
}

///|
test "polygon_support basic" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let s = polygon_support(poly, 1.0, 0.0)
  assert_true((s.x() - 4.0).abs() < 0.001)
}

///|
/// 触发 circle_support 零方向分支（行 55）。
/// len < 1e-12，返回 center。
test "circle_support zero direction" {
  let c = @core.Point2D::new(3.0, 4.0)
  let s = circle_support(c, 2.0, 0.0, 0.0)
  assert_true((s.x() - 3.0).abs() < 0.001)
  assert_true((s.y() - 4.0).abs() < 0.001)
}

///|
/// 触发 gjk_collide 达到 max_iterations 返回 false（行 111）。
/// 相切圆（距离 = r1 + r2），1 次迭代无法判定，循环结束返回 false。
test "gjk_collide tangent circles max iter 1" {
  let sa = fn(dx, dy) {
    circle_support(@core.Point2D::new(0.0, 0.0), 1.0, dx, dy)
  }
  let sb = fn(dx, dy) {
    circle_support(@core.Point2D::new(2.0, 0.0), 1.0, dx, dy)
  }
  let result = gjk_collide(sa, sb, 1)
  assert_false(result.collides)
  assert_eq(result.iterations, 1)
}

///|
/// 触发 gjk_simplex_update 2-simplex dot <= 0 分支（行 129）。
/// simplex = [b, a]，ab·ao <= 0，移除 b，返回 ao。
test "gjk_simplex_update 2-simplex dot le zero" {
  let simplex : Array[@core.Point2D] = [
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let (contains, d) = gjk_simplex_update(simplex)
  assert_false(contains)
  // ao = -a = (-1, 0)
  assert_true((d.x() + 1.0).abs() < 0.001)
  assert_true(d.y().abs() < 0.001)
}

///|
/// 触发 gjk_simplex_update 3-simplex ab_dot > 0 分支（行 144）。
/// 原点在 ab 边远离 c 的一侧，移除 c，返回 ab_perp。
test "gjk_simplex_update 3-simplex ab dot positive" {
  // c=(2,3), b=(3,1), a=(1,1) => ab_perp·ao > 0
  let simplex : Array[@core.Point2D] = [
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let (contains, d) = gjk_simplex_update(simplex)
  assert_false(contains)
  // ab_perp = (0, -8)
  assert_true(d.x().abs() < 0.001)
  assert_true((d.y() + 8.0).abs() < 0.001)
}

///|
/// 触发 gjk_simplex_update 3-simplex ac_dot > 0 分支（行 148）。
/// ab_dot <= 0 且 ac_dot > 0，移除 b，返回 ac_perp。
test "gjk_simplex_update 3-simplex ac dot positive" {
  // c=(1,-1), b=(2,0), a=(1,1) => ab_dot <= 0, ac_dot > 0
  let simplex : Array[@core.Point2D] = [
    @core.Point2D::new(1.0, -1.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let (contains, d) = gjk_simplex_update(simplex)
  assert_false(contains)
  // ac_perp = (-4, 0)
  assert_true((d.x() + 4.0).abs() < 0.001)
  assert_true(d.y().abs() < 0.001)
}

///|
/// 触发 gjk_simplex_update 3-simplex contains 分支（行 151）。
/// 原点在三角形内，返回 (true, (0,0))。
test "gjk_simplex_update 3-simplex contains origin" {
  // a=(1,0), b=(0,1), c=(0,-1)，原点在三角形内
  let simplex : Array[@core.Point2D] = [
    @core.Point2D::new(0.0, -1.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let (contains, _) = gjk_simplex_update(simplex)
  assert_true(contains)
}

///|
/// 触发 gjk_simplex_update 默认分支（行 155）。
/// simplex 长度为 1，返回 (false, -last)。
test "gjk_simplex_update 1-simplex default branch" {
  let simplex : Array[@core.Point2D] = [@core.Point2D::new(3.0, 4.0)]
  let (contains, d) = gjk_simplex_update(simplex)
  assert_false(contains)
  assert_true((d.x() + 3.0).abs() < 0.001)
  assert_true((d.y() + 4.0).abs() < 0.001)
}

///|
/// 触发 triple_product 直接验证。
test "triple_product basic" {
  let a = @core.Point2D::new(1.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  let c = @core.Point2D::new(1.0, 1.0)
  let r = triple_product(a, b, c)
  // ac = 1*1+0*1 = 1, bc = 0*1+1*1 = 1
  // result = (b.x*ac - a.x*bc, b.y*ac - a.y*bc) = (0*1-1*1, 1*1-0*1) = (-1, 1)
  assert_true((r.x() + 1.0).abs() < 0.001)
  assert_true((r.y() - 1.0).abs() < 0.001)
}

///|
/// 触发 polygon_support 负方向与多顶点比较。
test "polygon_support negative direction" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let s = polygon_support(poly, -1.0, -1.0)
  assert_true((s.x() - 0.0).abs() < 0.001)
  assert_true((s.y() - 0.0).abs() < 0.001)
}

///|
/// 触发 minkowski_support 验证。
test "minkowski_support basic" {
  let sa = fn(dx, dy) { @core.Point2D::new(dx * 2.0, dy * 2.0) }
  let sb = fn(dx, dy) { @core.Point2D::new(dx, dy) }
  let r = minkowski_support(sa, sb, 1.0, 0.0)
  // sa(1,0)=(2,0), sb(-1,0)=(-1,0), result = (2-(-1), 0-0) = (3, 0)
  assert_true((r.x() - 3.0).abs() < 0.001)
  assert_true(r.y().abs() < 0.001)
}

///|
/// GJKResult 访问器验证。
test "gjk result accessors" {
  let r = GJKResult::new(true, 5)
  assert_true(r.collides)
  assert_eq(r.iterations, 5)
}
