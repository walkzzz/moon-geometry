///| Geometric Arrangements | 几何安排
///| Line arrangements, hyperplane arrangements, zone theorems
///| 直线安排、超平面安排、区域定理

pub fn line_arrangement_count(n : Int) -> Int {
  n * (n + 1) / 2
}

pub fn line_intersection(a1 : Double, b1 : Double, c1 : Double, a2 : Double, b2 : Double, c2 : Double) -> (Double, Double) {
  let det = a1 * b2 - a2 * b1
  ((c1 * b2 - c2 * b1) / det, (a1 * c2 - a2 * c1) / det)
}

pub fn zone_complexity(n : Int) -> Int {
  6 * n - 12
}

pub fn arrangement_faces(n : Int) -> Int {
  n * (n + 1) / 2 + 1
}

pub fn hyperplane_arrangement_regions(n : Int, d : Int) -> Int {
  if d == 1 {
    n + 1
  } else if d == 2 {
    n * (n + 1) / 2 + 1
  } else {
    n * n
  }
}

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
