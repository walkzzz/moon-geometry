test "rrt_plan no obstacles" {
  let config = RRTConfig::new(1.0, 500, 0.1, 0.5, 42U, 0.0, 10.0, 0.0, 10.0)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let result = rrt_plan(config, start, goal, obstacles)
  assert_true(result.success)
  assert_true(result.path.length() >= 2)
}

test "rrt_plan with obstacle" {
  let config = RRTConfig::new(0.5, 1000, 0.1, 0.5, 42U, 0.0, 10.0, 0.0, 10.0)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = [[
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ]]
  let result = rrt_plan(config, start, goal, obstacles)
  assert_true(result.success)
  assert_true(result.path.length() >= 2)
}

test "rrt_plan start equals goal" {
  let config = RRTConfig::new(1.0, 100, 0.1, 0.5, 42U, 0.0, 10.0, 0.0, 10.0)
  let start = @core.Point2D::new(5.0, 5.0)
  let goal = @core.Point2D::new(5.0, 5.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let result = rrt_plan(config, start, goal, obstacles)
  assert_true(result.success)
}

test "rrt_star_plan no obstacles" {
  let config = RRTConfig::new(1.0, 500, 0.1, 0.5, 42U, 0.0, 10.0, 0.0, 10.0)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let result = rrt_star_plan(config, start, goal, obstacles)
  assert_true(result.success)
  assert_true(result.path.length() >= 2)
}

test "rrt_star_plan with obstacle" {
  let config = RRTConfig::new(0.5, 1000, 0.1, 0.5, 42U, 0.0, 10.0, 0.0, 10.0)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = [[
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ]]
  let result = rrt_star_plan(config, start, goal, obstacles)
  assert_true(result.success)
}

test "rrt_connect_plan no obstacles" {
  let config = RRTConfig::new(1.0, 500, 0.1, 0.5, 42U, 0.0, 10.0, 0.0, 10.0)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let result = rrt_connect_plan(config, start, goal, obstacles)
  assert_true(result.success)
  assert_true(result.path.length() >= 2)
}

test "rrt_path_length basic" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let len = rrt_path_length(path)
  assert_true((len - 5.0).abs() < 0.001)
}

test "rrt_path_length empty" {
  let path : Array[@core.Point2D] = []
  assert_true(rrt_path_length(path).abs() < 0.001)
}

test "rrt_node_count basic" {
  let nodes : Array[RRTNode] = [
    RRTNode::new(@core.Point2D::new(0.0, 0.0), -1),
    RRTNode::new(@core.Point2D::new(1.0, 1.0), 0),
  ]
  assert_eq(rrt_node_count(nodes), 2)
}

test "rrt_plan iterations positive" {
  let config = RRTConfig::new(1.0, 100, 0.1, 0.5, 42U, 0.0, 10.0, 0.0, 10.0)
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let obstacles : Array[Array[@core.Point2D]] = []
  let result = rrt_plan(config, start, goal, obstacles)
  assert_true(result.iterations > 0)
}