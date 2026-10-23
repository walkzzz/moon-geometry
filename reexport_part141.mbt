///|
pub fn sa_rng_next(r : SA_rng) -> Double {
  @simulated_annealing.SA_rng::next(r)
}

///|
pub fn simulated_annealing(
  f : (Array[Double]) -> Double,
  x0 : Array[Double],
  neighbor : (Array[Double], SA_rng) -> Array[Double],
  t0 : Double,
  schedule : CoolingSchedule,
  min_temp : Double,
  max_iter : Int,
  seed : UInt,
) -> SAResult {
  @simulated_annealing.simulated_annealing(f, x0, neighbor, t0, schedule, min_temp, max_iter, seed)
}

///|
pub fn uniform_neighbor(
  x : Array[Double],
  step : Double,
  rng : SA_rng,
) -> Array[Double] {
  @simulated_annealing.uniform_neighbor(x, step, rng)
}

///|
pub fn sa_1d(
  f : (Double) -> Double,
  x0 : Double,
  step : Double,
  t0 : Double,
  cooling_rate : Double,
  max_iter : Int,
  seed : UInt,
) -> Double {
  @simulated_annealing.sa_1d(f, x0, step, t0, cooling_rate, max_iter, seed)
}

///|
pub fn sa_reheat(
  f : (Array[Double]) -> Double,
  x0 : Array[Double],
  neighbor : (Array[Double], SA_rng) -> Array[Double],
  t0 : Double,
  cooling_rate : Double,
  max_iter : Int,
  n_reheats : Int,
  seed : UInt,
) -> SAResult {
  @simulated_annealing.sa_reheat(f, x0, neighbor, t0, cooling_rate, max_iter, n_reheats, seed)
}

// ---------------------------------------------------------------------------
// genetic_algorithm: Genetic algorithm / 遗传算法
// ---------------------------------------------------------------------------

///|
pub type GAConfig = @genetic_algorithm.GAConfig

///|
pub type GAResult = @genetic_algorithm.GAResult