///|
test "translate basic" {
  let p = @core.Point2D::new(1.0, 2.0)
  let q = translate(p, 3.0, 4.0)
  assert_true(@core.approx_eq(q.x, 4.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 6.0, 0.000000001))
}

///|
test "translate zero" {
  let p = @core.Point2D::new(5.0, 7.0)
  let q = translate(p, 0.0, 0.0)
  assert_true(@core.approx_eq(q.x, 5.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 7.0, 0.000000001))
}

///|
test "translate_points array" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let result = translate_points(pts, 2.0, 3.0)
  assert_true(@core.approx_eq(result[0].x, 2.0, 0.000000001))
  assert_true(@core.approx_eq(result[1].y, 4.0, 0.000000001))
}

///|
test "rotate 90 degrees" {
  let p = @core.Point2D::new(1.0, 0.0)
  let q = rotate(p, 1.5707963267948966)
  assert_true(@core.approx_eq(q.x, 0.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 1.0, 0.000000001))
}

///|
test "rotate 180 degrees" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = rotate(p, 3.14159265358979)
  assert_true(@core.approx_eq(q.x, -3.0, 0.0001))
  assert_true(@core.approx_eq(q.y, -4.0, 0.0001))
}

///|
test "rotate zero angle" {
  let p = @core.Point2D::new(2.0, 3.0)
  let q = rotate(p, 0.0)
  assert_true(@core.approx_eq(q.x, 2.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 3.0, 0.000000001))
}

///|
test "rotate_around center" {
  let p = @core.Point2D::new(2.0, 1.0)
  let center = @core.Point2D::new(1.0, 1.0)
  let q = rotate_around(p, center, 1.5707963267948966)
  assert_true(@core.approx_eq(q.x, 1.0, 0.0001))
  assert_true(@core.approx_eq(q.y, 2.0, 0.0001))
}

///|
test "scale basic" {
  let p = @core.Point2D::new(2.0, 3.0)
  let q = scale(p, 2.0, 0.5)
  assert_true(@core.approx_eq(q.x, 4.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 1.5, 0.000000001))
}

///|
test "scale zero" {
  let p = @core.Point2D::new(5.0, 7.0)
  let q = scale(p, 0.0, 0.0)
  assert_true(@core.approx_eq(q.x, 0.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 0.0, 0.000000001))
}

///|
test "scale_around center" {
  let p = @core.Point2D::new(3.0, 3.0)
  let center = @core.Point2D::new(1.0, 1.0)
  let q = scale_around(p, center, 2.0, 2.0)
  assert_true(@core.approx_eq(q.x, 5.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 5.0, 0.000000001))
}

///|
test "affine_transform identity" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = affine_transform(p, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0)
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 4.0, 0.000000001))
}

///|
test "affine_transform translation" {
  let p = @core.Point2D::new(1.0, 2.0)
  let q = affine_transform(p, 1.0, 0.0, 5.0, 0.0, 1.0, 3.0)
  assert_true(@core.approx_eq(q.x, 6.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 5.0, 0.000000001))
}

///|
test "mirror_x basic" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = mirror_x(p)
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, -4.0, 0.000000001))
}

///|
test "mirror_y basic" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = mirror_y(p)
  assert_true(@core.approx_eq(q.x, -3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 4.0, 0.000000001))
}

///|
test "mirror_origin basic" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = mirror_origin(p)
  assert_true(@core.approx_eq(q.x, -3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, -4.0, 0.000000001))
}

///|
test "mirror_line x-axis" {
  let p = @core.Point2D::new(3.0, 4.0)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  let q = mirror_line(p, line)
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, -4.0, 0.000000001))
}

///|
test "mirror_line y-axis" {
  let p = @core.Point2D::new(3.0, 4.0)
  let line = @core.Line::new(1.0, 0.0, 0.0)
  let q = mirror_line(p, line)
  assert_true(@core.approx_eq(q.x, -3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 4.0, 0.000000001))
}

///|
test "mirror_line point on line" {
  let p = @core.Point2D::new(3.0, 0.0)
  let line = @core.Line::new(0.0, 1.0, 0.0)
  let q = mirror_line(p, line)
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 0.0, 0.000000001))
}

///|
test "shear basic" {
  let p = @core.Point2D::new(2.0, 3.0)
  let q = shear(p, 1.0, 0.0)
  assert_true(@core.approx_eq(q.x, 5.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 3.0, 0.000000001))
}

///|
test "shear zero" {
  let p = @core.Point2D::new(2.0, 3.0)
  let q = shear(p, 0.0, 0.0)
  assert_true(@core.approx_eq(q.x, 2.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 3.0, 0.000000001))
}

///|
test "rotate_points array" {
  let pts = [@core.Point2D::new(1.0, 0.0), @core.Point2D::new(0.0, 1.0)]
  let center = @core.Point2D::new(0.0, 0.0)
  let result = rotate_points(pts, center, 0.0)
  assert_true(@core.approx_eq(result[0].x, 1.0, 0.000000001))
  assert_true(@core.approx_eq(result[1].y, 1.0, 0.000000001))
}

///|
test "affine_transform_points array" {
  let pts = [@core.Point2D::new(1.0, 2.0), @core.Point2D::new(3.0, 4.0)]
  let result = affine_transform_points(pts, 2.0, 0.0, 0.0, 0.0, 2.0, 0.0)
  assert_true(@core.approx_eq(result[0].x, 2.0, 0.000000001))
  assert_true(@core.approx_eq(result[1].y, 8.0, 0.000000001))
}

///|
test "double mirror returns original" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = mirror_x(mirror_x(p))
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 4.0, 0.000000001))
}

///|
test "rotate then inverse returns original" {
  let p = @core.Point2D::new(3.0, 4.0)
  let angle = 0.5
  let q = rotate(rotate(p, angle), -angle)
  assert_true(@core.approx_eq(q.x, 3.0, 0.0001))
  assert_true(@core.approx_eq(q.y, 4.0, 0.0001))
}
///|
test "scale by zero" {
  let p = @core.Point2D::new(5.0, 7.0)
  let q = scale(p, 0.0, 0.0)
  assert_true(@core.approx_eq(q.x, 0.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 0.0, 0.000000001))
}

///|
test "affine_transform identity extra" {
  let p = @core.Point2D::new(3.0, 7.0)
  let q = affine_transform(p, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0)
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 7.0, 0.000000001))
}

///|
test "mirror_y double returns original" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = mirror_y(mirror_y(p))
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 4.0, 0.000000001))
}

///|
test "shear zero is identity" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = shear(p, 0.0, 0.0)
  assert_true(@core.approx_eq(q.x, 3.0, 0.000000001))
  assert_true(@core.approx_eq(q.y, 4.0, 0.000000001))
}