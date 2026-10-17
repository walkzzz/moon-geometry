///| Formal Properties | 形式化属性验证
///| Property-based tests verifying mathematical axioms and invariants
///| 基于属性的测试，验证数学公理和不变量

fn approx_eq(a : Double, b : Double) -> Bool {
  (a - b).abs() < 1.0e-10
}

fn approx_eq_tol(a : Double, b : Double, tol : Double) -> Bool {
  (a - b).abs() < tol
}

// ============================================================
// 1. Distance Axioms | 距离公理
// ============================================================

///| Distance symmetry: d(a,b) = d(b,a) | 距离对称性
test "axiom: distance symmetry" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(7.0, 1.0)
  let d_ab = a.dist(b)
  let d_ba = b.dist(a)
  assert_true(approx_eq(d_ab, d_ba))
}

///| Distance non-negativity: d(a,b) >= 0 | 距离非负性
test "axiom: distance non-negativity" {
  let a = @core.Point2D::new(1.0, 2.0)
  let b = @core.Point2D::new(5.0, 6.0)
  assert_true(a.dist(b) >= 0.0)
}

///| Distance identity: d(a,a) = 0 | 距离同一性
test "axiom: distance identity of indiscernibles" {
  let a = @core.Point2D::new(3.14, 2.71)
  assert_true(approx_eq(a.dist(a), 0.0))
}

///| Triangle inequality: d(a,c) <= d(a,b) + d(b,c) | 三角不等式
test "axiom: triangle inequality" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(3.0, 4.0)
  let c = @core.Point2D::new(6.0, 8.0)
  let d_ac = a.dist(c)
  let d_ab = a.dist(b)
  let d_bc = b.dist(c)
  assert_true(d_ac <= d_ab + d_bc + 1.0e-10)
}

///| Triangle inequality with random-like points | 三角不等式（多组测试）
test "axiom: triangle inequality (multiple cases)" {
  let cases = [
    (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0), @core.Point2D::new(2.0, 0.0)),
    (@core.Point2D::new(-3.0, 4.0), @core.Point2D::new(5.0, -2.0), @core.Point2D::new(7.0, 11.0)),
    (@core.Point2D::new(100.0, 200.0), @core.Point2D::new(-50.0, 75.0), @core.Point2D::new(0.0, 0.0)),
  ]
  for case in cases {
    let (a, b, c) = case
    let d_ac = a.dist(c)
    let d_ab = a.dist(b)
    let d_bc = b.dist(c)
    assert_true(d_ac <= d_ab + d_bc + 1.0e-10)
  }
}

// ============================================================
// 2. Transform Properties | 变换属性
// ============================================================

///| Translation preserves distance | 平移保持距离
test "property: translation preserves distance" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = @core.Point2D::new(7.0, 1.0)
  let dx = 10.0
  let dy = -5.0
  let p_t = @transform.translate(p, dx, dy)
  let q_t = @transform.translate(q, dx, dy)
  assert_true(approx_eq(p.dist(q), p_t.dist(q_t)))
}

///| Rotation preserves distance | 旋转保持距离
test "property: rotation preserves distance" {
  let p = @core.Point2D::new(3.0, 4.0)
  let q = @core.Point2D::new(7.0, 1.0)
  let angle = 0.7853981633974483
  let p_r = @transform.rotate(p, angle)
  let q_r = @transform.rotate(q, angle)
  assert_true(approx_eq(p.dist(q), p_r.dist(q_r)))
}

///| Rotation composition: R(β)∘R(α) = R(α+β) | 旋转复合
test "property: rotation composition" {
  let p = @core.Point2D::new(5.0, 3.0)
  let alpha = 0.5235987755982989
  let beta = 1.0471975511965979
  let p_ra = @transform.rotate(p, alpha)
  let p_rab = @transform.rotate(p_ra, beta)
  let p_rab2 = @transform.rotate(p, alpha + beta)
  assert_true(approx_eq_tol(p_rab.x(), p_rab2.x(), 1.0e-9))
  assert_true(approx_eq_tol(p_rab.y(), p_rab2.y(), 1.0e-9))
}

///| Inverse translation restores original | 逆平移恢复原状
test "property: inverse translation" {
  let p = @core.Point2D::new(3.0, 4.0)
  let dx = 10.0
  let dy = -5.0
  let p_t = @transform.translate(p, dx, dy)
  let p_restored = @transform.translate(p_t, -dx, -dy)
  assert_true(approx_eq(p.x(), p_restored.x()))
  assert_true(approx_eq(p.y(), p_restored.y()))
}

///| Inverse rotation restores original | 逆旋转恢复原状
test "property: inverse rotation" {
  let p = @core.Point2D::new(5.0, 3.0)
  let angle = 1.2566370614359172
  let p_r = @transform.rotate(p, angle)
  let p_restored = @transform.rotate(p_r, -angle)
  assert_true(approx_eq_tol(p.x(), p_restored.x(), 1.0e-9))
  assert_true(approx_eq_tol(p.y(), p_restored.y(), 1.0e-9))
}

///| Mirror is involution: M(M(p)) = p | 镜像对合性
test "property: mirror involution (mirror_x)" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_m = @transform.mirror_x(p)
  let p_mm = @transform.mirror_x(p_m)
  assert_true(approx_eq(p.x(), p_mm.x()))
  assert_true(approx_eq(p.y(), p_mm.y()))
}

///| Mirror Y is involution | Y 镜像对合性
test "property: mirror involution (mirror_y)" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_m = @transform.mirror_y(p)
  let p_mm = @transform.mirror_y(p_m)
  assert_true(approx_eq(p.x(), p_mm.x()))
  assert_true(approx_eq(p.y(), p_mm.y()))
}

///| Mirror origin is involution | 原点镜像对合性
test "property: mirror involution (mirror_origin)" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_m = @transform.mirror_origin(p)
  let p_mm = @transform.mirror_origin(p_m)
  assert_true(approx_eq(p.x(), p_mm.x()))
  assert_true(approx_eq(p.y(), p_mm.y()))
}

///| Scale by 1 is identity | 缩放1为恒等
test "property: scale identity" {
  let p = @core.Point2D::new(3.0, 4.0)
  let p_s = @transform.scale(p, 1.0, 1.0)
  assert_true(approx_eq(p.x(), p_s.x()))
  assert_true(approx_eq(p.y(), p_s.y()))
}

// ============================================================
// 3. Convex Hull Properties | 凸包属性
// ============================================================

///| Andrew and Graham produce same hull size | Andrew 和 Graham 凸包大小相同
test "property: convex hull algorithm equivalence" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let hull_a = @hull.convex_hull_andrew(pts)
  let hull_g = @hull.convex_hull_graham(pts)
  assert_eq(hull_a.length(), hull_g.length())
}

///| Convex hull of square has 4 vertices | 正方形凸包有4个顶点
test "property: convex hull of square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_eq(hull.length(), 4)
}

///| Convex hull of collinear points is a segment | 共线点凸包为线段
test "property: convex hull of collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 3)
}

// ============================================================
// 4. Polygon Properties | 多边形属性
// ============================================================

///| Square area = side^2 | 正方形面积等于边长平方
test "property: square area" {
  let side = 5.0
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(side, 0.0),
    @core.Point2D::new(side, side),
    @core.Point2D::new(0.0, side),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, side * side))
}

///| Square perimeter = 4 * side | 正方形周长等于4倍边长
test "property: square perimeter" {
  let side = 5.0
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(side, 0.0),
    @core.Point2D::new(side, side),
    @core.Point2D::new(0.0, side),
  ])
  let perim = @polygon.polygon_perimeter(poly)
  assert_true(approx_eq(perim, 4.0 * side))
}

///| Triangle area = 0.5 * base * height | 三角形面积
test "property: triangle area" {
  let base = 6.0
  let height = 4.0
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(base, 0.0),
    @core.Point2D::new(0.0, height),
  ])
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 0.5 * base * height))
}

///| Polygon area is non-negative | 多边形面积非负
test "property: polygon area non-negative" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  assert_true(@polygon.polygon_area(poly) >= 0.0)
}

///| Convex polygon is detected as convex | 凸多边形被检测为凸
test "property: convex polygon detection" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(@polygon.is_convex(poly))
}

///| Non-convex polygon is detected as non-convex | 非凸多边形被检测为非凸
test "property: non-convex polygon detection" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(!@polygon.is_convex(poly))
}

// ============================================================
// 5. Vector Space Properties | 向量空间属性
// ============================================================

///| Vector addition commutativity: a+b = b+a | 向量加法交换律
test "axiom: vector addition commutativity" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(5.0, 7.0)
  let ab = a.add(b)
  let ba = b.add(a)
  assert_true(approx_eq(ab.x(), ba.x()))
  assert_true(approx_eq(ab.y(), ba.y()))
}

///| Vector addition associativity: (a+b)+c = a+(b+c) | 向量加法结合律
test "axiom: vector addition associativity" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(5.0, 7.0)
  let c = @core.Point2D::new(-2.0, 6.0)
  let ab_c = a.add(b).add(c)
  let a_bc = a.add(b.add(c))
  assert_true(approx_eq(ab_c.x(), a_bc.x()))
  assert_true(approx_eq(ab_c.y(), a_bc.y()))
}

///| Vector addition identity: a+0 = a | 向量加法零元
test "axiom: vector addition identity" {
  let a = @core.Point2D::new(3.0, 4.0)
  let zero = @core.Point2D::new(0.0, 0.0)
  let a_zero = a.add(zero)
  assert_true(approx_eq(a.x(), a_zero.x()))
  assert_true(approx_eq(a.y(), a_zero.y()))
}

///| Vector addition inverse: a+(-a) = 0 | 向量加法逆元
test "axiom: vector addition inverse" {
  let a = @core.Point2D::new(3.0, 4.0)
  let neg_a = @core.Point2D::new(-3.0, -4.0)
  let sum = a.add(neg_a)
  assert_true(approx_eq(sum.x(), 0.0))
  assert_true(approx_eq(sum.y(), 0.0))
}

///| Dot product symmetry: a·b = b·a | 点积对称性
test "axiom: dot product symmetry" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(5.0, 7.0)
  assert_true(approx_eq(a.dot(b), b.dot(a)))
}

///| Dot product positive semi-definiteness: a·a >= 0 | 点积正半定性
test "axiom: dot product positive semi-definite" {
  let a = @core.Point2D::new(3.0, 4.0)
  assert_true(a.dot(a) >= 0.0)
}

///| Cross product anti-symmetry: a×b = -(b×a) | 叉积反对称性
test "axiom: cross product anti-symmetry" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(5.0, 7.0)
  let ab = a.cross(b)
  let ba = b.cross(a)
  assert_true(approx_eq(ab, -ba))
}

///| Scalar multiplication distributivity: s*(a+b) = s*a + s*b | 标量乘法分配律
test "axiom: scalar multiplication distributivity" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(5.0, 7.0)
  let s = 2.5
  let s_ab = a.add(b).mul(s)
  let sa_sb = a.mul(s).add(b.mul(s))
  assert_true(approx_eq(s_ab.x(), sa_sb.x()))
  assert_true(approx_eq(s_ab.y(), sa_sb.y()))
}