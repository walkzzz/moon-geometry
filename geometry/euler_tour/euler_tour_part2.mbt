///|
/// Find the first occurrence of a vertex in the tour. / 在回路中查找顶点的首次出现位置。
pub fn euler_tour_first_occurrence(
  tour : EulerTour,
  v : Int,
) -> Int {
  for i in 0..<tour.tour.length() {
    if tour.tour[i] == v {
      return i
    }
  }
  -1
}
