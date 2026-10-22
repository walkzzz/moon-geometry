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

test "cspace_point_valid no obstacles" {
  let obstacles : Array[CSpaceObstacle] = []
  let q = @core.Point2D::new(5.0, 5.0)
  assert_true(cspace_point_valid(q, obstacles))
}

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

test "cspace_segment_valid no obstacles" {
  let obstacles : Array[CSpaceObstacle] = []
  let q1 = @core.Point2D::new(0.0, 0.0)
  let q2 = @core.Point2D::new(10.0, 10.0)
  assert_true(cspace_segment_valid(q1, q2, obstacles))
}

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

test "cspace_build basic" {
  let obstacles : Array[Array[@core.Point2D]] = [[
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ]]
  let cspace = cspace_build(obstacles, 1.0, 0)
  assert_eq(cspace.length(), 1)
  assert_true(cspace[0].size() > 0)
}

test "CSpaceObstacle size and get" {
  let cso = CSpaceObstacle::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ])
  assert_eq(cso.size(), 3)
  assert_true((cso.get(0).x() - 0.0).abs() < 0.001)
}