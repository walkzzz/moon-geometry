///| E2E Workflows | 端到端集成测试

///| Complete geometric processing pipeline tests

///|
/// 完整几何处理管线测试
fn approx_eq(a : Double, b : Double) -> Bool {
  @core.approx_eq(a, b, 1.0e-9)
}
