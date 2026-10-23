///|
/// Check if the Euler tour is valid (starts and ends at root). / 检查欧拉回路是否有效（起点和终点为根）。
pub fn euler_tour_is_valid(tour : EulerTour) -> Bool {
  tour.tour.length() > 0 && tour.tour[0] == tour.tour[tour.tour.length() - 1]
}