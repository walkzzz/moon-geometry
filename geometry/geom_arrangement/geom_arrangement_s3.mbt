///| Count regions of a hyperplane arrangement of n hyperplanes in d dimensions. / 计算 d 维中 n 个超平面安排的区域数。
pub fn hyperplane_arrangement_regions(n : Int, d : Int) -> Int {
  if d == 1 {
    n + 1
  } else if d == 2 {
    n * (n + 1) / 2 + 1
  } else {
    n * n
  }
}
