///| Mock Geometric | MOCK/FAKE 几何测试框架
///| Provides mock objects, fake generators, and stub functions for isolated testing
///| 提供模拟对象、伪生成器和桩函数用于隔离测试

// ============================================================
// 1. Mock Point Generators | 模拟点生成器
// ============================================================

///| Generate grid points | 生成网格点
pub fn mock_grid_points(nx : Int, ny : Int, spacing : Double) -> Array[@core.Point2D] {
  let result = Array::make(nx * ny, @core.Point2D::new(0.0, 0.0))
  let mut idx = 0
  for i in 0..<nx {
    for j in 0..<ny {
      result[idx] = @core.Point2D::new(i.to_double() * spacing, j.to_double() * spacing)
      idx += 1
    }
  }
  result
}

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

///| Linear congruential generator | 线性同余生成器
pub struct FakeRNG {
  mut seed : Int
}

pub fn FakeRNG::new(seed : Int) -> FakeRNG {
  { seed, }
}

pub fn FakeRNG::next(self : FakeRNG) -> Int {
  let val = (self.seed * 1103515245 + 12345) % 2147483647
  self.seed = if val < 0 { -val } else { val }
  self.seed
}

pub fn FakeRNG::next_double(self : FakeRNG, min : Double, max : Double) -> Double {
  let r = self.next().to_double() / 2147483647.0
  min + r * (max - min)
}

pub fn FakeRNG::next_point(self : FakeRNG, min_val : Double, max_val : Double) -> @core.Point2D {
  @core.Point2D::new(self.next_double(min_val, max_val), self.next_double(min_val, max_val))
}

pub fn FakeRNG::next_points(self : FakeRNG, n : Int, min_val : Double, max_val : Double) -> Array[@core.Point2D] {
  let result = Array::make(n, @core.Point2D::new(0.0, 0.0))
  for i in 0..<n {
    result[i] = self.next_point(min_val, max_val)
  }
  result
}

// ============================================================
// 3. Stub Functions | 桩函数
// ============================================================

///| Stub distance that always returns 0 | 桩距离函数（始终返回0）
pub fn stub_zero_distance(_a : @core.Point2D, _b : @core.Point2D) -> Double {
  0.0
}

///| Stub distance that returns Manhattan distance | 桩距离函数（曼哈顿距离）
pub fn stub_manhattan_distance(a : @core.Point2D, b : @core.Point2D) -> Double {
  (a.x() - b.x()).abs() + (a.y() - b.y()).abs()
}

///| Stub identity transform | 桩恒等变换
pub fn stub_identity(p : @core.Point2D) -> @core.Point2D {
  p
}

// ============================================================
// 4. Test Data Presets | 测试数据预设
// ============================================================

///| Preset: star-shaped points | 预设：星形点集
pub fn preset_star_points() -> Array[@core.Point2D] {
  [
    @core.Point2D::new(0.0, 5.0),
    @core.Point2D::new(1.5, 1.5),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(1.5, -1.5),
    @core.Point2D::new(0.0, -5.0),
    @core.Point2D::new(-1.5, -1.5),
    @core.Point2D::new(-5.0, 0.0),
    @core.Point2D::new(-1.5, 1.5),
  ]
}

///| Preset: L-shaped points | 预设：L形点集
pub fn preset_l_shape() -> Array[@core.Point2D] {
  [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
}

///| Preset: degenerate (all same point) | 预设：退化点集
pub fn preset_degenerate() -> Array[@core.Point2D] {
  [
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(3.0, 3.0),
  ]
}

// ============================================================
// 5. Mock Tests | 模拟测试
// ============================================================

test "mock grid points" {
  let pts = mock_grid_points(3, 3, 2.0)
  assert_eq(pts.length(), 9)
  assert_eq(pts[0].x(), 0.0)
  assert_eq(pts[0].y(), 0.0)
  assert_eq(pts[8].x(), 4.0)
  assert_eq(pts[8].y(), 4.0)
}

test "mock circle points" {
  let pts = mock_circle_points(0.0, 0.0, 5.0, 4)
  assert_eq(pts.length(), 4)
  assert_true(pts[0].x() > 4.99 && pts[0].x() < 5.01)
  assert_true(pts[0].y() > -0.01 && pts[0].y() < 0.01)
}

test "mock regular polygon" {
  let poly = mock_regular_polygon(0.0, 0.0, 3.0, 6)
  assert_eq(poly.size(), 6)
}

test "mock square" {
  let poly = mock_square(5.0)
  assert_eq(poly.size(), 4)
  let area = @polygon.polygon_area(poly)
  assert_true(area > 24.99 && area < 25.01)
}

test "mock triangle" {
  let poly = mock_triangle(6.0, 4.0)
  assert_eq(poly.size(), 3)
  let area = @polygon.polygon_area(poly)
  assert_true(area > 11.99 && area < 12.01)
}

test "fake RNG reproducibility" {
  let rng1 = FakeRNG::new(42)
  let rng2 = FakeRNG::new(42)
  assert_eq(rng1.next(), rng2.next())
  assert_eq(rng1.next(), rng2.next())
}

test "fake RNG range" {
  let rng = FakeRNG::new(123)
  for _ in 0..<100 {
    let v = rng.next_double(-10.0, 10.0)
    assert_true(v >= -10.0 && v < 10.0)
  }
}

test "stub manhattan distance" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(3.0, 4.0)
  assert_eq(stub_manhattan_distance(a, b), 7.0)
}

test "stub zero distance" {
  let a = @core.Point2D::new(3.0, 4.0)
  let b = @core.Point2D::new(7.0, 1.0)
  assert_eq(stub_zero_distance(a, b), 0.0)
}

test "preset star points" {
  let pts = preset_star_points()
  assert_eq(pts.length(), 8)
}

test "preset L-shape" {
  let pts = preset_l_shape()
  assert_eq(pts.length(), 6)
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() >= 4)
}

test "preset degenerate" {
  let pts = preset_degenerate()
  let hull = @hull.convex_hull_andrew(pts)
  assert_true(hull.length() <= 3)
}

test "mock collinear points" {
  let pts = mock_collinear_points(5, 2.0, 3.0)
  assert_eq(pts.length(), 5)
  assert_eq(pts[0].x(), 0.0)
  assert_eq(pts[4].x(), 8.0)
}