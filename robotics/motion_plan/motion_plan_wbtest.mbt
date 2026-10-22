test "plan_path no obstacles" {
  let obstacles : Array[Array[@core.Point2D]] = []
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let path = plan_path(obstacles, start, goal)
  assert_eq(path.length(), 2)
}

test "path_length basic" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let len = path_length(path)
  assert_true((len - 5.0).abs() < 0.001)
}

test "is_path_valid no obstacles" {
  let path = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
  ]
  let obstacles : Array[Array[@core.Point2D]] = []
  assert_true(is_path_valid(path, obstacles))
}

test "plan_path with obstacle" {
  let obstacles : Array[Array[@core.Point2D]] = [[
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 6.0),
  ]]
  let start = @core.Point2D::new(0.0, 0.0)
  let goal = @core.Point2D::new(10.0, 10.0)
  let path = plan_path(obstacles, start, goal)
  assert_true(path.length() >= 2)
}

test "path_length empty" {
  let path : Array[@core.Point2D] = []
  assert_true(path_length(path).abs() < 0.001)
}