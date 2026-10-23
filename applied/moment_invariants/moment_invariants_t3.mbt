///|
/// Factorial. / 阶乘。
fn factorial(n : Int32) -> Double {
  let mut result = 1.0
  for i in 1..<=n {
    result *= i.to_double()
  }
  result
}
