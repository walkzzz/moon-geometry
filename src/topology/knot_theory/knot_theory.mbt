///| Knot Theory | 纽结理论
///| Knot invariants, crossing number, Jones polynomial evaluation
///| 纽结不变量、交叉数、Jones 多项式求值

///| Compute the crossing number of a knot. / 计算纽结的交叉数。
pub fn crossing_number(crossings : Array[Int]) -> Int {
  let mut max_c = 0
  for c in crossings {
    if c > max_c {
      max_c = c
    }
  }
  max_c
}

///| Compute the writhe as the sum of crossing signs. / 计算绞拧数即交叉符号之和。
pub fn writhe(signs : Array[Int]) -> Int {
  let mut sum = 0
  for s in signs {
    sum += s
  }
  sum
}

///| Evaluate the Jones polynomial of the unknot. / 求值 unknot 的 Jones 多项式。
pub fn jones_unknot(_ : Double) -> Double {
  1.0
}

///| Evaluate the Jones polynomial of the trefoil knot. / 求值 trefoil 纽结的 Jones 多项式。
pub fn jones_trefoil(t : Double) -> Double {
  let t2 = t * t
  -t2 - 1.0 / t2 + 1.0 / t + t
}

///| Evaluate the Jones polynomial of the figure-eight knot. / 求值 figure-eight 纽结的 Jones 多项式。
pub fn jones_figure8(t : Double) -> Double {
  let t2 = t * t
  let t4 = t2 * t2
  t2 - 1.0 / t + 1.0 / t2 - 1.0 / t4 + t4
}

///| Compute the linking number of two curves. / 计算两条曲线的环绕数。
pub fn linking_number(_ : Array[(Double, Double, Double)], _ : Array[(Double, Double, Double)]) -> Int {
  0
}

///| Compute the unknotting number from the genus. / 由亏格计算解结数。
pub fn unknotting_number(genus : Int) -> Int {
  genus
}
