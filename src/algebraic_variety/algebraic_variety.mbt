///|
/// # Algebraic Variety
/// # 代数簇
///
/// Zero sets of polynomial systems and their properties.
/// 多项式系统的零点集及其性质。

///|
pub fn variety_dimension(n_vars : Int, n_equations : Int) -> Int {
  let expected = n_vars - n_equations
  if expected < 0 { 0 } else { expected }
}

///|
pub fn variety_is_empty(n_solutions : Int) -> Bool {
  n_solutions == 0
}

///|
pub fn variety_is_finite(dimension : Int) -> Bool {
  dimension == 0
}

///|
pub fn variety_degree(n_vars : Int, degrees : Array[Int]) -> Int {
  let mut product = 1
  for i in 0..<degrees.length() {
    product *= degrees[i]
  }
  if n_vars < degrees.length() { 0 } else { product }
}

///|
pub fn variety_count_real_roots(approx_roots : Array[Double], tol : Double) -> Int {
  let sorted = Array::make(approx_roots.length(), 0.0)
  for i in 0..<approx_roots.length() {
    sorted[i] = approx_roots[i]
  }
  sorted.sort()
  if sorted.length() == 0 { return 0 }
  let mut count = 1
  for i in 1..<sorted.length() {
    if (sorted[i] - sorted[i - 1]).abs() > tol {
      count += 1
    }
  }
  count
}
