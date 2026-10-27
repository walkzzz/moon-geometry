///|
test "aabb_overlap basic" {
  let a = AABB::new(0.0, 0.0, 2.0, 2.0)
  let b = AABB::new(1.0, 1.0, 3.0, 3.0)
  assert_true(aabb_overlap(a, b))
}

///|
test "aabb_overlap disjoint" {
  let a = AABB::new(0.0, 0.0, 1.0, 1.0)
  let b = AABB::new(2.0, 2.0, 3.0, 3.0)
  assert_false(aabb_overlap(a, b))
}

///|
test "aabb_contains basic" {
  let box = AABB::new(0.0, 0.0, 4.0, 4.0)
  assert_true(aabb_contains(box, 2.0, 2.0))
  assert_false(aabb_contains(box, 5.0, 5.0))
}

///|
test "broad_phase_aabb basic" {
  let boxes = [
    AABB::new(0.0, 0.0, 2.0, 2.0),
    AABB::new(1.0, 1.0, 3.0, 3.0),
    AABB::new(10.0, 10.0, 12.0, 12.0),
  ]
  let pairs = broad_phase_aabb(boxes)
  assert_true(pairs.length() >= 1)
}

///|
test "segment_segment_collide crossing" {
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(2.0, 2.0)
  let b1 = @core.Point2D::new(0.0, 2.0)
  let b2 = @core.Point2D::new(2.0, 0.0)
  assert_true(segment_segment_collide(a1, a2, b1, b2))
}

///|
test "segment_segment_collide parallel" {
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(2.0, 0.0)
  let b1 = @core.Point2D::new(0.0, 1.0)
  let b2 = @core.Point2D::new(2.0, 1.0)
  assert_false(segment_segment_collide(a1, a2, b1, b2))
}

///|
test "point_in_polygon basic" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(point_in_polygon(@core.Point2D::new(2.0, 2.0), poly))
  assert_false(point_in_polygon(@core.Point2D::new(5.0, 5.0), poly))
}

///|
test "circle_circle_collide basic" {
  let c1 = @core.Point2D::new(0.0, 0.0)
  let c2 = @core.Point2D::new(3.0, 0.0)
  assert_true(circle_circle_collide(c1, 2.0, c2, 2.0))
  assert_false(circle_circle_collide(c1, 1.0, c2, 1.0))
}

///|
test "polygon_polygon_collide overlapping" {
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
  assert_true(polygon_polygon_collide(poly1, poly2))
}

///|
test "aabb_intersection overlapping" {
  let a = AABB::new(0.0, 0.0, 4.0, 4.0)
  let b = AABB::new(2.0, 2.0, 6.0, 6.0)
  let result = aabb_intersection(a, b)
  match result {
    Some(box) => assert_true((box.min_x - 2.0).abs() < 0.001)
    None => abort("expected intersection")
  }
}

///|
test "aabb_union basic" {
  let a = AABB::new(0.0, 0.0, 2.0, 2.0)
  let b = AABB::new(1.0, 1.0, 3.0, 3.0)
  let u = aabb_union(a, b)
  assert_true((u.min_x - 0.0).abs() < 0.001)
  assert_true((u.max_x - 3.0).abs() < 0.001)
}

///|
test "aabb_area basic" {
  let box = AABB::new(0.0, 0.0, 4.0, 3.0)
  assert_true((aabb_area(box) - 12.0).abs() < 0.001)
}

///|
test "aabb_from_center basic" {
  let box = AABB::from_center(5.0, 5.0, 2.0, 3.0)
  assert_true((box.min_x - 3.0).abs() < 0.001)
  assert_true((box.max_x - 7.0).abs() < 0.001)
}

///|
test "aabb_from_polygon basic" {
  let poly = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(3.0, 7.0),
  ]
  let box = aabb_from_polygon(poly)
  assert_true((box.min_x - 1.0).abs() < 0.001)
  assert_true((box.max_x - 5.0).abs() < 0.001)
  assert_true((box.min_y - 2.0).abs() < 0.001)
  assert_true((box.max_y - 7.0).abs() < 0.001)
}

///|
test "segment_polygon_collide crossing" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let a = @core.Point2D::new(-1.0, 2.0)
  let b = @core.Point2D::new(5.0, 2.0)
  assert_true(segment_polygon_collide(a, b, poly))
}

///|
test "segment_polygon_collide disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let a = @core.Point2D::new(10.0, 10.0)
  let b = @core.Point2D::new(12.0, 12.0)
  assert_false(segment_polygon_collide(a, b, poly))
}

///|
test "circle_polygon_collide inside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(2.0, 2.0)
  assert_true(circle_polygon_collide(center, 0.5, poly))
}

///|
test "circle_polygon_collide disjoint" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(10.0, 10.0)
  assert_false(circle_polygon_collide(center, 0.5, poly))
}

///|
test "aabb_polygon_collide overlapping" {
  let box = AABB::new(1.0, 1.0, 3.0, 3.0)
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(aabb_polygon_collide(box, poly))
}

///|
test "aabb_polygon_collide disjoint" {
  let box = AABB::new(10.0, 10.0, 12.0, 12.0)
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_false(aabb_polygon_collide(box, poly))
}

///|
/// 触发 aabb_from_polygon 中 min_x、min_y 更新分支（行 68、71）。
/// 首点非极小，后续点更新 min_x 与 min_y。
test "aabb_from_polygon updates min x and y" {
  let poly = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(5.0, 1.0),
  ]
  let box = aabb_from_polygon(poly)
  assert_true((box.min_x - 1.0).abs() < 0.001)
  assert_true((box.min_y - 1.0).abs() < 0.001)
  assert_true((box.max_x - 5.0).abs() < 0.001)
  assert_true((box.max_y - 5.0).abs() < 0.001)
}

///|
/// 触发 broad_phase_aabb 排序比较的 > 与 == 分支（行 109、112）。
/// min_x 含相等和大于关系。
test "broad_phase_aabb equal and greater min_x" {
  let boxes = [
    AABB::new(2.0, 0.0, 3.0, 3.0),
    AABB::new(1.0, 0.0, 2.5, 3.0),
    AABB::new(1.0, 0.0, 2.5, 3.0),
  ]
  let pairs = broad_phase_aabb(boxes)
  // 后两个 min_x 相等且与第一个在 x 上重叠
  assert_true(pairs.length() >= 1)
}

///|
/// 触发 segment_polygon_collide 端点在多边形内的 return true（行 190）。
test "segment_polygon_collide endpoint inside" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let a = @core.Point2D::new(2.0, 2.0)
  let b = @core.Point2D::new(10.0, 10.0)
  assert_true(segment_polygon_collide(a, b, poly))
}

///|
/// 触发 polygon_polygon_collide 第二循环 return true（行 214）。
/// poly1 顶点都不在 poly2 内，但 poly2 顶点在 poly1 内。
test "polygon_polygon_collide poly2 inside poly1" {
  let poly1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let poly2 = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ]
  assert_true(polygon_polygon_collide(poly1, poly2))
}

///|
/// 触发 polygon_polygon_collide 边相交 return true（行 227）。
/// 两多边形顶点互不在对方内，但边相交。
test "polygon_polygon_collide edge crossing only" {
  let poly1 = [
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(4.0, 1.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let poly2 = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(1.0, 4.0),
  ]
  assert_true(polygon_polygon_collide(poly1, poly2))
}

///|
/// 触发 circle_polygon_collide 边距离 return true（行 249）。
/// 圆心在多边形外，但圆与边距离 <= radius。
test "circle_polygon_collide edge proximity" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let center = @core.Point2D::new(2.0, -0.5)
  assert_true(circle_polygon_collide(center, 1.0, poly))
}

///|
/// 触发 point_segment_dist_sq 退化线段分支（行 265）。
/// a == b，len_sq < 1e-12，返回 p 到 a 的距离平方。
test "point_segment_dist_sq degenerate segment" {
  let p = @core.Point2D::new(2.0, 2.0)
  let a = @core.Point2D::new(1.0, 1.0)
  let d = point_segment_dist_sq(p, a, a)
  // p 到 a 距离平方 = (1)^2 + (1)^2 = 2
  assert_true((d - 2.0).abs() < 0.001)
}

///|
/// 触发 point_segment_dist_sq 投影 t 钳制分支（t < 0 与 t > 1）。
test "point_segment_dist_sq clamp before segment" {
  let p = @core.Point2D::new(-1.0, 0.0)
  let a = @core.Point2D::new(2.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  // 投影 t < 0，钳制到 0，距离 = p 到 a = 3
  let d = point_segment_dist_sq(p, a, b)
  assert_true((d - 9.0).abs() < 0.001)
}

///|
test "point_segment_dist_sq clamp after segment" {
  let p = @core.Point2D::new(7.0, 0.0)
  let a = @core.Point2D::new(2.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  // 投影 t > 1，钳制到 1，距离 = p 到 b = 3
  let d = point_segment_dist_sq(p, a, b)
  assert_true((d - 9.0).abs() < 0.001)
}

///|
/// 触发 aabb_intersection 无重叠返回 None（行 290）。
test "aabb_intersection disjoint returns none" {
  let a = AABB::new(0.0, 0.0, 1.0, 1.0)
  let b = AABB::new(2.0, 2.0, 3.0, 3.0)
  match aabb_intersection(a, b) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
/// 触发 aabb_overlap 边界相切（各分离轴边界）。
test "aabb_overlap touching boundary" {
  let a = AABB::new(0.0, 0.0, 1.0, 1.0)
  let b = AABB::new(1.0, 1.0, 2.0, 2.0)
  assert_true(aabb_overlap(a, b))
}

///|
test "aabb_contains boundary" {
  let box = AABB::new(0.0, 0.0, 4.0, 4.0)
  assert_true(aabb_contains(box, 0.0, 0.0))
  assert_true(aabb_contains(box, 4.0, 4.0))
  assert_false(aabb_contains(box, -0.1, 2.0))
}
