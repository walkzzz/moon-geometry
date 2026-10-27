///|
test "cspace_expand_circle basic" {
  let obstacle = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let cso = cspace_expand_circle(obstacle, 1.0, 0)
  assert_true(cso.size() > 0)
}

///|
test "cspace_expand_circle with arc" {
  let obstacle = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let cso = cspace_expand_circle(obstacle, 1.0, 8)
  assert_true(cso.size() > 4)
}

///|
test "cspace_expand_polygon basic" {
  let obstacle = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let robot = [
    @core.Point2D::new(-0.5, -0.5),
    @core.Point2D::new(0.5, -0.5),
    @core.Point2D::new(0.5, 0.5),
    @core.Point2D::new(-0.5, 0.5),
  ]
  let cso = cspace_expand_polygon(obstacle, robot)
  assert_true(cso.size() >= 4)
}

///|
test "cspace_point_valid no obstacles" {
  let obstacles : Array[CSpaceObstacle] = []
  let q = @core.Point2D::new(5.0, 5.0)
  assert_true(cspace_point_valid(q, obstacles))
}

///|
test "cspace_point_valid inside obstacle" {
  let cso = CSpaceObstacle::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let q = @core.Point2D::new(2.0, 2.0)
  assert_false(cspace_point_valid(q, [cso]))
}

///|
test "cspace_point_valid outside obstacle" {
  let cso = CSpaceObstacle::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let q = @core.Point2D::new(5.0, 5.0)
  assert_true(cspace_point_valid(q, [cso]))
}

///|
test "cspace_segment_valid no obstacles" {
  let obstacles : Array[CSpaceObstacle] = []
  let q1 = @core.Point2D::new(0.0, 0.0)
  let q2 = @core.Point2D::new(10.0, 10.0)
  assert_true(cspace_segment_valid(q1, q2, obstacles))
}

///|
test "cspace_segment_valid through obstacle" {
  let cso = CSpaceObstacle::new([
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ])
  let q1 = @core.Point2D::new(0.0, 5.0)
  let q2 = @core.Point2D::new(10.0, 5.0)
  assert_false(cspace_segment_valid(q1, q2, [cso]))
}

///|
test "cspace_build basic" {
  let obstacles : Array[Array[@core.Point2D]] = [
    [
      @core.Point2D::new(4.0, 4.0),
      @core.Point2D::new(6.0, 4.0),
      @core.Point2D::new(6.0, 6.0),
      @core.Point2D::new(4.0, 6.0),
    ],
  ]
  let cspace = cspace_build(obstacles, 1.0, 0)
  assert_eq(cspace.length(), 1)
  assert_true(cspace[0].size() > 0)
}

///|
test "CSpaceObstacle size and get" {
  let cso = CSpaceObstacle::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ])
  assert_eq(cso.size(), 3)
  assert_true((cso.get(0).x() - 0.0).abs() < 0.001)
}

///|
test "cspace_expand_circle empty obstacle" {
  // 覆盖 L50: n == 0 时 return CSpaceObstacle::new([])
  let cso = cspace_expand_circle([], 1.0, 0)
  assert_eq(cso.size(), 0)
}

///|
test "cspace_expand_circle degenerate edge skipped" {
  // 覆盖 L60: 重复相邻点导致 len < eps 的 continue
  let obstacle = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let cso = cspace_expand_circle(obstacle, 1.0, 0)
  assert_true(cso.size() > 0)
}

///|
test "cspace_expand_circle arc degenerate edge skipped" {
  // 覆盖 L83: 重复点 + arc 采样导致 len2 < eps 的 continue
  let obstacle = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let cso = cspace_expand_circle(obstacle, 1.0, 8)
  assert_true(cso.size() > 0)
}

///|
test "cspace_expand_circle arc third quadrant normal" {
  // 覆盖 L118: atan2_impl 第三象限分支 (y<0 && x<0)
  // 三角形含 prev->vertex 向右下边 (dx1>0, dy1<0) => 法向量 n1x<0, n1y<0
  let obstacle = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, -3.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let cso = cspace_expand_circle(obstacle, 1.0, 8)
  assert_true(cso.size() > 0)
}

///|
test "cspace_expand_polygon convex_hull small input" {
  // 覆盖 L189: convex_hull points.length() <= 2 直接返回
  let obstacle = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let robot = [@core.Point2D::new(0.0, 0.0)]
  let cso = cspace_expand_polygon(obstacle, robot)
  assert_true(cso.size() <= 2)
}

///|
test "cspace_expand_polygon sort_by_x equal points" {
  // 覆盖 L244: sort_by_x 比较完全相同点返回 0
  let obstacle = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let robot = [@core.Point2D::new(0.0, 0.0)]
  let cso = cspace_expand_polygon(obstacle, robot)
  assert_true(cso.size() >= 1)
}

///|
test "cspace_segment_valid endpoint inside obstacle" {
  // 覆盖 L275: q1 在障碍物内 => return false
  let cso = CSpaceObstacle::new([
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ])
  let q1 = @core.Point2D::new(5.0, 5.0)
  let q2 = @core.Point2D::new(10.0, 10.0)
  assert_false(cspace_segment_valid(q1, q2, [cso]))
}

///|
test "cspace_point_valid empty obstacle vertices" {
  // 覆盖 L290: point_in_polygon n == 0 => return false (不在内 => valid)
  let cso = CSpaceObstacle::new([])
  let q = @core.Point2D::new(5.0, 5.0)
  assert_true(cspace_point_valid(q, [cso]))
}
