test "box counting dimension line" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<100 {
    let x = i.to_double() / 100.0
    pts.push(@core.Point2D::new(x, x))
  }
  let scales = geometric_scales(0.01, 0.5, 10)
  let dim = box_counting_dimension(pts, scales)
  assert_true(dim > 0.8)
  assert_true(dim < 1.3)
}

test "box counting dimension area" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<50 {
    for j in 0..<50 {
      pts.push(@core.Point2D::new(i.to_double() / 50.0, j.to_double() / 50.0))
    }
  }
  let scales = geometric_scales(0.02, 0.5, 8)
  let dim = box_counting_dimension(pts, scales)
  assert_true(dim > 1.5)
}

test "correlation dimension line" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<50 {
    let x = i.to_double() / 50.0
    pts.push(@core.Point2D::new(x, x))
  }
  let radii = geometric_scales(0.01, 0.5, 10)
  let dim = correlation_dimension(pts, radii)
  assert_true(dim > 0.7)
  assert_true(dim < 1.3)
}

test "linear fit slope" {
  let xs = [0.0, 1.0, 2.0, 3.0]
  let ys = [0.0, 2.0, 4.0, 6.0]
  let slope = linear_fit_slope(xs, ys)
  assert_true((slope - 2.0).abs() < 0.000000001)
}

test "linear fit slope flat" {
  let xs = [0.0, 1.0, 2.0, 3.0]
  let ys = [5.0, 5.0, 5.0, 5.0]
  let slope = linear_fit_slope(xs, ys)
  assert_true(slope.abs() < 0.000000001)
}

test "geometric scales" {
  let scales = geometric_scales(0.01, 1.0, 5)
  assert_eq(scales.length(), 5)
  assert_true((scales[0] - 0.01).abs() < 0.000000001)
  assert_true((scales[4] - 1.0).abs() < 0.000000001)
}

test "box count single scale" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.5, 0.5),
    @core.Point2D::new(1.0, 1.0),
  ]
  let count = box_count(pts, 0.3)
  assert_true(count >= 2)
}

test "information dimension line" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<100 {
    let x = i.to_double() / 100.0
    pts.push(@core.Point2D::new(x, x))
  }
  let scales = geometric_scales(0.01, 0.5, 10)
  let dim = information_dimension(pts, scales)
  assert_true(dim > 0.7)
  assert_true(dim < 1.3)
}

test "box counting empty points" {
  let pts : Array[@core.Point2D] = []
  let scales = [0.1, 0.2]
  let dim = box_counting_dimension(pts, scales)
  assert_true(dim.abs() < 0.000000001)
}