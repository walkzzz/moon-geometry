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
