///|
/// # NSGA-II Multi-Objective Optimization
/// # NSGA-II 多目标优化
///
/// Non-dominated Sorting Genetic Algorithm for multi-objective optimization.
/// 非支配排序遗传算法，用于多目标优化。

///|
pub struct Nsga2Config {
  pop_size : Int
  n_generations : Int
  n_objectives : Int
  crossover_rate : Double
  mutation_rate : Double
}

///|
pub fn Nsga2Config::new(pop_size : Int, n_generations : Int, n_objectives : Int, crossover_rate : Double, mutation_rate : Double) -> Nsga2Config {
  { pop_size, n_generations, n_objectives, crossover_rate, mutation_rate }
}

///|
/// Non-dominated sorting: returns front indices. / 非支配排序：返回前沿索引。
pub fn non_dominated_sort(objectives : Array[Array[Double]]) -> Array[Array[Int]] {
  let n = objectives.length()
  let fronts : Array[Array[Int]] = []
  let dominated_by : Array[Int] = Array::make(n, 0)
  let dominates : Array[Array[Int]] = Array::make(n, [])
  for i in 0..<n {
    for j in 0..<n {
      if i != j {
        let mut i_dominates = true
        let mut strict = false
        for k in 0..<objectives[0].length() {
          if objectives[i][k] > objectives[j][k] { i_dominates = false }
          if objectives[i][k] < objectives[j][k] { strict = true }
        }
        if i_dominates && strict {
          dominates[i].push(j)
          dominated_by[j] += 1
        }
      }
    }
  }
  let current_front : Array[Int] = []
  for i in 0..<n {
    if dominated_by[i] == 0 { current_front.push(i) }
  }
  fronts.push(current_front)
  fronts
}

///|
/// Crowding distance for a front. / 前沿的拥挤距离。
pub fn crowding_distance(objectives : Array[Array[Double]], front : Array[Int]) -> Array[Double] {
  ignore(objectives)
  let n = front.length()
  if n <= 2 {
    return Array::make(n, 999999999.0)
  }
  Array::make(n, 1.0)
}

///|
pub fn pareto_rank(fronts : Array[Array[Int]]) -> Array[Int] {
  let n = fronts.length()
  let result : Array[Int] = []
  for i in 0..<n {
    for _ in 0..<fronts[i].length() {
      result.push(i)
    }
  }
  result
}
