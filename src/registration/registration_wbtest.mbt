test "centroid_3d basic" {
  let pts = [(0.0, 0.0, 0.0), (2.0, 2.0, 2.0)]
  let (cx, cy, cz) = centroid_3d(pts)
  assert_true((cx - 1.0).abs() < 0.001)
  assert_true((cy - 1.0).abs() < 0.001)
  assert_true((cz - 1.0).abs() < 0.001)
}

test "translate_pts basic" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 1.0, 1.0)]
  let translated = translate_pts(pts, 1.0, 2.0, 3.0)
  let (x, y, z) = translated[0]
  assert_true((x - 1.0).abs() < 0.001)
  assert_true((y - 2.0).abs() < 0.001)
  assert_true((z - 3.0).abs() < 0.001)
}

test "icp basic" {
  let target = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let source = [(1.0, 1.0, 0.0), (2.0, 1.0, 0.0), (1.0, 2.0, 0.0)]
  let (aligned, _) = icp(source, target, 50)
  let err = rms_error(aligned, target)
  assert_true(err < 0.1)
}

test "rms_error basic" {
  let a = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)]
  let b = [(0.0, 0.0, 0.0), (0.0, 0.0, 0.0)]
  let err = rms_error(a, b)
  assert_true((err - 0.7071).abs() < 0.01)
}