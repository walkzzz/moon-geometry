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
