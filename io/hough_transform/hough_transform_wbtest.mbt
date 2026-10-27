///|
test "hough_lines - basic horizontal line" {
  let pts = [
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(4.0, 5.0),
  ]
  let lines = hough_lines(pts, 3, 90)
  assert_true(lines.length() > 0)
}

///|
test "hough_lines - vertical line" {
  let pts = [
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let lines = hough_lines(pts, 3, 90)
  assert_true(lines.length() > 0)
}

///|
test "hough_lines - empty input" {
  let pts : Array[@core.Point2D] = []
  let lines = hough_lines(pts, 1, 90)
  assert_eq(lines.length(), 0)
}

///|
test "hough_circles - basic circle" {
  let pts : Array[@core.Point2D] = []
  let r = 5.0
  for i in 0..<36 {
    let theta = i.to_double() * 6.283185307179586 / 36.0
    pts.push(@core.Point2D::new(r * @math.cos(theta), r * @math.sin(theta)))
  }
  let circles = hough_circles(pts, 5.0, 5, 50)
  assert_true(circles.length() > 0)
}

///|
test "hough_accumulator - basic" {
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let acc = hough_accumulator(pts, 90, 180)
  assert_eq(acc.length(), 90)
  assert_eq(acc[0].length(), 180)
}

///|
test "hough_peaks - basic" {
  let acc : Array[Array[Int32]] = [
    [0, 0, 0, 0, 0],
    [0, 0, 5, 0, 0],
    [0, 0, 0, 0, 0],
  ]
  let peaks = hough_peaks(acc, 3, 3)
  assert_true(peaks.length() > 0)
  let (_, _, v) = peaks[0]
  assert_eq(v, 5)
}

///|
test "hough_line_to_points - basic" {
  let (p1, p2) = hough_line_to_points(0.0, 3.0, 10.0)
  assert_true((p1.x() - p2.x()).abs() < 0.001)
  assert_true((p1.y() + p2.y()).abs() < 0.001)
}

///|
test "hough_lines - single point" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  let lines = hough_lines(pts, 1, 90)
  assert_eq(lines.length(), 0)
}

///|
test "hough_circles - too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let circles = hough_circles(pts, 5.0, 1, 50)
  assert_eq(circles.length(), 0)
}

///|
test "hough_circles - zero radius" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let circles = hough_circles(pts, 0.0, 1, 50)
  assert_eq(circles.length(), 0)
}

///|
test "hough_circles - negative radius" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let circles = hough_circles(pts, -5.0, 1, 50)
  assert_eq(circles.length(), 0)
}

///|
test "hough_circles - scattered points" {
  let pts = [
    @core.Point2D::new(-3.0, -3.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(-3.0, 3.0),
    @core.Point2D::new(3.0, -3.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let circles = hough_circles(pts, 2.0, 1, 20)
  assert_true(circles.length() >= 0)
}

///|
test "hough_peaks - empty accumulator" {
  let acc : Array[Array[Int32]] = []
  let peaks = hough_peaks(acc, 1, 3)
  assert_eq(peaks.length(), 0)
}

///|
test "hough_peaks - below threshold" {
  let acc : Array[Array[Int32]] = [[1, 1], [1, 1]]
  let peaks = hough_peaks(acc, 5, 3)
  assert_eq(peaks.length(), 0)
}

///|
test "hough_peaks - non max suppression" {
  let acc : Array[Array[Int32]] = [
    [0, 0, 0, 0, 0],
    [0, 3, 5, 3, 0],
    [0, 0, 0, 0, 0],
  ]
  let peaks = hough_peaks(acc, 2, 3)
  assert_eq(peaks.length(), 1)
  let (_, _, v) = peaks[0]
  assert_eq(v, 5)
}

///|
test "hough_peaks - multiple peaks" {
  let acc : Array[Array[Int32]] = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 5, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 4, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ]
  let peaks = hough_peaks(acc, 2, 3)
  assert_eq(peaks.length(), 2)
}

///|
test "hough_peaks - edge window" {
  let acc : Array[Array[Int32]] = [[5, 0, 0], [0, 0, 0], [0, 0, 4]]
  let peaks = hough_peaks(acc, 2, 3)
  assert_eq(peaks.length(), 2)
}

///|
test "hough_line_to_points - vertical" {
  let (p1, p2) = hough_line_to_points(1.5707963267948966, 0.0, 10.0)
  assert_true((p1.x() + p2.x()).abs() < 0.001)
  assert_true((p1.y() - p2.y()).abs() < 0.001)
  assert_true((p1.x() - p2.x()).abs() > 9.0)
}

///|
test "hough_accumulator - empty points" {
  let pts : Array[@core.Point2D] = []
  let acc = hough_accumulator(pts, 10, 20)
  assert_eq(acc.length(), 10)
  assert_eq(acc[0].length(), 20)
}
