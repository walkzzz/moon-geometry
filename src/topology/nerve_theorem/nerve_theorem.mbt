///|
/// # Nerve Theorem
/// # 神经定理
///
/// Nerve of a cover and homology equivalence.
/// 覆盖的神经与同调等价。

///|
pub fn nerve_of_cover(n_sets : Int, intersections : Array[(Int, Int)]) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<n_sets {
    result.push([i])
  }
  for i in 0..<intersections.length() {
    result.push([intersections[i].0, intersections[i].1])
  }
  result
}

///|
pub fn nerve_homology(nerve : Array[Array[Int]]) -> Array[Int] {
  let n0 = nerve.length()
  let mut n1 = 0
  for i in 0..<nerve.length() {
    if nerve[i].length() == 2 { n1 += 1 }
  }
  [n0 - n1, n1]
}

///|
pub fn is_good_cover(intersections : Array[(Int, Int)]) -> Bool {
  intersections.length() > 0
}
