/// |
/// # Simulated Annealing
/// # 模拟退火
///
/// Simulated annealing with Metropolis acceptance criterion and configurable cooling schedules.
/// 模拟退火，使用 Metropolis 接受准则和可配置冷却调度。
///
/// ## Complexity: O(max_iter * cost_of_neighbor)
/// ## 复杂度: O(max_iter * 邻域生成代价)

/// |
/// Cooling schedule type. / 冷却调度类型。
pub(all) enum CoolingSchedule {
  Geometric(Double)
  Linear(Double)
  Logarithmic(Double)
}

/// |
/// Simple LCG random generator for simulated annealing. / 模拟退火用简单线性同余随机生成器。
pub struct SA_rng {
  mut state : UInt
}

/// |
/// Create RNG with seed. / 用种子创建 RNG。
pub fn SA_rng::new(seed : UInt) -> SA_rng {
  { state: seed }
}

/// |
/// Next random Double in [0, 1). / 生成 [0, 1) 中的随机 Double。
pub fn SA_rng::next(r : SA_rng) -> Double {
  r.state = r.state * 1103515245U + 12345U
  (r.state % 1000000U).to_double() / 1000000.0
}

/// |
/// Result of simulated annealing. / 模拟退火结果。
pub struct SAResult {
  x : Array[Double]
  value : Double
  iterations : Int
}

/// |
/// Construct SA result. / 构造模拟退火结果。
pub fn SAResult::new(
  x : Array[Double],
  value : Double,
  iterations : Int,
) -> SAResult {
  { x, value, iterations }
}

/// |
/// Compute temperature at iteration t for given schedule.
/// 计算给定调度在第 t 次迭代时的温度。
fn temperature(
  schedule : CoolingSchedule,
  t0 : Double,
  t : Int,
) -> Double {
  match schedule {
    Geometric(rate) => {
      let mut temp = t0
      for _ in 0..<t {
        temp *= rate
      }
      temp
    }
    Linear(step) => {
      let temp = t0 - step * t.to_double()
      if temp > 0.0 { temp } else { 0.0000001 }
    }
    Logarithmic(c) => {
      c / @math.ln(t.to_double() + 2.0)
    }
  }
}

/// |
/// Simulated annealing optimization.
/// 模拟退火优化。
///
/// # Arguments / 参数
/// - `f`: objective function / 目标函数
/// - `x0`: initial solution / 初始解
/// - `neighbor`: neighbor generation / 邻域生成
/// - `t0`: initial temperature / 初始温度
/// - `schedule`: cooling schedule / 冷却调度
/// - `min_temp`: minimum temperature / 最小温度
/// - `max_iter`: maximum iterations / 最大迭代数
/// - `seed`: random seed / 随机种子
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
  let n = x0.length()
  let rng = SA_rng::new(seed)
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let mut current_val = f(x)
  let best : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    best[i] = x[i]
  }
  let mut best_val = current_val
  let mut iter_done = 0
  for t in 0..<max_iter {
    iter_done = t + 1
    let temp = temperature(schedule, t0, t)
    if temp < min_temp {
      break
    }
    let x_new = neighbor(x, rng)
    let new_val = f(x_new)
    let delta = new_val - current_val
    let accept = if delta < 0.0 {
      true
    } else if temp > 0.0000000001 {
      rng.next() < @math.exp(-delta / temp)
    } else {
      false
    }
    if accept {
      for i in 0..<n {
        x[i] = x_new[i]
      }
      current_val = new_val
      if current_val < best_val {
        for i in 0..<n {
          best[i] = x[i]
        }
        best_val = current_val
      }
    }
  }
  { x: best, value: best_val, iterations: iter_done }
}

/// |
/// Gaussian-like neighbor: perturb each coordinate by uniform random in [-step, step].
/// 高斯式邻域：每个坐标加 [-step, step] 均匀随机扰动。
pub fn uniform_neighbor(
  x : Array[Double],
  step : Double,
  rng : SA_rng,
) -> Array[Double] {
  let n = x.length()
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let r = rng.next() * 2.0 - 1.0
    result[i] = x[i] + step * r
  }
  result
}

/// |
/// 1D simulated annealing convenience wrapper.
/// 一维模拟退火便捷封装。
pub fn sa_1d(
  f : (Double) -> Double,
  x0 : Double,
  step : Double,
  t0 : Double,
  cooling_rate : Double,
  max_iter : Int,
  seed : UInt,
) -> Double {
  let f_wrap = fn(x : Array[Double]) -> Double {
    f(x[0])
  }
  let neighbor = fn(x : Array[Double], rng : SA_rng) -> Array[Double] {
    uniform_neighbor(x, step, rng)
  }
  let result = simulated_annealing(
    f_wrap,
    [x0],
    neighbor,
    t0,
    Geometric(cooling_rate),
    0.0001,
    max_iter,
    seed,
  )
  result.x[0]
}

/// |
/// Reheat: restart annealing from best solution with reset temperature.
/// 重加热：从最优解重启退火并重置温度。
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
  let n = x0.length()
  let best : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    best[i] = x0[i]
  }
  let mut best_val = f(best)
  let mut total_iter = 0
  let mut s = seed
  for _ in 0..<(n_reheats + 1) {
    let result = simulated_annealing(
      f,
      best,
      neighbor,
      t0,
      Geometric(cooling_rate),
      0.0001,
      max_iter,
      s,
    )
    total_iter += result.iterations
    if result.value < best_val {
      best_val = result.value
      for i in 0..<n {
        best[i] = result.x[i]
      }
    }
    s = s + 1U
  }
  { x: best, value: best_val, iterations: total_iter }
}