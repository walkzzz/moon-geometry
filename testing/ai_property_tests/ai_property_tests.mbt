///| AI Property Tests | AI 驱动属性测试

///| AI-driven property and boundary tests for robust verification

///|
/// AI 驱动的属性和边界测试，用于鲁棒性验证
fn approx_eq(a : Double, b : Double) -> Bool {
  @core.approx_eq(a, b, 1.0e-9)
}

///|
/// Simple LCG for AI-driven random testing | 简单 LCG 用于 AI 驱动随机测试
fn lcg_next(seed : Int32) -> Int32 {
  let val = (seed * 1103515245 + 12345) % 2147483647
  if val < 0 {
    -val
  } else {
    val
  }
}

///|
fn lcg_double(seed : Int32, min : Double, max : Double) -> (Double, Int32) {
  let next_seed = lcg_next(seed)
  let r = next_seed.to_double() / 2147483647.0
  (min + r * (max - min), next_seed)
}

// ============================================================
// 1. Boundary Condition Tests | 边界条件测试
// ============================================================
