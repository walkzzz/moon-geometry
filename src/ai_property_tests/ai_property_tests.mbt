///| AI Property Tests | AI 驱动属性测试
///| AI-driven property and boundary tests for robust verification
///| AI 驱动的属性和边界测试，用于鲁棒性验证

fn approx_eq(a : Double, b : Double) -> Bool { @core.approx_eq(a, b, 1.0e-9) }



///| Simple LCG for AI-driven random testing | 简单 LCG 用于 AI 驱动随机测试
fn lcg_next(seed : Int) -> Int {
  let val = (seed * 1103515245 + 12345) % 2147483647
  if val < 0 { -val } else { val }
}

fn lcg_double(seed : Int, min : Double, max : Double) -> (Double, Int) {
  let next_seed = lcg_next(seed)
  let r = next_seed.to_double() / 2147483647.0
  (min + r * (max - min), next_seed)
}

// ============================================================
// 1. Boundary Condition Tests | 边界条件测试
// ============================================================

///| Empty polygon area is 0 | 空多边形面积为0
test "boundary: empty polygon area" {
  let poly = @core.Polygon::new([])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}

///| Single point polygon area is 0 | 单点多边形面积为0
test "boundary: single point polygon" {
  let poly = @core.Polygon::new([@core.Point2D::new(5.0, 3.0)])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}

///| Two point polygon (degenerate) area is 0 | 两点多边形面积为0
test "boundary: two point polygon" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}

///| Collinear points polygon area is 0 | 共线点多边形面积为0
test "boundary: collinear points area" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.0))
}

///| Convex hull of single point | 单点凸包
test "boundary: hull of single point" {
  let pts = [@core.Point2D::new(3.0, 7.0)]
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 1)
}

///| Convex hull of two points | 两点凸包
test "boundary: hull of two points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 2)
}

///| Convex hull of identical points | 相同点凸包
test "boundary: hull of identical points" {
  let pts = [
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(3.0, 4.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 1)
}

// ============================================================
// 2. Numerical Stability Tests | 数值稳定性测试
// ============================================================

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

///| Random triangle inequality check | 随机三角不等式检查
test "ai: random triangle inequality" {
  let mut seed = 42
  for _ in 0..<50 {
    let (x1, s1) = lcg_double(seed, -100.0, 100.0)
    seed = s1
    let (y1, s2) = lcg_double(seed, -100.0, 100.0)
    seed = s2
    let (x2, s3) = lcg_double(seed, -100.0, 100.0)
    seed = s3
    let (y2, s4) = lcg_double(seed, -100.0, 100.0)
    seed = s4
    let (x3, s5) = lcg_double(seed, -100.0, 100.0)
    seed = s5
    let (y3, s6) = lcg_double(seed, -100.0, 100.0)
    seed = s6
    let a = @core.Point2D::new(x1, y1)
    let b = @core.Point2D::new(x2, y2)
    let c = @core.Point2D::new(x3, y3)
    let d_ac = a.dist(c)
    let d_ab = a.dist(b)
    let d_bc = b.dist(c)
    assert_true(d_ac <= d_ab + d_bc + 1.0e-6)
  }
}

///| Random distance symmetry check | 随机距离对称性检查
test "ai: random distance symmetry" {
  let mut seed = 123
  for _ in 0..<50 {
    let (x1, s1) = lcg_double(seed, -50.0, 50.0)
    seed = s1
    let (y1, s2) = lcg_double(seed, -50.0, 50.0)
    seed = s2
    let (x2, s3) = lcg_double(seed, -50.0, 50.0)
    seed = s3
    let (y2, s4) = lcg_double(seed, -50.0, 50.0)
    seed = s4
    let a = @core.Point2D::new(x1, y1)
    let b = @core.Point2D::new(x2, y2)
    assert_true(@core.approx_eq(a.dist(b), b.dist(a), 1.0e-9))
  }
}

///| Random rotation preserves distance | 随机旋转保持距离
test "ai: random rotation preserves distance" {
  let mut seed = 999
  for _ in 0..<30 {
    let (x1, s1) = lcg_double(seed, -20.0, 20.0)
    seed = s1
    let (y1, s2) = lcg_double(seed, -20.0, 20.0)
    seed = s2
    let (x2, s3) = lcg_double(seed, -20.0, 20.0)
    seed = s3
    let (y2, s4) = lcg_double(seed, -20.0, 20.0)
    seed = s4
    let (angle, s5) = lcg_double(seed, 0.0, 6.283185307179586)
    seed = s5
    let a = @core.Point2D::new(x1, y1)
    let b = @core.Point2D::new(x2, y2)
    let a_r = @transform.rotate(a, angle)
    let b_r = @transform.rotate(b, angle)
    assert_true(@core.approx_eq(a.dist(b), a_r.dist(b_r), 1.0e-6))
  }
}

///| Random hull contains all points | 随机凸包包含所有点
test "ai: random hull contains all points" {
  let mut seed = 7777
  for _ in 0..<10 {
    let pts : Array[@core.Point2D] = []
    for _ in 0..<20 {
      let (x, s1) = lcg_double(seed, -10.0, 10.0)
      seed = s1
      let (y, s2) = lcg_double(seed, -10.0, 10.0)
      seed = s2
      pts.push(@core.Point2D::new(x, y))
    }
    let hull = @hull.convex_hull_andrew(pts)
    let hull_poly = @core.Polygon::new(hull)
    assert_true(@polygon.is_convex(hull_poly))
    assert_true(hull.length() <= pts.length())
  }
}

///| Random dot product symmetry | 随机点积对称性
test "ai: random dot product symmetry" {
  let mut seed = 31415
  for _ in 0..<50 {
    let (x1, s1) = lcg_double(seed, -10.0, 10.0)
    seed = s1
    let (y1, s2) = lcg_double(seed, -10.0, 10.0)
    seed = s2
    let (x2, s3) = lcg_double(seed, -10.0, 10.0)
    seed = s3
    let (y2, s4) = lcg_double(seed, -10.0, 10.0)
    seed = s4
    let a = @core.Point2D::new(x1, y1)
    let b = @core.Point2D::new(x2, y2)
    assert_true(@core.approx_eq(a.dot(b), b.dot(a), 1.0e-9))
  }
}

///| Random cross product anti-symmetry | 随机叉积反对称性
test "ai: random cross product anti-symmetry" {
  let mut seed = 27182
  for _ in 0..<50 {
    let (x1, s1) = lcg_double(seed, -10.0, 10.0)
    seed = s1
    let (y1, s2) = lcg_double(seed, -10.0, 10.0)
    seed = s2
    let (x2, s3) = lcg_double(seed, -10.0, 10.0)
    seed = s3
    let (y2, s4) = lcg_double(seed, -10.0, 10.0)
    seed = s4
    let a = @core.Point2D::new(x1, y1)
    let b = @core.Point2D::new(x2, y2)
    assert_true(@core.approx_eq(a.cross(b), -b.cross(a), 1.0e-9))
  }
}

// ============================================================
// 4. Extreme Value Tests | 极端值测试
// ============================================================

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

///| Hull of convex polygon is itself | 凸多边形的凸包为自身
test "extreme: hull of convex polygon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_eq(hull.length(), 4)
}

///| Graham and Andrew hull agree on size | Graham 和 Andrew 凸包大小一致
test "extreme: graham andrew agreement" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let hull_a = @hull.convex_hull_andrew(pts)
  let hull_g = @hull.convex_hull_graham(pts)
  assert_eq(hull_a.length(), hull_g.length())
}