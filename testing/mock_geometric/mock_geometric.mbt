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
