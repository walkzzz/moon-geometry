///| Geometric Arrangements | 几何安排
///| Line arrangements, hyperplane arrangements, zone theorems
///| 直线安排、超平面安排、区域定理

///| Count the number of regions in an arrangement of n lines. / 计算 n 条直线安排的区域数。
pub fn line_arrangement_count(n : Int) -> Int {
  n * (n + 1) / 2
}

///| Compute the intersection point of two lines a1*x+b1*y=c1 and a2*x+b2*y=c2. / 计算两条直线 a1*x+b1*y=c1 与 a2*x+b2*y=c2 的交点。
pub fn line_intersection(a1 : Double, b1 : Double, c1 : Double, a2 : Double, b2 : Double, c2 : Double) -> (Double, Double) {
  let det = a1 * b2 - a2 * b1
  ((c1 * b2 - c2 * b1) / det, (a1 * c2 - a2 * c1) / det)
}

///| Compute the zone theorem complexity for n lines. / 计算 n 条直线的区域定理复杂度。
pub fn zone_complexity(n : Int) -> Int {
  6 * n - 12
}

///| Count the number of faces in an arrangement of n lines. / 计算 n 条直线安排的面数。
pub fn arrangement_faces(n : Int) -> Int {
  n * (n + 1) / 2 + 1
}

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

///| Check whether the arrangement with given slopes is simple. / 判断给定斜率的安排是否为简单安排。
pub fn is_simple_arrangement(slopes : Array[Double]) -> Bool {
  for i in 0..<slopes.length() {
    for j in (i + 1)..<slopes.length() {
      if (slopes[i] - slopes[j]).abs() < 1.0e-10 {
        return false
      }
    }
  }
  true
}
