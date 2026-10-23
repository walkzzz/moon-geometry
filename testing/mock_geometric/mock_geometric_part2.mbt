///| Generate points on a circle | 生成圆上点
pub fn mock_circle_points(cx : Double, cy : Double, radius : Double, n : Int) -> Array[@core.Point2D] {
  let result = Array::make(n, @core.Point2D::new(0.0, 0.0))
  for i in 0..<n {
    let angle = 2.0 * @math.PI * i.to_double() / n.to_double()
    result[i] = @core.Point2D::new(cx + radius * @math.cos(angle), cy + radius * @math.sin(angle))
  }
  result
}


///| Generate regular polygon vertices | 生成正多边形顶点
pub fn mock_regular_polygon(cx : Double, cy : Double, radius : Double, n : Int) -> @core.Polygon {
  let verts = mock_circle_points(cx, cy, radius, n)
  @core.Polygon::new(verts)
}


///| Generate collinear points | 生成共线点
pub fn mock_collinear_points(n : Int, dx : Double, dy : Double) -> Array[@core.Point2D] {
  let result = Array::make(n, @core.Point2D::new(0.0, 0.0))
  for i in 0..<n {
    let t = i.to_double()
    result[i] = @core.Point2D::new(t * dx, t * dy)
  }
  result
}


///| Generate square polygon | 生成正方形多边形
pub fn mock_square(side : Double) -> @core.Polygon {
  @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(side, 0.0),
    @core.Point2D::new(side, side),
    @core.Point2D::new(0.0, side),
  ])
}


///| Generate triangle polygon | 生成三角形多边形
pub fn mock_triangle(base : Double, height : Double) -> @core.Polygon {
  @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(base, 0.0),
    @core.Point2D::new(0.0, height),
  ])
}

// ============================================================
// 2. Fake Random Generator | 伪随机数生成器
// ============================================================
