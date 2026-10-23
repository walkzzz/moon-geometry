///|
test "ToleranceCtx::default" {
  let tol = ToleranceCtx::default()
  assert_true(tol.dist_tol > 0.0)
  assert_true(tol.angle_tol > 0.0)
}

///|
test "points_coincide" {
  let tol = ToleranceCtx::loose()
  let a = @core.Point2D::new(1.0, 2.0)
  let b = @core.Point2D::new(1.0000001, 2.0000001)
  assert_true(points_coincide(a, b, tol))
  let c = @core.Point2D::new(1.1, 2.0)
  assert_false(points_coincide(a, c, tol))
}

///|
test "orient_with_tol" {
  let tol = ToleranceCtx::loose()
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(orient_with_tol(a, b, c, tol), 1)
  assert_eq(orient_with_tol(a, c, b, tol), -1)
  let d = @core.Point2D::new(2.0, 0.0)
  assert_eq(orient_with_tol(a, b, d, tol), 0)
}

///|
test "is_degenerate_triangle" {
  let tol = ToleranceCtx::loose()
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_true(is_degenerate_triangle(a, b, c, tol))
  let d = @core.Point2D::new(0.0, 1.0)
  assert_false(is_degenerate_triangle(a, b, d, tol))
}

///|
test "vectors_parallel" {
  let tol = ToleranceCtx::loose()
  assert_true(vectors_parallel(1.0, 0.0, 2.0, 0.0, tol))
  assert_true(vectors_parallel(1.0, 1.0, 2.0, 2.0, tol))
  assert_false(vectors_parallel(1.0, 0.0, 0.0, 1.0, tol))
}

///|
test "snap_to_zero" {
  let tol = ToleranceCtx::loose()
  assert_eq(snap_to_zero(0.0000001, tol), 0.0)
  assert_eq(snap_to_zero(0.1, tol), 0.1)
}
