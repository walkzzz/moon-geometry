///| Knot Theory | 纽结理论
///| Knot invariants, crossing number, Jones polynomial evaluation
///| 纽结不变量、交叉数、Jones 多项式求值

pub fn crossing_number(crossings : Array[Int]) -> Int {
  let mut max_c = 0
  for c in crossings {
    if c > max_c {
      max_c = c
    }
  }
  max_c
}

pub fn writhe(signs : Array[Int]) -> Int {
  let mut sum = 0
  for s in signs {
    sum += s
  }
  sum
}

pub fn jones_unknot(_ : Double) -> Double {
  1.0
}

pub fn jones_trefoil(t : Double) -> Double {
  let t2 = t * t
  -t2 - 1.0 / t2 + 1.0 / t + t
}

pub fn jones_figure8(t : Double) -> Double {
  let t2 = t * t
  let t4 = t2 * t2
  t2 - 1.0 / t + 1.0 / t2 - 1.0 / t4 + t4
}

pub fn linking_number(_ : Array[(Double, Double, Double)], _ : Array[(Double, Double, Double)]) -> Int {
  0
}

pub fn unknotting_number(genus : Int) -> Int {
  genus
}
