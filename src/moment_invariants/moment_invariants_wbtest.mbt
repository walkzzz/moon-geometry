test "raw_moment basic" {
  let pts = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
  ]
  let m00 = raw_moment(pts, 0, 0)
  assert_true((m00 - 3.0).abs() < 0.0001)
}

test "raw_moment first order" {
  let pts = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let m10 = raw_moment(pts, 1, 0)
  let m01 = raw_moment(pts, 0, 1)
  assert_true((m10 - 4.0).abs() < 0.0001)
  assert_true((m01 - 6.0).abs() < 0.0001)
}

test "centroid basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let (c, _) = centroid(pts)
  assert_true((c.x() - 1.0).abs() < 0.0001)
  assert_true((c.y() - 1.0).abs() < 0.0001)
}

test "central_moment zero first order" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let mu10 = central_moment(pts, 1, 0)
  let mu01 = central_moment(pts, 0, 1)
  assert_true(mu10.abs() < 0.0001)
  assert_true(mu01.abs() < 0.0001)
}

test "hu_moments count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let hu = hu_moments(pts)
  assert_true(hu.length() == 7)
}

test "hu_moments translation invariant" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let pts2 = [
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(6.0, 4.0),
    @core.Point2D::new(5.0, 4.0),
  ]
  let hu1 = hu_moments(pts1)
  let hu2 = hu_moments(pts2)
  for i in 0..<7 {
    assert_true((hu1[i] - hu2[i]).abs() < 0.001)
  }
}

test "zernike_moment basic" {
  let pts = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let (re, im) = zernike_moment(pts, 2, 0)
  assert_true(re.abs() < 10.0)
  assert_true(im.abs() < 0.001)
}

test "zernike_magnitude rotation invariant" {
  let pts1 = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let pts2 = [
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let mag1 = zernike_magnitude(pts1, 2, 2)
  let mag2 = zernike_magnitude(pts2, 2, 2)
  assert_true((mag1 - mag2).abs() < 0.001)
}

test "normalized_moment basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let n20 = normalized_moment(pts, 2, 0)
  let n02 = normalized_moment(pts, 0, 2)
  assert_true((n20 - n02).abs() < 0.001)
}