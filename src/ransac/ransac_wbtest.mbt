test "ransac_line - perfect line with outliers" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<20 {
    pts.push(@core.Point2D::new((i.to_double()), (i.to_double()) * 2.0 + 1.0))
  }
  pts.push(@core.Point2D::new(50.0, -50.0))
  pts.push(@core.Point2D::new(-30.0, 100.0))
  let result = ransac_line(pts, 100, 0.5)
  assert_true(result.inliers.length() >= 15)
}

test "ransac_line - minimal points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let result = ransac_line(pts, 10, 0.1)
  assert_true(result.inliers.length() >= 2)
}

test "ransac_line - empty input" {
  let pts : Array[@core.Point2D] = []
  let result = ransac_line(pts, 10, 0.1)
  assert_eq(result.inliers.length(), 0)
}

test "ransac_circle - perfect circle with outliers" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<30 {
    let theta = (i.to_double()) * 6.283185307179586 / 30.0
    pts.push(@core.Point2D::new(5.0 * @math.cos(theta) + 10.0,
      5.0 * @math.sin(theta) + 10.0))
  }
  pts.push(@core.Point2D::new(100.0, 100.0))
  pts.push(@core.Point2D::new(-50.0, -50.0))
  let result = ransac_circle(pts, 200, 0.5)
  assert_true(result.inliers.length() >= 20)
}

test "ransac_circle - minimal points" {
  let pts = [
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let result = ransac_circle(pts, 10, 0.5)
  assert_true(result.inliers.length() >= 3)
}

test "ransac_plane - perfect plane with outliers" {
  let pts : Array[@core.Point3D] = []
  for i in 0..<10 {
    for j in 0..<10 {
      let x = (i.to_double())
      let y = (j.to_double())
      let z = 2.0 * x + 3.0 * y + 1.0
      pts.push(@core.Point3D::new(x, y, z))
    }
  }
  pts.push(@core.Point3D::new(100.0, 100.0, -100.0))
  pts.push(@core.Point3D::new(-50.0, -50.0, 500.0))
  let result = ransac_plane(pts, 200, 0.5)
  assert_true(result.inliers.length() >= 80)
}

test "ransac_refit_line - basic" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<10 {
    pts.push(@core.Point2D::new((i.to_double()), (i.to_double()) * 2.0))
  }
  let (a, b) = ransac_refit_line(pts, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
  assert_true((a - 2.0).abs() < 0.001)
  assert_true(b.abs() < 0.001)
}

test "count_line_inliers - basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(10.0, -10.0),
  ]
  let count = count_line_inliers(pts, 1.0, 0.0, 0.01)
  assert_eq(count, 4)
}