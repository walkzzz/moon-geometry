test "fourier_descriptors basic" {
  let pts = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let fd = fourier_descriptors(pts)
  assert_true(fd.length() >= 4)
}

test "fourier_descriptors empty" {
  let fd = fourier_descriptors([])
  assert_true(fd.length() == 0)
}

test "fourier_descriptors dc component" {
  let pts = [
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(0.0, -2.0),
  ]
  let fd = fourier_descriptors(pts)
  let (re, im) = fd[0]
  assert_true(re.abs() < 0.001)
  assert_true(im.abs() < 0.001)
}

test "fourier_invariant basic" {
  let pts = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let inv = fourier_invariant(pts)
  assert_true(inv.length() >= 3)
  assert_true((inv[0] - 1.0).abs() < 0.001)
}

test "fourier_invariant scale" {
  let pts1 = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let pts2 = [
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(0.0, 3.0),
    @core.Point2D::new(-3.0, 0.0),
    @core.Point2D::new(0.0, -3.0),
  ]
  let inv1 = fourier_invariant(pts1)
  let inv2 = fourier_invariant(pts2)
  let m = if inv1.length() < inv2.length() { inv1.length() } else { inv2.length() }
  for i in 0..<m {
    assert_true((inv1[i] - inv2[i]).abs() < 0.01)
  }
}

test "fourier_reconstruct basic" {
  let pts = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let fd = fourier_descriptors(pts)
  let rec = fourier_reconstruct(fd, 4)
  assert_true(rec.length() == 4)
  for i in 0..<4 {
    assert_true((rec[i].x() - pts[i].x()).abs() < 0.01)
    assert_true((rec[i].y() - pts[i].y()).abs() < 0.01)
  }
}

test "fourier_truncate preserves length" {
  let fd = [(1.0, 0.0), (0.5, 0.5), (0.3, 0.2), (0.1, 0.1)]
  let trunc = fourier_truncate(fd, 2)
  assert_true(trunc.length() == 4)
  let (re, _) = trunc[2]
  assert_true(re.abs() < 0.0001)
}

test "fourier_descriptors translation invariance" {
  let pts1 = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let pts2 = [
    @core.Point2D::new(6.0, 5.0),
    @core.Point2D::new(5.0, 6.0),
    @core.Point2D::new(4.0, 5.0),
    @core.Point2D::new(5.0, 4.0),
  ]
  let inv1 = fourier_invariant(pts1)
  let inv2 = fourier_invariant(pts2)
  let m = if inv1.length() < inv2.length() { inv1.length() } else { inv2.length() }
  for i in 0..<m {
    assert_true((inv1[i] - inv2[i]).abs() < 0.01)
  }
}

test "fourier_invariant empty" {
  let inv = fourier_invariant([])
  assert_true(inv.length() == 0)
}