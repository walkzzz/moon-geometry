test "detect_ground_height" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.1), @core.Point3D::new(1.0, 0.0, 2.0)]
  let labels = detect_ground_height(pts, 1.0)
  assert_true(labels[0])
  assert_false(labels[1])
}

test "ground_point_count" {
  assert_eq(ground_point_count([true, false, true, true]), 3)
}

test "ground_ratio" {
  let r = ground_ratio([true, false, true])
  assert_true((r - 0.666667).abs() < 0.01)
}
