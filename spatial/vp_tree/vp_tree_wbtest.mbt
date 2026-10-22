test "vp_tree build and count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tree = vp_tree_build(pts)
  assert_eq(vp_tree_count(tree), 5)
}

test "vp_tree knn" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tree = vp_tree_build(pts)
  let nn = vp_tree_knn(tree, @core.Point2D::new(1.0, 1.0), 2)
  assert_eq(nn.length(), 2)
}

test "vp_tree empty" {
  let tree = vp_tree_build([])
  assert_eq(vp_tree_count(tree), 0)
}

test "vp_tree single" {
  let tree = vp_tree_build([@core.Point2D::new(1.0, 1.0)])
  assert_eq(vp_tree_count(tree), 1)
}

test "vp_tree many points" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<15 {
    pts.push(@core.Point2D::new(i.to_double(), i.to_double() * 2.0))
  }
  let tree = vp_tree_build(pts)
  assert_eq(vp_tree_count(tree), 15)
}