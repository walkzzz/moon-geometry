test "constrained_delaunay empty" {
  let cd = constrained_delaunay([], [])
  assert_eq(cd.triangle_count(), 0)
  assert_eq(cd.constraint_count(), 0)
}

test "constrained_delaunay too few points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let cd = constrained_delaunay(pts, [])
  assert_eq(cd.triangle_count(), 0)
}

test "constrained_delaunay triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 1.0),
  ]
  let cd = constrained_delaunay(pts, [])
  assert_true(cd.triangle_count() >= 1)
}

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

test "add_constraint" {
  let cd = ConstrainedDelaunay::new()
  add_constraint(cd, 0, 1)
  add_constraint(cd, 1, 2)
  assert_eq(cd.constraint_count(), 2)
  assert_true(is_constrained_edge(cd, 0, 1))
  assert_true(is_constrained_edge(cd, 1, 2))
}

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

test "ConstrainedDelaunay::new" {
  let cd = ConstrainedDelaunay::new()
  assert_eq(cd.triangle_count(), 0)
  assert_eq(cd.constraint_count(), 0)
}

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