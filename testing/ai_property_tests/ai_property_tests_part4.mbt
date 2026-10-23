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
