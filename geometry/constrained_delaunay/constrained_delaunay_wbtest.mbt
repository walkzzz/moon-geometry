///|
test "constrained_delaunay empty" {
  let cd = constrained_delaunay([], [])
  assert_eq(cd.triangle_count(), 0)
  assert_eq(cd.constraint_count(), 0)
}

///|
test "constrained_delaunay too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let cd = constrained_delaunay(pts, [])
  assert_eq(cd.triangle_count(), 0)
}

///|
test "constrained_delaunay triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 1.0),
  ]
  let cd = constrained_delaunay(pts, [])
  assert_true(cd.triangle_count() >= 1)
}

///|
test "constrained_delaunay square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let cd = constrained_delaunay(pts, [(0, 2)])
  assert_true(cd.triangle_count() >= 2)
  assert_eq(cd.constraint_count(), 1)
}

///|
test "is_constrained_edge" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 1.0),
  ]
  let cd = constrained_delaunay(pts, [(0, 1)])
  assert_true(is_constrained_edge(cd, 0, 1))
  assert_true(is_constrained_edge(cd, 1, 0))
  assert_false(is_constrained_edge(cd, 0, 2))
}

///|
test "add_constraint" {
  let cd = ConstrainedDelaunay::new()
  add_constraint(cd, 0, 1)
  add_constraint(cd, 1, 2)
  assert_eq(cd.constraint_count(), 2)
  assert_true(is_constrained_edge(cd, 0, 1))
  assert_true(is_constrained_edge(cd, 1, 2))
}

///|
test "constrained_triangle_count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let cd = constrained_delaunay(pts, [])
  assert_true(constrained_triangle_count(cd) >= 3)
}

///|
test "ConstrainedDelaunay::new" {
  let cd = ConstrainedDelaunay::new()
  assert_eq(cd.triangle_count(), 0)
  assert_eq(cd.constraint_count(), 0)
}

///|
test "constrained_delaunay with multiple constraints" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let cd = constrained_delaunay(pts, [(0, 1), (1, 2), (2, 3), (3, 0)])
  assert_eq(cd.constraint_count(), 4)
  assert_true(cd.triangle_count() >= 2)
}

///|
test "circumcenter basic" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(2.0, 2.0)
  let center = circumcenter(a, b, c)
  assert_true((center.x() - 2.0).abs() < 0.001)
}

///|
test "circumcenter degenerate" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  let center = circumcenter(a, b, c)
  assert_true((center.x() - 1.0).abs() < 0.001)
  assert_true((center.y() - 0.0).abs() < 0.001)
}

///|
test "in_circumcircle inside" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(2.0, 2.0)
  let p = @core.Point2D::new(2.0, 0.5)
  assert_true(in_circumcircle(p, a, b, c))
}

///|
test "in_circumcircle outside" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(2.0, 2.0)
  let p = @core.Point2D::new(10.0, 10.0)
  assert_false(in_circumcircle(p, a, b, c))
}

///|
test "edge_in_triangle basic" {
  assert_true(edge_in_triangle((0, 1, 2), 0, 1))
  assert_true(edge_in_triangle((0, 1, 2), 1, 2))
  assert_true(edge_in_triangle((0, 1, 2), 2, 0))
  assert_true(edge_in_triangle((0, 1, 2), 1, 0))
  assert_false(edge_in_triangle((0, 1, 2), 0, 3))
}

///|
test "add_edge_cnt basic" {
  let edges : Array[(Int32, Int32, Int32)] = []
  add_edge_cnt(edges, 1, 2)
  assert_eq(edges.length(), 1)
  add_edge_cnt(edges, 2, 1)
  assert_eq(edges.length(), 1)
  assert_eq(edges[0].2, 2)
}

///|
test "tri_circumradius basic" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 0.0)
  let c = @core.Point2D::new(1.0, 1.0)
  let r = tri_circumradius(a, b, c)
  assert_true(r > 0.0)
}

///|
test "constrained_delaunay degenerate points" {
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let cd = constrained_delaunay(pts, [])
  assert_eq(cd.triangle_count(), 0)
}

///|
test "constrained_delaunay collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let cd = constrained_delaunay(pts, [])
  assert_eq(cd.triangle_count(), 0)
}

///|
test "is_constrained_edge empty" {
  let cd = ConstrainedDelaunay::new()
  assert_false(is_constrained_edge(cd, 0, 1))
}

///|
test "add_constraint duplicate" {
  let cd = ConstrainedDelaunay::new()
  add_constraint(cd, 0, 1)
  add_constraint(cd, 0, 1)
  assert_eq(cd.constraint_count(), 2)
}

///|
test "constrained_delaunay with invalid constraint" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 1.0),
  ]
  let cd = constrained_delaunay(pts, [(0, 10)])
  assert_eq(cd.constraint_count(), 1)
}

///|
test "constrained_delaunay pentagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 1.5),
    @core.Point2D::new(1.5, 3.0),
    @core.Point2D::new(-0.5, 1.5),
  ]
  let cd = constrained_delaunay(pts, [])
  assert_true(cd.triangle_count() >= 3)
}
