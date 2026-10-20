///| E2E Workflows | 端到端集成测试
///| Complete geometric processing pipeline tests
///| 完整几何处理管线测试

fn approx_eq(a : Double, b : Double) -> Bool { @core.approx_eq(a, b, 1.0e-9) }



///| E2E: Point set → Convex hull → Area → Containment check
///| 端到端：点集 → 凸包 → 面积 → 包含检查
test "e2e: convex hull pipeline" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(7.0, 3.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  let hull_poly = @core.Polygon::new(hull)
  let area = @polygon.polygon_area(hull_poly)
  assert_true(area > 99.0 && area < 101.0)
  assert_true(@polygon.is_convex(hull_poly))
  let interior_pts = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(7.0, 3.0),
  ]
  for p in interior_pts {
    assert_true(@polygon.point_in_polygon(p, hull_poly))
  }
}

///| E2E: Polygon → Transform → Inverse → Restore
///| 端到端：多边形 → 变换 → 逆变换 → 恢复
test "e2e: transform inverse pipeline" {
  let original = @core.Polygon::new([
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(5.0, 2.0),
    @core.Point2D::new(5.0, 6.0),
    @core.Point2D::new(1.0, 6.0),
  ])
  let dx = 10.0
  let dy = 20.0
  let angle = 0.7853981633974483
  let transformed_verts = @core.map_points(original.vertices, fn(v) {
    @transform.rotate(@transform.translate(v, dx, dy), angle)
  })
  let transformed = @core.Polygon::new(transformed_verts)
  let restored_verts = @core.map_points(transformed.vertices, fn(v) {
    @transform.translate(@transform.rotate(v, -angle), -dx, -dy)
  })
  let restored = @core.Polygon::new(restored_verts)
  for i in 0..<original.size() {
    assert_true(@core.approx_eq(original.vertices[i].x(), restored.vertices[i].x(), 1.0e-8))
    assert_true(@core.approx_eq(original.vertices[i].y(), restored.vertices[i].y(), 1.0e-8))
  }
}

///| E2E: Point set → Both hull algorithms → Compare
///| 端到端：点集 → 两种凸包算法 → 比较
test "e2e: hull algorithm comparison" {
  let pts = [
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(5.0, 1.0),
    @core.Point2D::new(8.0, 4.0),
    @core.Point2D::new(6.0, 7.0),
    @core.Point2D::new(3.0, 8.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(4.0, 5.0),
  ]
  let hull_a = @hull.convex_hull_andrew(pts)
  let hull_g = @hull.convex_hull_graham(pts)
  let poly_a = @core.Polygon::new(hull_a)
  let poly_g = @core.Polygon::new(hull_g)
  let area_a = @polygon.polygon_area(poly_a)
  let area_g = @polygon.polygon_area(poly_g)
  assert_eq(hull_a.length(), hull_g.length())
  assert_true(@core.approx_eq(area_a, area_g, 1.0e-8))
}

///| E2E: Square → Scale → Area check
///| 端到端：正方形 → 缩放 → 面积检查
test "e2e: scale area pipeline" {
  let side = 4.0
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(side, 0.0),
    @core.Point2D::new(side, side),
    @core.Point2D::new(0.0, side),
  ])
  let original_area = @polygon.polygon_area(poly)
  let scale_factor = 2.5
  let scaled_verts = @core.map_points(poly.vertices, fn(v) { @transform.scale(v, scale_factor, scale_factor) })
  let scaled_poly = @core.Polygon::new(scaled_verts)
  let scaled_area = @polygon.polygon_area(scaled_poly)
  assert_true(approx_eq(scaled_area, original_area * scale_factor * scale_factor))
}

///| E2E: Multiple transforms → Composition
///| 端到端：多重变换 → 合成
test "e2e: transform composition" {
  let p = @core.Point2D::new(3.0, 4.0)
  let dx = 5.0
  let dy = 7.0
  let angle = 0.5235987755982989
  let p_t = @transform.translate(p, dx, dy)
  let p_tr = @transform.rotate(p_t, angle)
  let p_r = @transform.rotate(p, angle)
  let p_rt = @transform.translate(p_r, dx, dy)
  assert_true(!approx_eq(p_tr.x(), p_rt.x()))
}

///| E2E: Polygon → Perimeter → Triangle inequality
///| 端到端：多边形 → 周长 → 三角不等式
test "e2e: perimeter consistency" {
  let poly = @core.Polygon::new([
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(6.0, 8.0),
    @core.Point2D::new(0.0, 8.0),
  ])
  let perim = @polygon.polygon_perimeter(poly)
  assert_true(approx_eq(perim, 28.0))
  let area = @polygon.polygon_area(poly)
  assert_true(approx_eq(area, 48.0))
}

///| E2E: Convex hull → Convexity invariant
///| 端到端：凸包 → 凸性不变量
test "e2e: hull convexity invariant" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 2.0),
    @core.Point2D::new(3.0, 8.0),
    @core.Point2D::new(1.0, 4.0),
    @core.Point2D::new(7.0, 5.0),
    @core.Point2D::new(4.0, 1.0),
    @core.Point2D::new(2.0, 6.0),
  ]
  let hull = @hull.convex_hull_andrew(pts)
  let hull_poly = @core.Polygon::new(hull)
  assert_true(@polygon.is_convex(hull_poly))
  let hull_g = @hull.convex_hull_graham(pts)
  let hull_g_poly = @core.Polygon::new(hull_g)
  assert_true(@polygon.is_convex(hull_g_poly))
}

///| E2E: Distance matrix → Symmetry check
///| 端到端：距离矩阵 → 对称性检查
test "e2e: distance matrix symmetry" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(6.0, 8.0),
    @core.Point2D::new(-2.0, 5.0),
  ]
  for i in 0..<pts.length() {
    for j in 0..<pts.length() {
      let d_ij = pts[i].dist(pts[j])
      let d_ji = pts[j].dist(pts[i])
      assert_true(approx_eq(d_ij, d_ji))
    }
  }
}

///| E2E: Transform chain → Identity recovery
///| 端到端：变换链 → 恒等恢复
test "e2e: transform chain identity" {
  let p = @core.Point2D::new(7.0, 3.0)
  let p1 = @transform.translate(p, 10.0, 20.0)
  let p2 = @transform.rotate(p1, 1.5707963267948966)
  let p3 = @transform.scale(p2, 2.0, 2.0)
  let p4 = @transform.scale(p3, 0.5, 0.5)
  let p5 = @transform.rotate(p4, -1.5707963267948966)
  let p6 = @transform.translate(p5, -10.0, -20.0)
  assert_true(@core.approx_eq(p.x(), p6.x(), 1.0e-8))
  assert_true(@core.approx_eq(p.y(), p6.y(), 1.0e-8))
}