///| Geometric Arrangements | 几何安排

///| Line arrangements, hyperplane arrangements, zone theorems

///| 直线安排、超平面安排、区域定理

///|
/// Count the number of regions in an arrangement of n lines. / 计算 n 条直线安排的区域数。
pub fn line_arrangement_count(n : Int32) -> Int32 {
  n * (n + 1) / 2
}
