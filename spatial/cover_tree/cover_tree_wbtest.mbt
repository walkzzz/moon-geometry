test "cover_tree build and count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tree = cover_tree_build(pts)
  assert_eq(cover_tree_count(tree), 4)
}

test "cover_tree radius search" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tree = cover_tree_build(pts)
  let result = cover_tree_radius_search(tree, @core.Point2D::new(1.0, 1.0), 3.0)
  assert_true(result.length() >= 1)
}

test "cover_tree empty" {
  let tree = cover_tree_build([])
  assert_eq(cover_tree_count(tree), 0)
}

test "cover_tree single" {
  let tree = cover_tree_build([@core.Point2D::new(1.0, 1.0)])
  assert_eq(cover_tree_count(tree), 1)
}

test "cover_tree many points" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<10 {
    pts.push(@core.Point2D::new(i.to_double(), i.to_double()))
  }
  let tree = cover_tree_build(pts)
  assert_eq(cover_tree_count(tree), 10)
}