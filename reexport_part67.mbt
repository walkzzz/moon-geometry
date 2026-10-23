///|
pub type EulerTour = @euler_tour.EulerTour

///|
pub fn build_euler_tour(n : Int, adj : Array[Array[Int]], root : Int) -> EulerTour {
  @euler_tour.build_euler_tour(n, adj, root)
}

///|
pub fn euler_tour_sequence(t : EulerTour) -> Array[Int] {
  @euler_tour.euler_tour_sequence(t)
}

///|
pub fn euler_tour_depths(t : EulerTour) -> Array[Int] {
  @euler_tour.euler_tour_depths(t)
}

///|
pub fn euler_tour_length(t : EulerTour) -> Int {
  @euler_tour.euler_tour_length(t)
}

///|
pub fn euler_tour_first_occurrence(t : EulerTour, v : Int) -> Int {
  @euler_tour.euler_tour_first_occurrence(t, v)
}

///|
pub fn euler_tour_lca(t : EulerTour, u : Int, v : Int) -> Int {
  @euler_tour.euler_tour_lca(t, u, v)
}