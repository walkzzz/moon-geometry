///|
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

///|
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

///|
test "ball_tree empty" {
  let tree = ball_tree_build([])
  assert_eq(ball_tree_count(tree), 0)
}

///|
test "ball_tree single point" {
  let tree = ball_tree_build([@core.Point2D::new(1.0, 1.0)])
  assert_eq(ball_tree_count(tree), 1)
}

///|
test "ball_tree many points" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<20 {
    pts.push(@core.Point2D::new(i.to_double(), i.to_double()))
  }
  let tree = ball_tree_build(pts)
  assert_eq(ball_tree_count(tree), 20)
}

///|
test "ball_tree knn k1" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let tree = ball_tree_build(pts)
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.5, 0.0), 1)
  assert_eq(nn.length(), 1)
  assert_true(@core.approx_eq(nn[0].x(), 0.0, 0.001))
}

///|
test "ball_tree knn k larger than points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let tree = ball_tree_build(pts)
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 5)
  assert_eq(nn.length(), 2)
}

///|
test "ball_tree knn empty tree" {
  let tree : BallNode? = None
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 3)
  assert_eq(nn.length(), 0)
}

///|
test "ball_tree knn query at point" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(6.0, 8.0),
  ]
  let tree = ball_tree_build(pts)
  let nn = ball_tree_knn(tree, @core.Point2D::new(3.0, 4.0), 1)
  assert_eq(nn.length(), 1)
  assert_true(@core.approx_eq(nn[0].x(), 3.0, 0.001))
  assert_true(@core.approx_eq(nn[0].y(), 4.0, 0.001))
}

///|
test "ball_tree duplicate points" {
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let tree = ball_tree_build(pts)
  assert_eq(ball_tree_count(tree), 3)
}

///|
test "ball_tree y-axis split" {
  // Points spread more along y than x → triggers y-axis sort branch
  let pts : Array[@core.Point2D] = []
  for i in 0..<15 {
    pts.push(@core.Point2D::new(0.0, i.to_double()))
  }
  let tree = ball_tree_build(pts)
  assert_eq(ball_tree_count(tree), 15)
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.0, 7.0), 1)
  assert_eq(nn.length(), 1)
}

///|
test "ball_tree knn all same points" {
  let pts = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tree = ball_tree_build(pts)
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 2)
  assert_eq(nn.length(), 2)
}

///|
test "ball_tree x-sort reverse and equal keys" {
  // >10 points, spread_x > spread_y (=0), x values contain reverse pairs
  // and equal pairs to cover sort comparator `>` and `==` branches.
  let pts : Array[@core.Point2D] = []
  let xs = [5.0, 3.0, 5.0, 1.0, 8.0, 2.0, 7.0, 4.0, 6.0, 9.0, 0.0, 10.0]
  for i in 0..<xs.length() {
    pts.push(@core.Point2D::new(xs[i], 0.0))
  }
  let tree = ball_tree_build(pts)
  assert_eq(ball_tree_count(tree), 12)
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 1)
  assert_eq(nn.length(), 1)
  assert_true(@core.approx_eq(nn[0].x(), 0.0, 0.001))
}

///|
test "ball_tree y-sort reverse and equal keys" {
  // >10 points, spread_y > spread_x (=0), y values contain reverse pairs
  // and equal pairs to cover sort comparator `>` and `==` branches.
  let pts : Array[@core.Point2D] = []
  let ys = [5.0, 3.0, 5.0, 1.0, 8.0, 2.0, 7.0, 4.0, 6.0, 9.0, 0.0, 10.0]
  for i in 0..<ys.length() {
    pts.push(@core.Point2D::new(0.0, ys[i]))
  }
  let tree = ball_tree_build(pts)
  assert_eq(ball_tree_count(tree), 12)
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 1)
  assert_eq(nn.length(), 1)
  assert_true(@core.approx_eq(nn[0].y(), 0.0, 0.001))
}

///|
test "ball_tree knn result sort comparator branches" {
  // Points in decreasing distance from the query with k=3 force the
  // result sort to compare reverse pairs (covering `>` on push-sort) and
  // a replacement that re-sorts covering both `<` and `>` branches.
  let pts = [
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let tree = ball_tree_build(pts)
  let nn = ball_tree_knn(tree, @core.Point2D::new(0.0, 0.0), 3)
  assert_eq(nn.length(), 3)
  // Nearest three in ascending distance: (1,0), (5,0), (8,0).
  assert_true(@core.approx_eq(nn[0].x(), 1.0, 0.001))
  assert_true(@core.approx_eq(nn[1].x(), 5.0, 0.001))
  assert_true(@core.approx_eq(nn[2].x(), 8.0, 0.001))
}
