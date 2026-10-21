///| Quantum Geometry | 量子几何
///| Quantum groups, noncommutative geometry basics
///| 量子群、非交换几何基础

///| q-deformed product of two scalars. / 两个标量的 q-形变乘积。
pub fn q_deformed_product(a : Double, b : Double, q : Double) -> Double {
  a * b + (q - 1.0) * b * a
}

///| q-commutator (q-deformed Lie bracket) of two scalars. / 两个标量的 q-换位子（q-形变李括号）。
pub fn q_commutator(a : Double, b : Double, q : Double) -> Double {
  a * b - q * b * a
}

///| q-number [n]_q. / q-数 [n]_q。
pub fn q_number(n : Int, q : Double) -> Double {
  if (q - 1.0).abs() < 1.0e-15 {
    n.to_double()
  } else {
    (1.0 - @math.pow(q, n.to_double())) / (1.0 - q)
  }
}

///| q-factorial [n]_q!. / q-阶乘 [n]_q!。
pub fn q_factorial(n : Int, q : Double) -> Double {
  let mut result = 1.0
  for i in 1..=n {
    result *= q_number(i, q)
  }
  result
}

///| q-binomial coefficient. / q-二项式系数。
pub fn q_binomial(n : Int, k : Int, q : Double) -> Double {
  q_factorial(n, q) / (q_factorial(k, q) * q_factorial(n - k, q))
}

///| Quantum-deformed metric components. / 量子形变度量分量。
pub fn quantum_metric(g11 : Double, g22 : Double, q : Double) -> (Double, Double) {
  (g11 * q, g22 / q)
}
