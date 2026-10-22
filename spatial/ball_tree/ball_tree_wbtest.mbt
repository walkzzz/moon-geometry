test "ball_tree build and count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tree = ball_tree_build(pts)
  assert_eq(ball_tree_count(tree), 5)
}

test "ball_tree knn" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tree = ball_tree_build(pts)
  let nn = ball_tree_knn(tree, @core.Point2D::new(1.0, 1.0), 2)
  assert_eq(nn.length(), 2)
}

test "ball_tree empty" {
  let tree = ball_tree_build([])
  assert_eq(ball_tree_count(tree), 0)
}

test "ball_tree single point" {
  let tree = ball_tree_build([@core.Point2D::new(1.0, 1.0)])
  assert_eq(ball_tree_count(tree), 1)
}

test "ball_tree many points" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<20 {
    pts.push(@core.Point2D::new(i.to_double(), i.to_double()))
  }
  let tree = ball_tree_build(pts)
  assert_eq(ball_tree_count(tree), 20)
}