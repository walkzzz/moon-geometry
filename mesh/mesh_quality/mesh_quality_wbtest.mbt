///|
test "equilateral triangle quality" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.5, 0.8660254037844386, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true((q.aspect_ratio - 2.0).abs() < 0.01)
  assert_true((q.edge_ratio - 1.0).abs() < 0.01)
  assert_true((q.min_angle - 1.0471975511965976).abs() < 0.01)
}

///|
test "degenerate triangle" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(2.0, 0.0, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.aspect_ratio > 100.0)
}

///|
test "right triangle quality" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(3.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.0, 4.0, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.edge_ratio > 1.0)
  assert_true(q.max_angle > q.min_angle)
}

///|
test "mesh average quality" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (1, 3, 2)]
  let q = mesh_average_quality(verts, faces)
  assert_true(q.aspect_ratio > 0.0)
}

///|
test "count degenerate" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 1, 3)]
  let count = count_degenerate(verts, faces, 0.0001)
  assert_eq(count, 1)
}

///|
test "isoceles triangle" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(2.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(1.0, 1.0, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.min_angle > 0.0)
  assert_true(q.max_angle < 3.14159265358979323846)
}

///|
test "thin sliver" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.5, 0.01, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.aspect_ratio > 10.0)
}

///|
test "area ratio equilateral" {
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.5, 0.8660254037844386, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true((q.area_ratio - 1.0).abs() < 0.01)
}

///|
test "empty mesh quality" {
  let q = mesh_average_quality([], [])
  assert_eq(q.aspect_ratio, 0.0)
}

///|
test "MeshQualityMetrics::new" {
  // 覆盖构造函数体（第 20 行）
  let m = MeshQualityMetrics::new(1.0, 0.5, 0.3, 1.5, 2.0)
  assert_true((m.aspect_ratio - 1.0).abs() < 0.0000001)
  assert_true((m.area_ratio - 0.5).abs() < 0.0000001)
  assert_true((m.min_angle - 0.3).abs() < 0.0000001)
  assert_true((m.max_angle - 1.5).abs() < 0.0000001)
  assert_true((m.edge_ratio - 2.0).abs() < 0.0000001)
}

///|
test "triangle e0 is min edge" {
  // e0=p1.dist(p2) 最小，覆盖 min_edge 的 e0 分支（第 37 行）
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(3.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(2.0, 0.1, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.edge_ratio > 1.0)
}

///|
test "triangle e2 is max edge" {
  // e2=p0.dist(p1) 最大，且 e0 > e1，覆盖 max_edge 的 e2 分支（第 50 行）
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(2.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(0.5, 0.1, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.edge_ratio > 1.0)
}

///|
test "triangle zero edge ratio" {
  // 两顶点重合，min_edge=0，覆盖 edge_ratio 的 MAX 分支（第 60 行）
  // 和 angle_between 的 denom<eps 分支（第 107 行）
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(1.0, 0.0, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.edge_ratio > 1.0e300)
}

///|
test "triangle a0 is min angle" {
  // p0 处角最小，覆盖 min_angle 的 a0 分支（第 78 行）
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(1.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(1.0, 0.1, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.min_angle > 0.0)
  assert_true(q.min_angle < q.max_angle)
}

///|
test "triangle a2 is max angle" {
  // p2 处角最大，覆盖 max_angle 的 a2 分支（第 91 行）
  let p0 = @core.Point3D::new(0.0, 0.0, 0.0)
  let p1 = @core.Point3D::new(2.0, 0.0, 0.0)
  let p2 = @core.Point3D::new(1.8, 0.1, 0.0)
  let q = triangle_quality(p0, p1, p2)
  assert_true(q.max_angle > q.min_angle)
  assert_true(q.max_angle > 2.0)
}

///|
test "angle_between cos greater than one" {
  // cos_c > 1.0 → 0.0，覆盖第 111 行
  // angle_between(2, 1, 0): cos_c=(4+1-0)/(2*2*1)=1.25 > 1
  let result = angle_between(2.0, 1.0, 0.0)
  assert_true(result.abs() < 0.0000001)
}

///|
test "angle_between cos less than minus one" {
  // cos_c < -1.0 → π，覆盖第 113 行
  // angle_between(1, 1, 3): cos_c=(1+1-9)/(2*1*1)=-3.5 < -1
  let result = angle_between(1.0, 1.0, 3.0)
  assert_true((result - 3.14159265358979323846).abs() < 0.0000001)
}

///|
test "count degenerate multiple" {
  // 多个退化三角形
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(3.0, 0.0, 0.0),
  ]
  let faces = [(0, 1, 2), (1, 2, 3)]
  let count = count_degenerate(verts, faces, 0.0001)
  assert_eq(count, 2)
}
