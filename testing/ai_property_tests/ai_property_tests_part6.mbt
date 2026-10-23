///| Negative coordinates polygon | 负坐标多边形
test "extreme: negative coordinates" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(-5.0, -5.0),
    @core.Point2D::new(-1.0, -5.0),
    @core.Point2D::new(-1.0, -1.0),
    @core.Point2D::new(-5.0, -1.0),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 16.0))
}


///| Mixed sign coordinates | 混合符号坐标
test "extreme: mixed sign coordinates" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(-3.0, -3.0),
    @core.Point2D::new(3.0, -3.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(-3.0, 3.0),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 36.0))
}


///| Thin rectangle (high aspect ratio) | 高纵横比细长矩形
test "extreme: thin rectangle" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1000000.0, 0.0),
    @core.Point2D::new(1000000.0, 0.001),
    @core.Point2D::new(0.0, 0.001),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(area > 0.0)
}


///| Many vertices regular polygon | 多顶点正多边形
test "extreme: many vertex polygon" {
  let pts : Array[@core.Point2D] = []
  let n = 100
  for i in 0..<n {
    let angle = 2.0 * @math.PI * i.to_double() / n.to_double()
    pts.push(@core.Point2D::new(10.0 * @math.cos(angle), 10.0 * @math.sin(angle)))
  }
  let poly = @core.Polygon::new(pts)
  let area = @polygon.polygon_area(poly)
  let expected = 0.5 * n.to_double() * 100.0 * @math.sin(2.0 * @math.PI / n.to_double())
  assert_true(@core.approx_eq(area, expected, 1.0e-3))
}


///| Double reflection is identity | 双重镜像为恒等
test "extreme: double mirror is identity" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_mx = @transform.mirror_x(p)
  let p_mxmx = @transform.mirror_x(p_mx)
  assert_true(approx_eq(p.x(), p_mxmx.x()))
  assert_true(approx_eq(p.y(), p_mxmx.y()))
  let p_my = @transform.mirror_y(p)
  let p_mymy = @transform.mirror_y(p_my)
  assert_true(approx_eq(p.x(), p_mymy.x()))
  assert_true(approx_eq(p.y(), p_mymy.y()))
}


///| Scale then inverse scale is identity | 缩放后逆缩放为恒等
test "extreme: scale inverse" {
  let p = @core.Point2D::new(7.0, 3.0)
  let s = 5.0
  let p_s = @transform.scale(p, s, s)
  let p_restored = @transform.scale(p_s, 1.0 / s, 1.0 / s)
  assert_true(@core.approx_eq(p.x(), p_restored.x(), 1.0e-9))
  assert_true(@core.approx_eq(p.y(), p_restored.y(), 1.0e-9))
}
