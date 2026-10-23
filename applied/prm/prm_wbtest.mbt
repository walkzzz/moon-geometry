///|
test "prm_build no obstacles" {
  let config = PRMConfig::new(50, 3.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let roadmap = prm_build(config, obstacles)
  assert_true(prm_node_count(roadmap) > 0)
}

///|
test "prm_build with obstacle" {
  let config = PRMConfig::new(50, 3.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = [
    [
      @core.Point2D::new(4.0, 4.0),
      @core.Point2D::new(6.0, 4.0),
      @core.Point2D::new(6.0, 6.0),
      @core.Point2D::new(4.0, 6.0),
    ],
  ]
  let roadmap = prm_build(config, obstacles)
  assert_true(prm_node_count(roadmap) > 0)
}

///|
test "prm_query no obstacles" {
  let config = PRMConfig::new(100, 3.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let roadmap = prm_build(config, obstacles)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let result = prm_query(roadmap, start, goal, obstacles)
  assert_true(result.success)
  assert_true(result.path.length() >= 2)
}

///|
test "prm_query with obstacle" {
  let config = PRMConfig::new(100, 3.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = [
    [
      @core.Point2D::new(4.0, 4.0),
      @core.Point2D::new(6.0, 4.0),
      @core.Point2D::new(6.0, 6.0),
      @core.Point2D::new(4.0, 6.0),
    ],
  ]
  let roadmap = prm_build(config, obstacles)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let result = prm_query(roadmap, start, goal, obstacles)
  assert_true(result.success)
}

///|
test "prm_node_count basic" {
  let config = PRMConfig::new(20, 2.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let roadmap = prm_build(config, obstacles)
  assert_true(prm_node_count(roadmap) <= 20)
}

///|
test "prm_edge_count non-negative" {
  let config = PRMConfig::new(30, 3.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let roadmap = prm_build(config, obstacles)
  assert_true(prm_edge_count(roadmap) >= 0)
}

///|
test "prm_query start equals goal" {
  let config = PRMConfig::new(50, 3.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let roadmap = prm_build(config, obstacles)
  let start = @core.Point2D::new(5.0, 5.0)
  let result = prm_query(roadmap, start, start, obstacles)
  assert_true(result.success)
}

///|
test "prm_build small sample count" {
  let config = PRMConfig::new(5, 5.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let roadmap = prm_build(config, obstacles)
  assert_true(prm_node_count(roadmap) >= 1)
}

///|
test "prm_query distance positive" {
  let config = PRMConfig::new(100, 3.0, 42U, 0.0, 10.0, 0.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let roadmap = prm_build(config, obstacles)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let result = prm_query(roadmap, start, goal, obstacles)
  if result.success {
    assert_true(result.distance > 0.0)
  }
}
