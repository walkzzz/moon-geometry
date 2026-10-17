///| Formal Invariants | 不变量保持验证
///| Verify invariants are preserved across geometric operations
///| 验证几何操作中不变量保持

fn approx_eq(a : Double, b : Double) -> Bool {
  (a - b).abs() < 1.0e-9
}

fn approx_eq_tol(a : Double, b : Double, tol : Double) -> Bool {
  (a - b).abs() < tol
}

fn map_points(
  pts : Array[@core.Point2D],
  f : (@core.Point2D) -> @core.Point2D,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in pts {
    result.push(f(p))
  }
  result
}

///| Rotation preserves polygon area | 旋转保持多边形面积
test "invariant: rotation preserves area" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  let area_before = @polygon.polygon_area(poly)
  let rotated_verts = map_points(poly.vertices, fn(v) { @transform.rotate(v, 0.7853981633974483) })
  let rotated_poly = @core.Polygon::new(rotated_verts)
  let area_after = @polygon.polygon_area(rotated_poly)
  assert_true(approx_eq_tol(area_before, area_after, 1.0e-8))
}

///| Translation preserves polygon area | 平移保持多边形面积
test "invariant: translation preserves area" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  let area_before = @polygon.polygon_area(poly)
  let translated_verts = map_points(poly.vertices, fn(v) { @transform.translate(v, 100.0, -50.0) })
  let translated_poly = @core.Polygon::new(translated_verts)
  let area_after = @polygon.polygon_area(translated_poly)
  assert_true(approx_eq(area_before, area_after))
}

///| Uniform scaling changes area by s^2 | 均匀缩放使面积按 s^2 缩放
test "invariant: scaling changes area by s^2" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ])
  let area_before = @polygon.polygon_area(poly)
  let s = 3.0
  let scaled_verts = map_points(poly.vertices, fn(v) { @transform.scale(v, s, s) })
  let scaled_poly = @core.Polygon::new(scaled_verts)
  let area_after = @polygon.polygon_area(scaled_poly)
  assert_true(approx_eq(area_after, area_before * s * s))
}

///| Rotation preserves perimeter | 旋转保持周长
test "invariant: rotation preserves perimeter" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ])
  let perim_before = @polygon.polygon_perimeter(poly)
  let rotated_verts = map_points(poly.vertices, fn(v) { @transform.rotate(v, 1.2566370614359172) })
  let rotated_poly = @core.Polygon::new(rotated_verts)
  let perim_after = @polygon.polygon_perimeter(rotated_poly)
  assert_true(approx_eq_tol(perim_before, perim_after, 1.0e-8))
}

///| Convexity preserved under affine transform | 仿射变换保持凸性
test "invariant: convexity preserved under rotation" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  assert_true(@polygon.is_convex(poly))
  let rotated_verts = map_points(poly.vertices, fn(v) { @transform.rotate(v, 0.5235987755982989) })
  let rotated_poly = @core.Polygon::new(rotated_verts)
  assert_true(@polygon.is_convex(rotated_poly))
}

///| Convexity preserved under translation | 平移保持凸性
test "invariant: convexity preserved under translation" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ])
  let translated_verts = map_points(poly.vertices, fn(v) { @transform.translate(v, 50.0, -30.0) })
  let translated_poly = @core.Polygon::new(translated_verts)
  assert_true(@polygon.is_convex(translated_poly))
}

///| Hull area <= bounding rectangle area | 凸包面积 <= 包围矩形面积
test "invariant: hull area bounded by rectangle" {
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 2.0),
    @core.Point2D::new(3.0, 6.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  let hull_poly = @core.Polygon::new(hull)
  let hull_area = @polygon.polygon_area(hull_poly)
  let rect_area = 5.0 * 6.0
  assert_true(hull_area <= rect_area + 1.0e-10)
}

///| Centroid of symmetric shape is at center | 对称形状质心在中心
test "invariant: centroid of symmetric shape" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(-2.0, -2.0),
    @core.Point2D::new(2.0, -2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(-2.0, 2.0),
  ])
  let c = @polygon.polygon_centroid(poly)
  assert_true(approx_eq_tol(c.x(), 0.0, 1.0e-9))
  assert_true(approx_eq_tol(c.y(), 0.0, 1.0e-9))
}

///| DistSq is always non-negative | 距离平方非负
test "invariant: dist_sq non-negative" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(-5.0, 12.0),
  ]
  for i in 0..<pts.length() {
    for j in 0..<pts.length() {
      assert_true(pts[i].dist_sq(pts[j]) >= 0.0)
    }
  }
}

///| Mirror preserves area | 镜像保持面积
test "invariant: mirror preserves area" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ])
  let area_before = @polygon.polygon_area(poly)
  let mirrored_verts = map_points(poly.vertices, fn(v) { @transform.mirror_x(v) })
  let mirrored_poly = @core.Polygon::new(mirrored_verts)
  let area_after = @polygon.polygon_area(mirrored_poly)
  assert_true(approx_eq(area_before, area_after))
}