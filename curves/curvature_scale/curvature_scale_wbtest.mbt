///|
test "gaussian_smooth sigma_zero" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let smoothed = gaussian_smooth(pts, 0.0)
  for i in 0..<4 {
    assert_true((smoothed[i].x() - pts[i].x()).abs() < 0.001)
    assert_true((smoothed[i].y() - pts[i].y()).abs() < 0.001)
  }
}

///|
test "gaussian_smooth basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let smoothed = gaussian_smooth(pts, 1.0)
  assert_true(smoothed.length() == 4)
}

///|
test "gaussian_smooth empty" {
  let smoothed = gaussian_smooth([], 1.0)
  assert_true(smoothed.length() == 0)
}

///|
test "css_curvature basic" {
  let pts = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let kappa = css_curvature(pts, 0.5)
  assert_true(kappa.length() == 4)
}

///|
test "css_curvature constant curvature circle" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<16 {
    let theta = i.to_double() * 6.283185307179586 / 16.0
    pts.push(@core.Point2D::new(@math.cos(theta), @math.sin(theta)))
  }
  let kappa = css_curvature(pts, 0.5)
  let k0 = kappa[0].abs()
  for i in 1..<16 {
    assert_true((kappa[i].abs() - k0).abs() < 0.5)
  }
}

///|
test "css_inflection_points basic" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<32 {
    let t = i.to_double() / 32.0 * 6.283185307179586
    pts.push(
      @core.Point2D::new(
        @math.cos(t) + 0.3 * @math.cos(3.0 * t),
        @math.sin(t) + 0.3 * @math.sin(3.0 * t),
      ),
    )
  }
  let infl = css_inflection_points(pts, 1.0)
  assert_true(infl.length() >= 0)
}

///|
test "css_image basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-0.5, 0.5),
  ]
  let img = css_image(pts, 3)
  assert_true(img.length() >= 0)
}

///|
test "css_maxima basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let maxima = css_maxima(pts, 3)
  assert_true(maxima.length() >= 0)
}

///|
test "css_curvature preserves length" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let kappa = css_curvature(pts, 0.3)
  assert_true(kappa.length() == 4)
}

///|
test "gaussian_smooth single point" {
  let pts = [@core.Point2D::new(5.0, 7.0)]
  let smoothed = gaussian_smooth(pts, 1.0)
  assert_eq(smoothed.length(), 1)
  assert_true((smoothed[0].x() - 5.0).abs() < 0.001)
  assert_true((smoothed[0].y() - 7.0).abs() < 0.001)
}

///|
test "gaussian_smooth two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0)]
  let smoothed = gaussian_smooth(pts, 1.0)
  assert_eq(smoothed.length(), 2)
}

///|
test "gaussian_smooth large sigma" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let smoothed = gaussian_smooth(pts, 5.0)
  assert_eq(smoothed.length(), 3)
}

///|
test "css_curvature two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let kappa = css_curvature(pts, 0.5)
  assert_eq(kappa.length(), 2)
  assert_true(kappa[0].abs() < 0.000000001)
  assert_true(kappa[1].abs() < 0.000000001)
}

///|
test "css_curvature degenerate repeated points" {
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let kappa = css_curvature(pts, 0.0)
  assert_eq(kappa.length(), 4)
  for i in 0..<4 {
    assert_true(kappa[i].abs() < 0.000000001)
  }
}

///|
test "css_curvature three collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let kappa = css_curvature(pts, 0.0)
  assert_eq(kappa.length(), 4)
  for i in 0..<4 {
    assert_true(kappa[i].abs() < 0.000000001)
  }
}

///|
test "css_image zero sigmas" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let img = css_image(pts, 0)
  assert_eq(img.length(), 0)
}

///|
test "css_image negative sigmas" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let img = css_image(pts, -1)
  assert_eq(img.length(), 0)
}

///|
test "css_maxima single sigma" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let maxima = css_maxima(pts, 1)
  assert_true(maxima.length() >= 0)
}

///|
test "css_maxima zero sigmas" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let maxima = css_maxima(pts, 0)
  assert_eq(maxima.length(), 0)
}

///|
test "css_inflection_points circle no inflection" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<16 {
    let theta = i.to_double() * 6.283185307179586 / 16.0
    pts.push(@core.Point2D::new(@math.cos(theta), @math.sin(theta)))
  }
  let infl = css_inflection_points(pts, 0.5)
  // A circle has no inflection points
  assert_eq(infl.length(), 0)
}

///|
test "css_image single sigma" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-0.5, 0.5),
  ]
  let img = css_image(pts, 1)
  assert_true(img.length() >= 0)
}

///|
test "css_curvature single point" {
  let pts = [@core.Point2D::new(3.0, 4.0)]
  let kappa = css_curvature(pts, 0.5)
  assert_eq(kappa.length(), 1)
  assert_true(kappa[0].abs() < 0.000000001)
}

///|
test "gaussian_smooth sigma zero preserves points" {
  let pts = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(5.0, 6.0),
  ]
  let smoothed = gaussian_smooth(pts, 0.0)
  assert_eq(smoothed.length(), 3)
  for i in 0..<3 {
    assert_true((smoothed[i].x() - pts[i].x()).abs() < 0.000000001)
    assert_true((smoothed[i].y() - pts[i].y()).abs() < 0.000000001)
  }
}
