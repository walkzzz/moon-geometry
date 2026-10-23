///|
pub fn interior_point(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> IPResult {
  @interior_point.interior_point(a, b, c, max_iter)
}

///|
pub fn interior_point_max(
  a : Array[Array[Double]],
  b : Array[Double],
  c : Array[Double],
  max_iter : Int,
) -> IPResult {
  @interior_point.interior_point_max(a, b, c, max_iter)
}

///|
pub fn duality_gap(x : Array[Double], s : Array[Double], n : Int) -> Double {
  @interior_point.duality_gap(x, s, n)
}

// ---------------------------------------------------------------------------
// simulated_annealing: Simulated annealing / 模拟退火
// ---------------------------------------------------------------------------

///|
pub type CoolingSchedule = @simulated_annealing.CoolingSchedule

///|
pub type SAResult = @simulated_annealing.SAResult

///|
pub type SA_rng = @simulated_annealing.SA_rng

///|
pub fn sa_rng_new(seed : UInt) -> SA_rng {
  @simulated_annealing.SA_rng::new(seed)
}