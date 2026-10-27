///|
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

///|
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

///|
test "cover_tree empty" {
  let tree = cover_tree_build([])
  assert_eq(cover_tree_count(tree), 0)
}

///|
test "cover_tree single" {
  let tree = cover_tree_build([@core.Point2D::new(1.0, 1.0)])
  assert_eq(cover_tree_count(tree), 1)
}

///|
test "cover_tree many points" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<10 {
    pts.push(@core.Point2D::new(i.to_double(), i.to_double()))
  }
  let tree = cover_tree_build(pts)
  assert_eq(cover_tree_count(tree), 10)
}

///|
test "dist basic" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(3.0, 4.0)
  let d = dist(a, b)
  assert_true((d - 5.0).abs() < 0.0001)
}

///|
test "dist zero" {
  let a = @core.Point2D::new(1.0, 2.0)
  let d = dist(a, a)
  assert_true(d.abs() < 0.0001)
}

///|
test "dist symmetric" {
  let a = @core.Point2D::new(1.0, 2.0)
  let b = @core.Point2D::new(4.0, 6.0)
  let d1 = dist(a, b)
  let d2 = dist(b, a)
  assert_true((d1 - d2).abs() < 0.0001)
}

///|
test "pow2 positive exp" {
  let r = pow2(2.0, 3)
  assert_true((r - 8.0).abs() < 0.0001)
}

///|
test "pow2 zero exp" {
  let r = pow2(5.0, 0)
  assert_true((r - 1.0).abs() < 0.0001)
}

///|
test "pow2 negative exp" {
  let r = pow2(2.0, -2)
  assert_true((r - 0.25).abs() < 0.0001)
}

///|
test "pow2 base 3" {
  let r = pow2(3.0, 2)
  assert_true((r - 9.0).abs() < 0.0001)
}

///|
test "cover_tree_count via cover_count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let tree = cover_tree_build(pts)
  assert_eq(cover_tree_count(tree), 3)
}

///|
test "cover_tree radius search zero radius" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(5.0, 0.0)]
  let tree = cover_tree_build(pts)
  let result = cover_tree_radius_search(tree, @core.Point2D::new(0.0, 0.0), 0.0)
  assert_true(result.length() >= 1)
}

///|
test "cover_tree radius search large radius" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
  ]
  let tree = cover_tree_build(pts)
  let result = cover_tree_radius_search(
    tree,
    @core.Point2D::new(5.0, 0.0),
    100.0,
  )
  assert_eq(result.length(), 3)
}

///|
test "cover_tree radius search empty tree" {
  let tree = cover_tree_build([])
  let result = cover_tree_radius_search(
    tree,
    @core.Point2D::new(0.0, 0.0),
    10.0,
  )
  assert_eq(result.length(), 0)
}

///|
test "cover_tree duplicate points" {
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let tree = cover_tree_build(pts)
  assert_eq(cover_tree_count(tree), 3)
}

///|
test "cover_tree two points close" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(0.1, 0.1)]
  let tree = cover_tree_build(pts)
  assert_eq(cover_tree_count(tree), 2)
  let result = cover_tree_radius_search(tree, @core.Point2D::new(0.0, 0.0), 0.2)
  assert_true(result.length() >= 1)
}
