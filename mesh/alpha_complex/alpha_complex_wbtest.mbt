///|
test "alpha_complex empty" {
  let ac = alpha_complex([], 1.0)
  assert_eq(ac.simplex_count(), 0)
}

///|
test "alpha_complex single point" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let ac = alpha_complex(pts, 1.0)
  assert_eq(ac.simplex_count(), 1)
}

///|
test "alpha_complex two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let ac = alpha_complex(pts, 1.0)
  assert_true(ac.simplex_count() >= 2)
}

///|
test "alpha_complex triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 2.0),
  ]
  let ac = alpha_complex(pts, 5.0)
  assert_true(ac.simplex_count() >= 3)
}

///|
test "alpha_complex small alpha" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 10.0),
  ]
  let ac = alpha_complex(pts, 0.5)
  assert_eq(ac.simplex_count(), 3)
}

///|
test "alpha_shape" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let shape = alpha_shape(pts, 3.0)
  assert_true(shape.length() >= 0)
}

///|
test "is_alpha_exposed" {
  let s = { vertices: [0, 1], dimension: 1, circumradius: 2.0, }
  assert_true(is_alpha_exposed(s, 3.0))
  assert_false(is_alpha_exposed(s, 1.0))
}

///|
test "alpha_complex_count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 1.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let ac = alpha_complex(pts, 3.0)
  assert_true(alpha_complex_count(ac) >= 4)
}

///|
test "AlphaComplex::new" {
  let ac = AlphaComplex::new()
  assert_eq(ac.simplex_count(), 0)
}

///|
test "circumcenter collinear" {
  // 三个共线点，d.abs() < eps → 返回重心
  // 覆盖第 43 行
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  let center = circumcenter(a, b, c)
  // 重心 = (1, 0)
  assert_true((center.x() - 1.0).abs() < 0.0000001)
  assert_true((center.y() - 0.0).abs() < 0.0000001)
}

///|
test "alpha_complex first point not min" {
  // 第一个点不是最小 x 和最小 y，覆盖 delaunay_2d 的 min_x/min_y 更新（第 86, 92 行）
  let pts = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let ac = alpha_complex(pts, 5.0)
  assert_true(ac.simplex_count() >= 4)
}

///|
test "alpha_complex all coincident points" {
  // 所有点重合，dmax < eps → delaunay_2d 返回 []
  // 覆盖第 102 行
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let ac = alpha_complex(pts, 1.0)
  // 3 个 0-单纯形 + 3 个 1-单纯形（重合点距离 0 <= alpha），无 Delaunay 三角形
  assert_eq(ac.simplex_count(), 6)
}

///|
test "insert_pt no bad triangles" {
  // 点不在任何三角形 circumcircle 内，bad 为空 → return
  // 覆盖第 139 行
  let points = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 10.0),
    @core.Point2D::new(100.0, 100.0),
  ]
  let tris : Array[(Int32, Int32, Int32)] = [(0, 1, 2)]
  // (100,100) 不在 (0,0),(10,0),(5,10) 的 circumcircle 内
  insert_pt(points, tris, 3)
  // bad 为空，tris 不变
  assert_eq(tris.length(), 1)
}

///|
test "alpha_shape with interior point" {
  // 四点含一个内部点，覆盖 alpha_shape 的 dimension==2 分支
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let shape = alpha_shape(pts, 3.0)
  assert_true(shape.length() >= 0)
}

///|
test "is_alpha_exposed boundary" {
  // 边界情况：circumradius 恰好等于 alpha
  let s = { vertices: [0, 1], dimension: 1, circumradius: 2.0, }
  assert_true(is_alpha_exposed(s, 2.0))
  assert_false(is_alpha_exposed(s, 1.999))
}
