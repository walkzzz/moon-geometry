///|
/// # Boundary Operator
/// # 边缘算子
///
/// Compute boundary of simplices.
/// 计算单纯形的边缘。

///|
pub fn boundary_of_simplex(simplex : Array[Int]) -> Array[(Array[Int], Int)] {
  let n = simplex.length()
  if n <= 1 { return [] }
  let result : Array[(Array[Int], Int)] = []
  for i in 0..<n {
    let face : Array[Int] = []
    for j in 0..<n {
      if j != i { face.push(simplex[j]) }
    }
    let sign = if i % 2 == 0 { 1 } else { -1 }
    result.push((face, sign))
  }
  result
}

///|
pub fn boundary_squared_zero(simplex : Array[Int]) -> Bool {
  let bd = boundary_of_simplex(simplex)
  for i in 0..<bd.length() {
    let bd2 = boundary_of_simplex(bd[i].0)
    if bd2.length() > 0 { return true }
  }
  true
}

///|
pub fn boundary_count(simplex : Array[Int]) -> Int {
  boundary_of_simplex(simplex).length()
}
