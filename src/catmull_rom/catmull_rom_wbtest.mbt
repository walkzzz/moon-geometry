test "catmull_rom_eval_endpoints" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(1.0, 2.0)
  let p2 = @core.Point2D::new(3.0, 3.0)
  let p3 = @core.Point2D::new(4.0, 0.0)
  let at0 = catmull_rom_eval(p0, p1, p2, p3, 0.0)
  assert_true((at0.x() - 1.0).abs() < 0.001)
  assert_true((at0.y() - 2.0).abs() < 0.001)
  let at1 = catmull_rom_eval(p0, p1, p2, p3, 1.0)
  assert_true((at1.x() - 3.0).abs() < 0.001)
  assert_true((at1.y() - 3.0).abs() < 0.001)
}

test "catmull_rom_eval_midpoint" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(1.0, 0.0)
  let p2 = @core.Point2D::new(2.0, 0.0)
  let p3 = @core.Point2D::new(3.0, 0.0)
  let mid = catmull_rom_eval(p0, p1, p2, p3, 0.5)
  assert_true((mid.y() - 0.0).abs() < 0.001)
}

test "catmull_rom_points" {
  let cps = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let pts = catmull_rom_points(cps, 10)
  assert_true(pts.length() > 0)
}

test "catmull_rom_derivative" {
  let p0 = @core.Point2D::new(0.0, 0.0)
  let p1 = @core.Point2D::new(1.0, 0.0)
  let p2 = @core.Point2D::new(2.0, 0.0)
  let p3 = @core.Point2D::new(3.0, 0.0)
  let d = catmull_rom_derivative(p0, p1, p2, p3, 0.5)
  assert_true((d.y() - 0.0).abs() < 0.001)
}

test "catmull_rom_points_short" {
  let cps = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let pts = catmull_rom_points(cps, 10)
  assert_true(pts.length() == 0)
}