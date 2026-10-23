/// |
/// # Particle Swarm Optimization
/// # 粒子群优化
///
/// PSO with global and local (ring) topology, inertia weight, cognitive and social coefficients.
/// 粒子群优化，全局和局部（环形）拓扑、惯性权重、认知和社会系数。
///
/// ## Complexity: O(iter * n_particles * n_dims)
/// ## 复杂度: O(迭代数 * 粒子数 * 维度)

///|
/// |
/// PSO configuration. / 粒子群优化配置。
pub struct PSOConfig {
  n_particles : Int32
  n_dims : Int32
  w : Double
  c1 : Double
  c2 : Double
  lo : Array[Double]
  hi : Array[Double]
  v_max : Double
}

///|
/// |
/// Construct PSO config. / 构造粒子群优化配置。
pub fn PSOConfig::new(
  n_particles : Int32,
  n_dims : Int32,
  w : Double,
  c1 : Double,
  c2 : Double,
  lo : Array[Double],
  hi : Array[Double],
  v_max : Double,
) -> PSOConfig {
  { n_particles, n_dims, w, c1, c2, lo, hi, v_max, }
}

///|
/// |
/// Result of PSO. / 粒子群优化结果。
pub struct PSOResult {
  x : Array[Double]
  value : Double
  iterations : Int32
}

///|
/// |
/// Construct PSO result. / 构造粒子群优化结果。
pub fn PSOResult::new(
  x : Array[Double],
  value : Double,
  iterations : Int32,
) -> PSOResult {
  { x, value, iterations, }
}

///|
/// |
/// Topology type. / 拓扑类型。
pub(all) enum PSOTopology {
  Global
  Local(Int32)
}

///|
/// |
/// Simple LCG random generator. / 简单线性同余随机生成器。
priv struct PSO_rng {
  mut state : UInt32
}

///|
fn PSO_rng::new(seed : UInt32) -> PSO_rng {
  { state: seed, }
}

///|
fn PSO_rng::next(r : PSO_rng) -> Double {
  r.state = r.state * 1103515245U + 12345U
  (r.state % 1000000U).to_double() / 1000000.0
}

///|
/// |
/// Clamp value to [lo, hi]. / 将值限制在 [lo, hi]。
fn clamp(v : Double, lo : Double, hi : Double) -> Double {
  if v < lo {
    lo
  } else if v > hi {
    hi
  } else {
    v
  }
}

///|
/// |
/// Find best neighbor index for local topology (ring).
/// 局部拓扑（环形）中找最优邻居索引。
fn best_neighbor(
  idx : Int32,
  n_particles : Int32,
  neighborhood : Int32,
  pbest_vals : Array[Double],
) -> Int32 {
  let mut best = idx
  let mut best_val = pbest_vals[idx]
  for d in 1..<(neighborhood + 1) {
    let nb1 = (idx + d) % n_particles
    let nb2 = (idx - d + n_particles) % n_particles
    if pbest_vals[nb1] < best_val {
      best_val = pbest_vals[nb1]
      best = nb1
    }
    if pbest_vals[nb2] < best_val {
      best_val = pbest_vals[nb2]
      best = nb2
    }
  }
  best
}

///|
/// |
/// Particle swarm optimization for minimization.
/// 粒子群优化（最小化）。
pub fn pso(
  f : (Array[Double]) -> Double,
  config : PSOConfig,
  topology : PSOTopology,
  max_iter : Int32,
  seed : UInt32,
) -> PSOResult {
  let np = config.n_particles
  let nd = config.n_dims
  let rng = PSO_rng::new(seed)
  let positions : Array[Array[Double]] = []
  for _ in 0..<np {
    positions.push(Array::make(nd, 0.0))
  }
  let velocities : Array[Array[Double]] = []
  for _ in 0..<np {
    velocities.push(Array::make(nd, 0.0))
  }
  let pbest : Array[Array[Double]] = []
  for _ in 0..<np {
    pbest.push(Array::make(nd, 0.0))
  }
  let pbest_vals : Array[Double] = Array::make(np, 0.0)
  for i in 0..<np {
    for j in 0..<nd {
      let range = config.hi[j] - config.lo[j]
      positions[i][j] = config.lo[j] + rng.next() * range
      velocities[i][j] = (rng.next() * 2.0 - 1.0) * config.v_max
      pbest[i][j] = positions[i][j]
    }
    pbest_vals[i] = f(positions[i])
  }
  let gbest : Array[Double] = Array::make(nd, 0.0)
  let mut gbest_val = pbest_vals[0]
  for j in 0..<nd {
    gbest[j] = pbest[0][j]
  }
  for i in 1..<np {
    if pbest_vals[i] < gbest_val {
      gbest_val = pbest_vals[i]
      for j in 0..<nd {
        gbest[j] = pbest[i][j]
      }
    }
  }
  let mut iter_done = 0
  for iter in 0..<max_iter {
    iter_done = iter + 1
    for i in 0..<np {
      let neighbor_best = match topology {
        Global => gbest
        Local(nb) => {
          let bi = best_neighbor(i, np, nb, pbest_vals)
          pbest[bi]
        }
      }
      for j in 0..<nd {
        let r1 = rng.next()
        let r2 = rng.next()
        let cog = config.c1 * r1 * (pbest[i][j] - positions[i][j])
        let soc = config.c2 * r2 * (neighbor_best[j] - positions[i][j])
        velocities[i][j] = config.w * velocities[i][j] + cog + soc
        let vm = config.v_max
        velocities[i][j] = clamp(velocities[i][j], -vm, vm)
        positions[i][j] += velocities[i][j]
        positions[i][j] = clamp(positions[i][j], config.lo[j], config.hi[j])
      }
      let val = f(positions[i])
      if val < pbest_vals[i] {
        pbest_vals[i] = val
        for j in 0..<nd {
          pbest[i][j] = positions[i][j]
        }
        if val < gbest_val {
          gbest_val = val
          for j in 0..<nd {
            gbest[j] = positions[i][j]
          }
        }
      }
    }
  }
  { x: gbest, value: gbest_val, iterations: iter_done, }
}

///|
/// |
/// PSO with decreasing inertia weight (common variant).
/// 惯性权重递减的粒子群优化（常见变体）。
pub fn pso_decreasing_w(
  f : (Array[Double]) -> Double,
  config : PSOConfig,
  w_max : Double,
  w_min : Double,
  topology : PSOTopology,
  max_iter : Int32,
  seed : UInt32,
) -> PSOResult {
  let np = config.n_particles
  let nd = config.n_dims
  let rng = PSO_rng::new(seed)
  let positions : Array[Array[Double]] = []
  for _ in 0..<np {
    positions.push(Array::make(nd, 0.0))
  }
  let velocities : Array[Array[Double]] = []
  for _ in 0..<np {
    velocities.push(Array::make(nd, 0.0))
  }
  let pbest : Array[Array[Double]] = []
  for _ in 0..<np {
    pbest.push(Array::make(nd, 0.0))
  }
  let pbest_vals : Array[Double] = Array::make(np, 0.0)
  for i in 0..<np {
    for j in 0..<nd {
      let range = config.hi[j] - config.lo[j]
      positions[i][j] = config.lo[j] + rng.next() * range
      velocities[i][j] = (rng.next() * 2.0 - 1.0) * config.v_max
      pbest[i][j] = positions[i][j]
    }
    pbest_vals[i] = f(positions[i])
  }
  let gbest : Array[Double] = Array::make(nd, 0.0)
  let mut gbest_val = pbest_vals[0]
  for j in 0..<nd {
    gbest[j] = pbest[0][j]
  }
  for i in 1..<np {
    if pbest_vals[i] < gbest_val {
      gbest_val = pbest_vals[i]
      for j in 0..<nd {
        gbest[j] = pbest[i][j]
      }
    }
  }
  let mut iter_done = 0
  for iter in 0..<max_iter {
    iter_done = iter + 1
    let w = w_max - (w_max - w_min) * iter.to_double() / max_iter.to_double()
    for i in 0..<np {
      let neighbor_best = match topology {
        Global => gbest
        Local(nb) => {
          let bi = best_neighbor(i, np, nb, pbest_vals)
          pbest[bi]
        }
      }
      for j in 0..<nd {
        let r1 = rng.next()
        let r2 = rng.next()
        let cog = config.c1 * r1 * (pbest[i][j] - positions[i][j])
        let soc = config.c2 * r2 * (neighbor_best[j] - positions[i][j])
        velocities[i][j] = w * velocities[i][j] + cog + soc
        let vm = config.v_max
        velocities[i][j] = clamp(velocities[i][j], -vm, vm)
        positions[i][j] += velocities[i][j]
        positions[i][j] = clamp(positions[i][j], config.lo[j], config.hi[j])
      }
      let val = f(positions[i])
      if val < pbest_vals[i] {
        pbest_vals[i] = val
        for j in 0..<nd {
          pbest[i][j] = positions[i][j]
        }
        if val < gbest_val {
          gbest_val = val
          for j in 0..<nd {
            gbest[j] = positions[i][j]
          }
        }
      }
    }
  }
  { x: gbest, value: gbest_val, iterations: iter_done, }
}

///|
/// |
/// 1D PSO convenience wrapper for minimization.
/// 一维粒子群优化便捷封装（最小化）。
pub fn pso_1d(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_particles : Int32,
  max_iter : Int32,
  seed : UInt32,
) -> Double {
  let f_wrap = fn(x : Array[Double]) -> Double { f(x[0]) }
  let config = PSOConfig::new(
    n_particles,
    1,
    0.7,
    1.5,
    1.5,
    [lo],
    [hi],
    (hi - lo) * 0.2,
  )
  let result = pso(f_wrap, config, Global, max_iter, seed)
  result.x[0]
}

///|
/// |
/// Swarm radius: standard deviation of particle positions in one dimension.
/// 粒子群半径：一维粒子位置的标准差。
///
/// Measures swarm convergence. / 度量粒子群收敛性。
pub fn pso_swarm_radius(positions : Array[Double]) -> Double {
  let n = positions.length()
  if n < 2 {
    return 0.0
  }
  let mut mean = 0.0
  for i in 0..<n {
    mean += positions[i]
  }
  mean = mean / n.to_double()
  let mut variance = 0.0
  for i in 0..<n {
    let d = positions[i] - mean
    variance += d * d
  }
  variance = variance / (n - 1).to_double()
  variance.sqrt()
}

///|
/// |
/// Exponential decay inertia weight schedule. / 指数衰减惯性权重调度。
///
/// w = w_max * exp(-decay * iter). Standard PSO technique.
/// w = w_max * exp(-decay * iter)。标准粒子群技术。
pub fn pso_inertia_schedule(
  w_max : Double,
  decay : Double,
  iteration : Int32,
) -> Double {
  w_max * @math.exp(-decay * iteration.to_double())
}
