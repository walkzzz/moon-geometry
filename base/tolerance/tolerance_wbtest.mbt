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
///|
test "points_coincide boundary: dist exactly equals tol" {
  let tol = ToleranceCtx::custom(1.0)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  assert_true(points_coincide(a, b, tol))
  let c = @core.Point2D::new(1.0001, 0.0)
  assert_false(points_coincide(a, c, tol))
}

///|
test "orient_with_tol boundary: area exactly equals tol" {
  let tol = ToleranceCtx::custom(1.0)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  assert_eq(orient_with_tol(a, b, c, tol), 0)
}
///|
test "ToleranceCtx::strict" {
  let tol = ToleranceCtx::strict()
  assert_true(tol.dist_tol < 0.000000001)
  assert_true(tol.angle_tol > 0.0)
}

///|
test "ToleranceCtx::loose" {
  let tol = ToleranceCtx::loose()
  assert_true(tol.dist_tol > 0.0000001)
  assert_true(tol.area_tol > 0.0)
}

///|
test "ToleranceCtx::custom" {
  let tol = ToleranceCtx::custom(0.01)
  assert_true((tol.dist_tol - 0.01).abs() < 0.000001)
  assert_true((tol.area_tol - 0.0001).abs() < 0.000001)
  assert_true((tol.rel_tol - 0.01).abs() < 0.000001)
}

///|
test "points_collinear" {
  let tol = ToleranceCtx::loose()
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  assert_true(points_collinear(a, b, c, tol))
  let d = @core.Point2D::new(0.0, 1.0)
  assert_false(points_collinear(a, b, d, tol))
}

///|
test "segments_overlap" {
  let tol = ToleranceCtx::loose()
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(2.0, 0.0)
  let b1 = @core.Point2D::new(1.0, 0.0)
  let b2 = @core.Point2D::new(3.0, 0.0)
  assert_true(segments_overlap(a1, a2, b1, b2, tol))
  let c1 = @core.Point2D::new(0.0, 1.0)
  let c2 = @core.Point2D::new(2.0, 1.0)
  assert_false(segments_overlap(a1, a2, c1, c2, tol))
}

///|
test "segments_overlap degenerate first segment" {
  let tol = ToleranceCtx::loose()
  let a1 = @core.Point2D::new(1.0, 0.0)
  let a2 = @core.Point2D::new(1.0, 0.0)
  let b1 = @core.Point2D::new(1.0, 0.0)
  let b2 = @core.Point2D::new(2.0, 0.0)
  assert_true(segments_overlap(a1, a2, b1, b2, tol))
}

///|
test "angles_equal" {
  let tol = ToleranceCtx::loose()
  assert_true(angles_equal(1.0, 1.0, tol))
  assert_false(angles_equal(0.0, 1.0, tol))
  assert_true(angles_equal(6.283185307179586, 0.0, tol))
}

///|
test "vectors_perpendicular" {
  let tol = ToleranceCtx::loose()
  assert_true(vectors_perpendicular(1.0, 0.0, 0.0, 1.0, tol))
  assert_false(vectors_perpendicular(1.0, 0.0, 1.0, 0.0, tol))
  assert_false(vectors_perpendicular(0.0, 0.0, 1.0, 0.0, tol))
}

///|
test "snap_point" {
  let tol = ToleranceCtx::loose()
  let p = @core.Point2D::new(1.0000001, 2.0000001)
  let ref_pt = @core.Point2D::new(1.0, 2.0)
  let snapped = snap_point(p, ref_pt, tol)
  assert_true(snapped.x() == 1.0)
  let q = @core.Point2D::new(5.0, 5.0)
  let not_snapped = snap_point(q, ref_pt, tol)
  assert_true(not_snapped.x() == 5.0)
}
