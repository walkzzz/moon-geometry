///| Very small coordinates | 极小坐标
test "stability: very small coordinates" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0e-10, 0.0),
    @core.Point2D::new(1.0e-10, 1.0e-10),
    @core.Point2D::new(0.0, 1.0e-10),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(area >= 0.0)
  assert_true(area < 1.0e-19)
}


///| Very large coordinates | 极大坐标
test "stability: very large coordinates" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0e10, 0.0),
    @core.Point2D::new(1.0e10, 1.0e10),
    @core.Point2D::new(0.0, 1.0e10),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(area > 0.0)
}


///| Near-zero distance | 近零距离
test "stability: near zero distance" {
  let a = @core.Point2D::new(1.0, 1.0)
  let b = @core.Point2D::new(1.0 + 1.0e-15, 1.0 + 1.0e-15)
  let d = a.dist(b)
  assert_true(d >= 0.0)
  assert_true(d < 1.0e-14)
}


///| Rotation by 0 is identity | 零角度旋转为恒等
test "stability: rotation by zero" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_r = @transform.rotate(p, 0.0)
  assert_true(approx_eq(p.x(), p_r.x()))
  assert_true(approx_eq(p.y(), p_r.y()))
}


///| Rotation by 2π is identity | 2π 旋转为恒等
test "stability: rotation by 2pi" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_r = @transform.rotate(p, 2.0 * @math.PI)
  assert_true(@core.approx_eq(p.x(), p_r.x(), 1.0e-8))
  assert_true(@core.approx_eq(p.y(), p_r.y(), 1.0e-8))
}


///| Scale by 0 collapses to origin | 零缩放坍缩到原点
test "stability: scale by zero" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_s = @transform.scale(p, 0.0, 0.0)
  assert_true(approx_eq(p_s.x(), 0.0))
  assert_true(approx_eq(p_s.y(), 0.0))
}


///| Translation by 0 is identity | 零平移为恒等
test "stability: translation by zero" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_t = @transform.translate(p, 0.0, 0.0)
  assert_true(approx_eq(p.x(), p_t.x()))
  assert_true(approx_eq(p.y(), p_t.y()))
}

// ============================================================
// 3. AI-Driven Random Property Verification | AI 驱动随机属性验证
// ============================================================
