///| Generate n random 2D points in the given range. / 在给定范围内生成 n 个随机二维点。
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
