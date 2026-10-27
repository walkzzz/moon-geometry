///|
test "is_y_monotone_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_y_monotone(sq))
}

///|
test "is_x_monotone_square" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_x_monotone(sq))
}

///|
test "is_y_monotone_non_monotone" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(2.0, 6.0),
    @core.Point2D::new(0.0, 6.0),
  ]
  assert_false(is_y_monotone(poly))
}

///|
test "triangulate_monotone_triangle" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let tris = triangulate_monotone(tri)
  assert_true(tris.length() == 1)
}

///|
test "monotone_triangulate_count" {
  let sq = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let count = monotone_triangulate_count(sq)
  assert_true(count == 2)
}

///|
test "is_y_monotone too few points" {
  assert_false(is_y_monotone([]))
  assert_false(is_y_monotone([@core.Point2D::new(0.0, 0.0)]))
  assert_false(
    is_y_monotone([@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]),
  )
}

///|
test "is_x_monotone too few points" {
  assert_false(is_x_monotone([]))
  assert_false(is_x_monotone([@core.Point2D::new(0.0, 0.0)]))
  assert_false(
    is_x_monotone([@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]),
  )
}

///|
test "is_y_monotone triangle" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  assert_true(is_y_monotone(tri))
}

///|
test "is_x_monotone triangle" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_x_monotone(tri))
}

///|
test "is_x_monotone non monotone" {
  // C-shaped polygon: a horizontal line at y=3 crosses 4 edges => not x-monotone
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(1.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 6.0),
    @core.Point2D::new(0.0, 6.0),
  ]
  assert_false(is_x_monotone(poly))
}

///|
test "triangulate_monotone too few points" {
  assert_eq(triangulate_monotone([]).length(), 0)
  assert_eq(triangulate_monotone([@core.Point2D::new(0.0, 0.0)]).length(), 0)
  assert_eq(
    triangulate_monotone([
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(1.0, 1.0),
    ]).length(),
    0,
  )
}

///|
test "triangulate_monotone pentagon" {
  // Convex y-monotone pentagon
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(2.0, 6.0),
    @core.Point2D::new(-1.0, 3.0),
  ]
  let tris = triangulate_monotone(poly)
  // n - 2 = 3 triangles
  assert_eq(tris.length(), 3)
}

///|
test "triangulate_monotone hexagon" {
  // Convex y-monotone hexagon
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(5.0, 2.0),
    @core.Point2D::new(4.0, 5.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(-1.0, 2.0),
  ]
  let tris = triangulate_monotone(poly)
  // n - 2 = 4 triangles
  assert_eq(tris.length(), 4)
}

///|
test "monotone_triangulate_count triangle" {
  let tri = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  assert_eq(monotone_triangulate_count(tri), 1)
}

///|
test "is_y_monotone first vertex not bottom" {
  // poly[0] has the largest y => bottom_idx update branch (line 15)
  let poly = [
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  assert_true(is_y_monotone(poly))
}

///|
test "is_y_monotone right chain increases" {
  // left chain is y-decreasing, but right chain goes 8->0->2->0, so the
  // right-chain check returns false (line 39).
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 8.0),
    @core.Point2D::new(0.0, 8.0),
  ]
  assert_false(is_y_monotone(poly))
}

///|
test "is_x_monotone first vertex not leftmost" {
  // poly[0] is not the leftmost => left_idx update branch (line 56)
  let poly = [
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(is_x_monotone(poly))
}

///|
test "is_x_monotone upper chain decreases" {
  // upper chain x: 0->2->1->4 has a decrease at 1<2, so the upper-chain
  // check returns false (line 78).
  let poly = [
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  assert_false(is_x_monotone(poly))
}

///|
test "triangulate_monotone first vertex not bottom" {
  // poly[0] is the top => bottom_idx update branch in triangulate (line 109)
  let poly = [
    @core.Point2D::new(2.0, 6.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = triangulate_monotone(poly)
  assert_eq(tris.length(), 3)
}
