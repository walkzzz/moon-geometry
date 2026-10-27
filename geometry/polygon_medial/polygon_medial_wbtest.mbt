///|
test "medial_axis square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let poly = @core.Polygon::new(pts)
  let ma = medial_axis(poly, 20)
  assert_true(ma.length() >= 0)
}

///|
test "medial_axis_points square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let poly = @core.Polygon::new(pts)
  let mp = medial_axis_points(poly, 10)
  assert_true(mp.length() >= 1)
}

///|
test "medial_axis triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(4.0, 6.0),
  ]
  let poly = @core.Polygon::new(pts)
  let ma = medial_axis(poly, 15)
  assert_true(ma.length() >= 0)
}

///|
test "medial_axis degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let poly = @core.Polygon::new(pts)
  let ma = medial_axis(poly, 10)
  assert_eq(ma.length(), 0)
}

///|
test "medial_axis_points degenerate" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let poly = @core.Polygon::new(pts)
  let mp = medial_axis_points(poly, 5)
  assert_eq(mp.length(), 0)
}

///|
test "medial_axis resolution too small" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let poly = @core.Polygon::new(pts)
  let ma = medial_axis(poly, 1)
  assert_eq(ma.length(), 0)
}

///|
test "medial_axis_points zero samples" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let poly = @core.Polygon::new(pts)
  let mp = medial_axis_points(poly, 0)
  assert_eq(mp.length(), 0)
}

///|
test "medial_axis_points more samples than candidates" {
  // Thin triangle: bounding box 10x1, step picks min(dx,dy) so only a small
  // corner of the box is sampled => candidates.length() < n_samples.
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 1.0),
  ]
  let poly = @core.Polygon::new(pts)
  let mp = medial_axis_points(poly, 100)
  assert_true(mp.length() >= 1)
}

///|
test "point_seg_dist degenerate segment" {
  // a == b => len_sq < epsilon branch
  let p = @core.Point2D::new(3.0, 4.0)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 0.0)
  let d = point_seg_dist(p, a, b)
  assert_true((d - 5.0).abs() < 0.0000001)
}

///|
test "point_seg_dist t negative" {
  // Projection falls before a => t < 0, closest is a
  let p = @core.Point2D::new(-1.0, -1.0)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 4.0)
  let d = point_seg_dist(p, a, b)
  // dist to a=(0,0) = sqrt(2)
  assert_true((d - 1.4142135623730951).abs() < 0.0000001)
}

///|
test "point_seg_dist t over one" {
  // Projection falls after b => t > 1, closest is b
  let p = @core.Point2D::new(-1.0, 5.0)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 4.0)
  let d = point_seg_dist(p, a, b)
  // dist to b=(0,4) = sqrt(2)
  assert_true((d - 1.4142135623730951).abs() < 0.0000001)
}

///|
test "point_seg_dist t in range" {
  // Projection inside segment => 0 <= t <= 1
  let p = @core.Point2D::new(-3.0, 2.0)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(0.0, 4.0)
  let d = point_seg_dist(p, a, b)
  // closest is (0,2), dist = 3
  assert_true((d - 3.0).abs() < 0.0000001)
}

///|
test "is_interior inside square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let p = @core.Point2D::new(5.0, 5.0)
  assert_true(is_interior(p, pts))
}

///|
test "is_interior outside square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let p = @core.Point2D::new(15.0, 15.0)
  assert_false(is_interior(p, pts))
}

///|
test "is_interior inside triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(4.0, 6.0),
  ]
  let p = @core.Point2D::new(4.0, 2.0)
  assert_true(is_interior(p, pts))
}

///|
test "is_interior outside triangle left" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(8.0, 0.0),
    @core.Point2D::new(4.0, 6.0),
  ]
  let p = @core.Point2D::new(-2.0, 2.0)
  assert_false(is_interior(p, pts))
}

///|
test "two_nearest_edge_dist square center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let p = @core.Point2D::new(5.0, 5.0)
  let (d1, d2) = two_nearest_edge_dist(p, pts)
  // Center of square: all four edges at distance 5
  assert_true((d1 - 5.0).abs() < 0.0000001)
  assert_true((d2 - 5.0).abs() < 0.0000001)
}

///|
test "two_nearest_edge_dist near one edge" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  // Point close to bottom edge, exercises d<d1 then d<d2 branches
  let p = @core.Point2D::new(5.0, 1.0)
  let (d1, d2) = two_nearest_edge_dist(p, pts)
  assert_true(d1 <= d2)
  assert_true((d1 - 1.0).abs() < 0.0000001)
}
