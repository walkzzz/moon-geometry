///|
test "morph basic" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pts2 = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ]
  let mid = morph(pts1, pts2, 0.5)
  assert_eq(mid.length(), 4)
  let dx = mid[0].x() - 0.5
  assert_true(dx.abs() < 0.001)
}

///|
test "morph_sequence basic" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pts2 = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ]
  let seq = morph_sequence(pts1, pts2, 4)
  assert_eq(seq.length(), 5)
}

///|
test "best_alignment basic" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pts2 = [
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let shift = best_alignment(pts1, pts2)
  assert_true(shift >= 0 && shift < 4)
}

///|
test "morph_aligned basic" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let pts2 = [
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let result = morph_aligned(pts1, pts2, 0.5)
  assert_eq(result.length(), 4)
}

///|
test "morph mismatched sizes" {
  let pts1 = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let pts2 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let result = morph(pts1, pts2, 0.5)
  assert_eq(result.length(), 0)
}
