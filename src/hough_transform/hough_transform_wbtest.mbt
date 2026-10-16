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

test "hough_lines - empty input" {
  let pts : Array[@core.Point2D] = []
  let lines = hough_lines(pts, 1, 90)
  assert_eq(lines.length(), 0)
}

test "hough_circles - basic circle" {
  let pts : Array[@core.Point2D] = []
  let r = 5.0
  for i in 0..<36 {
    let theta = (i.to_double()) * 6.283185307179586 / 36.0
    pts.push(@core.Point2D::new(r * @math.cos(theta), r * @math.sin(theta)))
  }
  let circles = hough_circles(pts, 5.0, 5, 50)
  assert_true(circles.length() > 0)
}

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

test "hough_peaks - basic" {
  let acc : Array[Array[Int]] = [
    [0, 0, 0, 0, 0],
    [0, 0, 5, 0, 0],
    [0, 0, 0, 0, 0],
  ]
  let peaks = hough_peaks(acc, 3, 3)
  assert_true(peaks.length() > 0)
  let (_, _, v) = peaks[0]
  assert_eq(v, 5)
}

test "hough_line_to_points - basic" {
  let (p1, p2) = hough_line_to_points(0.0, 3.0, 10.0)
  assert_true((p1.x() - p2.x()).abs() < 0.001)
  assert_true((p1.y() + p2.y()).abs() < 0.001)
}