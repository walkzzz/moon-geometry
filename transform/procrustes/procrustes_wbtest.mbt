test "procrustes identical" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let result = procrustes(pts, pts)
  assert_true(result.error < 0.001)
  assert_true((result.scale - 1.0).abs() < 0.001)
}

test "procrustes translation" {
  let src = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let tgt = [
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(5.0, 4.0),
  ]
  let result = procrustes(src, tgt)
  assert_true(result.error < 0.001)
  assert_true((result.tx - 5.0).abs() < 0.001)
  assert_true((result.ty - 3.0).abs() < 0.001)
}

test "procrustes rotation" {
  let src = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let angle = 0.5
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  let tgt : Array[@core.Point2D] = []
  for p in src {
    tgt.push(@core.Point2D::new(c * p.x() - s * p.y(), s * p.x() + c * p.y()))
  }
  let result = procrustes(src, tgt)
  assert_true(result.error < 0.01)
  assert_true((result.rotation - angle).abs() < 0.01)
}

test "procrustes scale" {
  let src = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let tgt : Array[@core.Point2D] = []
  for p in src {
    tgt.push(@core.Point2D::new(3.0 * p.x(), 3.0 * p.y()))
  }
  let result = procrustes(src, tgt)
  assert_true(result.error < 0.01)
  assert_true((result.scale - 3.0).abs() < 0.01)
}

test "procrustes_apply basic" {
  let src = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let result = ProcrustesResult::new(0.0, 5.0, 3.0, 1.0, 0.0)
  let applied = procrustes_apply(src, result)
  assert_true((applied[0].x() - 5.0).abs() < 0.001)
  assert_true((applied[0].y() - 3.0).abs() < 0.001)
  assert_true((applied[1].x() - 6.0).abs() < 0.001)
}

test "procrustes_error identical" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let err = procrustes_error(pts, pts)
  assert_true(err < 0.001)
}

test "procrustes_error positive" {
  let src = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let tgt = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 0.5),
  ]
  let err = procrustes_error(src, tgt)
  assert_true(err > 0.0)
}

test "procrustes empty" {
  let result = procrustes([], [])
  assert_true(result.error == 0.0)
}

test "procrustes_analyze basic" {
  let shape1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let shape2 = [
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(5.0, 4.0),
  ]
  let aligned = procrustes_analyze([shape1, shape2], 5)
  assert_true(aligned.length() == 2)
}
test "procrustes_result_new accessors" {
  let r = ProcrustesResult::new(0.5, 1.0, 2.0, 3.0, 0.1)
  assert_true((r.rotation() - 0.5).abs() < 0.0001)
  assert_true((r.tx() - 1.0).abs() < 0.0001)
  assert_true((r.ty() - 2.0).abs() < 0.0001)
  assert_true((r.scale() - 3.0).abs() < 0.0001)
  assert_true((r.error() - 0.1).abs() < 0.0001)
}

test "procrustes mismatched lengths" {
  let src = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let tgt = [@core.Point2D::new(0.0, 0.0)]
  let result = procrustes(src, tgt)
  assert_true(result.error == 0.0)
  assert_true(result.scale == 1.0)
}

test "procrustes_analyze empty" {
  let aligned = procrustes_analyze([], 3)
  assert_true(aligned.length() == 0)
}

test "procrustes_analyze single shape" {
  let shape = [
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(2.0, 5.0),
  ]
  let aligned = procrustes_analyze([shape], 2)
  assert_true(aligned.length() == 1)
  assert_true(aligned[0].length() == 3)
}

test "procrustes_apply empty" {
  let result = ProcrustesResult::new(0.0, 0.0, 0.0, 1.0, 0.0)
  let applied = procrustes_apply([], result)
  assert_true(applied.length() == 0)
}

test "procrustes_apply with rotation" {
  let src = [@core.Point2D::new(1.0, 0.0)]
  let result = ProcrustesResult::new(1.5707963267948966, 0.0, 0.0, 1.0, 0.0)
  let applied = procrustes_apply(src, result)
  assert_true(applied[0].x().abs() < 0.001)
  assert_true((applied[0].y() - 1.0).abs() < 0.001)
}

test "procrustes_apply with scale" {
  let src = [@core.Point2D::new(2.0, 3.0)]
  let result = ProcrustesResult::new(0.0, 1.0, 1.0, 2.0, 0.0)
  let applied = procrustes_apply(src, result)
  assert_true((applied[0].x() - 5.0).abs() < 0.0001)
  assert_true((applied[0].y() - 7.0).abs() < 0.0001)
}

test "procrustes_error mismatched" {
  let src = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let tgt = [@core.Point2D::new(0.0, 0.0)]
  let err = procrustes_error(src, tgt)
  assert_true(err == 0.0)
}

test "procrustes degenerate src" {
  let src = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let tgt = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let result = procrustes(src, tgt)
  assert_true(result.scale == 1.0)
  assert_true(result.error < 0.001)
}