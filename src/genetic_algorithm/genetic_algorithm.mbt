/// |
/// # Genetic Algorithm
/// # 遗传算法
///
/// Real-coded genetic algorithm with tournament selection, arithmetic crossover, uniform mutation, elitism.
/// 实数编码遗传算法，锦标赛选择、算术交叉、均匀变异、精英保留。
///
/// ## Complexity: O(generations * pop_size * n_genes)
/// ## 复杂度: O(世代数 * 种群大小 * 基因数)

/// |
/// GA configuration. / 遗传算法配置。
pub struct GAConfig {
  pop_size : Int
  n_genes : Int
  crossover_rate : Double
  mutation_rate : Double
  elite_count : Int
  lo : Array[Double]
  hi : Array[Double]
}

/// |
/// Construct GA config. / 构造遗传算法配置。
pub fn GAConfig::new(
  pop_size : Int,
  n_genes : Int,
  crossover_rate : Double,
  mutation_rate : Double,
  elite_count : Int,
  lo : Array[Double],
  hi : Array[Double],
) -> GAConfig {
  { pop_size, n_genes, crossover_rate, mutation_rate, elite_count, lo, hi }
}

/// |
/// Result of genetic algorithm. / 遗传算法结果。
pub struct GAResult {
  x : Array[Double]
  fitness : Double
  generations : Int
}

/// |
/// Construct GA result. / 构造遗传算法结果。
pub fn GAResult::new(
  x : Array[Double],
  fitness : Double,
  generations : Int,
) -> GAResult {
  { x, fitness, generations }
}

/// |
/// Simple LCG random generator. / 简单线性同余随机生成器。
priv struct GA_rng {
  mut state : UInt
}

fn GA_rng::new(seed : UInt) -> GA_rng {
  { state: seed }
}

fn GA_rng::next(r : GA_rng) -> Double {
  r.state = r.state * 1103515245U + 12345U
  (r.state % 1000000U).to_double() / 1000000.0
}

/// |
/// Tournament selection: pick best of k random individuals.
/// 锦标赛选择：从 k 个随机个体中选最优。
fn tournament_select(
  pop : Array[Array[Double]],
  fitness : Array[Double],
  k : Int,
  rng : GA_rng,
) -> Int {
  let n = pop.length()
  let mut best = rng.next().to_int() % n
  if best < 0 {
    best = 0
  }
  let mut best_fit = fitness[best]
  for _ in 1..<k {
    let idx = (rng.next().to_int() % n).abs()
    let safe_idx = if idx < n { idx } else { n - 1 }
    if fitness[safe_idx] > best_fit {
      best_fit = fitness[safe_idx]
      best = safe_idx
    }
  }
  best
}

/// |
/// Arithmetic crossover: child = alpha * p1 + (1 - alpha) * p2.
/// 算术交叉。
fn crossover(
  p1 : Array[Double],
  p2 : Array[Double],
  alpha : Double,
  n : Int,
) -> (Array[Double], Array[Double]) {
  let c1 : Array[Double] = Array::make(n, 0.0)
  let c2 : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    c1[i] = alpha * p1[i] + (1.0 - alpha) * p2[i]
    c2[i] = (1.0 - alpha) * p1[i] + alpha * p2[i]
  }
  (c1, c2)
}

/// |
/// Uniform mutation: replace gene with random value in [lo, hi].
/// 均匀变异。
fn mutate(
  x : Array[Double],
  config : GAConfig,
  rng : GA_rng,
) -> Array[Double] {
  let n = config.n_genes
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    if rng.next() < config.mutation_rate {
      result[i] = config.lo[i] + rng.next() * (config.hi[i] - config.lo[i])
    } else {
      result[i] = x[i]
    }
  }
  result
}

/// |
/// Clamp individual to bounds. / 将个体限制在边界内。
fn clamp_individual(
  x : Array[Double],
  config : GAConfig,
) -> Array[Double] {
  let n = config.n_genes
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let v = x[i]
    let lo = config.lo[i]
    let hi = config.hi[i]
    result[i] = if v < lo { lo } else if v > hi { hi } else { v }
  }
  result
}

/// |
/// Genetic algorithm: maximize fitness(x). Returns best individual found.
/// 遗传算法：最大化适应度。返回找到的最优个体。
pub fn genetic_algorithm(
  fitness : (Array[Double]) -> Double,
  config : GAConfig,
  max_generations : Int,
  seed : UInt,
) -> GAResult {
  let n = config.n_genes
  let ps = config.pop_size
  let rng = GA_rng::new(seed)
  let pop : Array[Array[Double]] = []
  for _ in 0..<ps {
    pop.push(Array::make(n, 0.0))
  }
  for i in 0..<ps {
    for j in 0..<n {
      pop[i][j] = config.lo[j] + rng.next() * (config.hi[j] - config.lo[j])
    }
  }
  let best_x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    best_x[i] = pop[0][i]
  }
  let mut best_fit = fitness(pop[0])
  let mut gen_done = 0
  for gen in 0..<max_generations {
    gen_done = gen + 1
    let fit : Array[Double] = Array::make(ps, 0.0)
    for i in 0..<ps {
      fit[i] = fitness(pop[i])
      if fit[i] > best_fit {
        best_fit = fit[i]
        for j in 0..<n {
          best_x[j] = pop[i][j]
        }
      }
    }
    let indices : Array[Int] = Array::make(ps, 0)
    for i in 0..<ps {
      indices[i] = i
    }
    for i in 0..<(ps - 1) {
      for j in (i + 1)..<ps {
        if fit[indices[j]] > fit[indices[i]] {
          let tmp = indices[i]
          indices[i] = indices[j]
          indices[j] = tmp
        }
      }
    }
    let new_pop : Array[Array[Double]] = []
    for _ in 0..<ps {
      new_pop.push(Array::make(n, 0.0))
    }
    let elite = config.elite_count
    for e in 0..<elite {
      if e < ps {
        for j in 0..<n {
          new_pop[e][j] = pop[indices[e]][j]
        }
      }
    }
    let mut offspring = elite
    while offspring < ps {
      let p1 = tournament_select(pop, fit, 3, rng)
      let p2 = tournament_select(pop, fit, 3, rng)
      let (c1, c2) = if rng.next() < config.crossover_rate {
        let alpha = rng.next()
        crossover(pop[p1], pop[p2], alpha, n)
      } else {
        let c1 : Array[Double] = Array::make(n, 0.0)
        let c2 : Array[Double] = Array::make(n, 0.0)
        for j in 0..<n {
          c1[j] = pop[p1][j]
          c2[j] = pop[p2][j]
        }
        (c1, c2)
      }
      let m1 = mutate(c1, config, rng)
      let m2 = mutate(c2, config, rng)
      let cl1 = clamp_individual(m1, config)
      let cl2 = clamp_individual(m2, config)
      if offspring < ps {
        for j in 0..<n {
          new_pop[offspring][j] = cl1[j]
        }
        offspring += 1
      }
      if offspring < ps {
        for j in 0..<n {
          new_pop[offspring][j] = cl2[j]
        }
        offspring += 1
      }
    }
    for i in 0..<ps {
      for j in 0..<n {
        pop[i][j] = new_pop[i][j]
      }
    }
  }
  let fit : Array[Double] = Array::make(ps, 0.0)
  for i in 0..<ps {
    fit[i] = fitness(pop[i])
    if fit[i] > best_fit {
      best_fit = fit[i]
      for j in 0..<n {
        best_x[j] = pop[i][j]
      }
    }
  }
  { x: best_x, fitness: best_fit, generations: gen_done }
}

/// |
/// Genetic algorithm for minimization: minimizes f(x).
/// 遗传算法用于最小化：最小化 f(x)。
pub fn ga_minimize(
  f : (Array[Double]) -> Double,
  config : GAConfig,
  max_generations : Int,
  seed : UInt,
) -> GAResult {
  let neg_f = fn(x : Array[Double]) -> Double {
    -f(x)
  }
  let result = genetic_algorithm(neg_f, config, max_generations, seed)
  { x: result.x, fitness: -result.fitness, generations: result.generations }
}

/// |
/// 1D genetic algorithm convenience wrapper for minimization.
/// 一维遗传算法便捷封装（最小化）。
pub fn ga_1d(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  pop_size : Int,
  max_generations : Int,
  seed : UInt,
) -> Double {
  let f_wrap = fn(x : Array[Double]) -> Double {
    f(x[0])
  }
  let config = GAConfig::new(pop_size, 1, 0.8, 0.1, 2, [lo], [hi])
  let result = ga_minimize(f_wrap, config, max_generations, seed)
  result.x[0]
}
/// |
/// Population standard deviation of fitness values. / 种群适应度的标准差。
///
/// Measures population diversity for convergence monitoring.
/// 度量种群多样性，用于收敛监测。
pub fn ga_population_std(fitness : Array[Double]) -> Double {
  let n = fitness.length()
  if n < 2 {
    return 0.0
  }
  let mut mean = 0.0
  for i in 0..<n {
    mean += fitness[i]
  }
  mean = mean / n.to_double()
  let mut variance = 0.0
  for i in 0..<n {
    let d = fitness[i] - mean
    variance += d * d
  }
  variance = variance / (n - 1).to_double()
  (variance).sqrt()
}

/// |
/// Exponential decay mutation rate schedule. / 指数衰减变异率调度。
///
/// rate = initial * exp(-decay * generation). Standard GA technique.
/// rate = initial * exp(-decay * generation)。标准遗传算法技术。
pub fn ga_mutation_schedule(
  initial_rate : Double,
  decay : Double,
  generation : Int,
) -> Double {
  initial_rate * @math.exp(-decay * generation.to_double())
}