///|
test "separating_find_axis" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(7.0, 0.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
  ])
  match find_separating_axis(poly1, poly2) {
    Some(_) => assert_true(true)
    None => assert_true(false)
  }
}

///|
test "separating_no_axis" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ])
  match find_separating_axis(poly1, poly2) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "separating_distance" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(7.0, 0.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
  ])
  let d = separating_distance(poly1, poly2)
  assert_true(d > 0.0)
}

///|
test "separating_are_separated" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(7.0, 0.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
  ])
  assert_true(are_separated(poly1, poly2))
}

///|
test "separating_find_axis_reverse poly1 right of poly2" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(7.0, 0.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  match find_separating_axis(poly1, poly2) {
    Some(_) => assert_true(true)
    None => assert_true(false)
  }
}

///|
test "separating_find_axis_from_poly2_edges" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(4.0, 6.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(6.0, 4.0),
  ])
  match find_separating_axis(poly1, poly2) {
    Some(_) => assert_true(true)
    None => assert_true(false)
  }
}

///|
test "separating_distance_reverse covers max2_lt_min1" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(7.0, 0.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let d = separating_distance(poly1, poly2)
  assert_true(d > 0.0)
}

///|
test "separating_distance_intersecting returns zero" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ])
  let d = separating_distance(poly1, poly2)
  assert_true(d == 0.0)
}

///|
test "separating_distance_vertical gap" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(2.0, 7.0),
    @core.Point2D::new(0.0, 7.0),
  ])
  let d = separating_distance(poly1, poly2)
  assert_true(d > 0.0)
}

///|
test "separating_degenerate_edge duplicate vertex" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(7.0, 0.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
  ])
  assert_true(are_separated(poly1, poly2))
}

///|
test "separating_are_separated_intersecting" {
  let poly1 = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let poly2 = @core.Polygon::new([
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(6.0, 2.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(2.0, 6.0),
  ])
  assert_true(!are_separated(poly1, poly2))
}
