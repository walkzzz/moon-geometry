///|
pub fn ga_config_new(
  pop_size : Int,
  n_genes : Int,
  crossover_rate : Double,
  mutation_rate : Double,
  elite_count : Int,
  lo : Array[Double],
  hi : Array[Double],
) -> GAConfig {
  @genetic_algorithm.GAConfig::new(pop_size, n_genes, crossover_rate, mutation_rate, elite_count, lo, hi)
}

///|
pub fn ga_result_new(
  x : Array[Double],
  fitness : Double,
  generations : Int,
) -> GAResult {
  @genetic_algorithm.GAResult::new(x, fitness, generations)
}

///|
pub fn genetic_algorithm(
  fitness : (Array[Double]) -> Double,
  config : GAConfig,
  max_generations : Int,
  seed : UInt,
) -> GAResult {
  @genetic_algorithm.genetic_algorithm(fitness, config, max_generations, seed)
}

///|
pub fn ga_minimize(
  f : (Array[Double]) -> Double,
  config : GAConfig,
  max_generations : Int,
  seed : UInt,
) -> GAResult {
  @genetic_algorithm.ga_minimize(f, config, max_generations, seed)
}

///|
pub fn ga_1d(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  pop_size : Int,
  max_generations : Int,
  seed : UInt,
) -> Double {
  @genetic_algorithm.ga_1d(f, lo, hi, pop_size, max_generations, seed)
}

pub fn ga_population_std(fitness : Array[Double]) -> Double {
  @genetic_algorithm.ga_population_std(fitness)
}

pub fn ga_mutation_schedule(
  initial_rate : Double,
  decay : Double,
  generation : Int,
) -> Double {
  @genetic_algorithm.ga_mutation_schedule(initial_rate, decay, generation)
}

// ---------------------------------------------------------------------------
// pso: Particle swarm optimization / 粒子群优化
// ---------------------------------------------------------------------------

///|
pub type PSOConfig = @pso.PSOConfig

///|
pub type PSOResult = @pso.PSOResult