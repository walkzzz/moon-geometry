///|
/// A Morse cell: the stable or unstable manifold of a critical point. / Morse 单元：临界点的稳定或不稳定流形。
pub struct MorseCell {
  critical_idx : Int
  dimension : Int
  simplices : Array[Int]
}

///|
/// Construct a Morse cell. / 构造 Morse 单元。
pub fn MorseCell::new(
  critical_idx : Int,
  dimension : Int,
  simplices : Array[Int],
) -> MorseCell {
  { critical_idx, dimension, simplices }
}

///|
/// Get the number of simplices in the cell. / 获取单元中单纯形数量。
pub fn MorseCell::simplex_count(mc : MorseCell) -> Int {
  mc.simplices.length()
}

///|
/// Morse complex: stable and unstable manifolds of a Morse function. / Morse 复形：Morse 函数的稳定和不稳定流形。
pub struct MorseComplex {
  values : Array[Double]
  critical_indices : Array[Int]
  stable_cells : Array[MorseCell]
  unstable_cells : Array[MorseCell]
}

///|
/// Construct an empty Morse complex. / 构造空的 Morse 复形。
pub fn MorseComplex::new() -> MorseComplex {
  { values: [], critical_indices: [], stable_cells: [], unstable_cells: [] }
}

///|
/// Get the number of critical points. / 获取临界点数量。
pub fn MorseComplex::critical_count(mc : MorseComplex) -> Int {
  mc.critical_indices.length()
}

///|
/// Build adjacency list from edge list. / 由边列表构建邻接表。
fn build_adjacency(
  n : Int,
  edges : Array[(Int, Int)],
) -> Array[Array[Int]] {
  let adj = Array::make(n, [])
  for e in edges {
    adj[e.0].push(e.1)
    adj[e.1].push(e.0)
  }
  adj
}

///|
/// Find the steepest descent neighbor. / 寻找最陡下降邻居。
fn steepest_descent(
  v : Int,
  adj : Array[Array[Int]],
  values : Array[Double],
) -> Int {
  let mut best = -1
  let mut best_val = values[v]
  for j in adj[v] {
    if values[j] < best_val - 0.0000000001 {
      best_val = values[j]
      best = j
    }
  }
  best
}

///|
/// Find the steepest ascent neighbor. / 寻找最陡上升邻居。
fn steepest_ascent(
  v : Int,
  adj : Array[Array[Int]],
  values : Array[Double],
) -> Int {
  let mut best = -1
  let mut best_val = values[v]
  for j in adj[v] {
    if values[j] > best_val + 0.0000000001 {
      best_val = values[j]
      best = j
    }
  }
  best
}

///|
/// Find critical points (local minima and maxima). / 寻找临界点（局部极小和极大）。
fn find_critical_points(
  values : Array[Double],
  adj : Array[Array[Int]],
) -> Array[Int] {
  let critical : Array[Int] = []
  for i in 0..<values.length() {
    let mut is_min = true
    let mut is_max = true
    let mut lower_count = 0
    let mut upper_count = 0
    for j in adj[i] {
      if values[j] < values[i] - 0.0000000001 {
        is_min = false
        lower_count += 1
      }
      if values[j] > values[i] + 0.0000000001 {
        is_max = false
        upper_count += 1
      }
    }
    if is_min || is_max {
      critical.push(i)
    }
    if lower_count >= 2 && upper_count >= 1 {
      critical.push(i)
    }
    if upper_count >= 2 && lower_count >= 1 {
      critical.push(i)
    }
  }
  critical
}

///|
/// Compute the stable manifold of a critical point (descend to minimum). / 计算临界点的稳定流形（下降至极小值）。
fn compute_stable_manifold(
  critical : Int,
  values : Array[Double],
  adj : Array[Array[Int]],
) -> Array[Int] {
  let manifold : Array[Int] = []
  for v in 0..<values.length() {
    let mut curr = v
    let mut steps = 0
    let max_steps = values.length()
    while steps < max_steps {
      if curr == critical {
        manifold.push(v)
        break
      }
      let next = steepest_descent(curr, adj, values)
      if next == -1 {
        if curr == critical {
          manifold.push(v)
        }
        break
      }
      curr = next
      steps += 1
    }
  }
  manifold
}

///|
/// Compute the unstable manifold of a critical point (ascend to maximum). / 计算临界点的不稳定流形（上升至极大值）。
fn compute_unstable_manifold(
  critical : Int,
  values : Array[Double],
  adj : Array[Array[Int]],
) -> Array[Int] {
  let manifold : Array[Int] = []
  for v in 0..<values.length() {
    let mut curr = v
    let mut steps = 0
    let max_steps = values.length()
    while steps < max_steps {
      if curr == critical {
        manifold.push(v)
        break
      }
      let next = steepest_ascent(curr, adj, values)
      if next == -1 {
        if curr == critical {
          manifold.push(v)
        }
        break
      }
      curr = next
      steps += 1
    }
  }
  manifold
}

///|
/// Compute the Morse complex of a scalar field. / 计算标量场的 Morse 复形。
pub fn morse_complex(
  values : Array[Double],
  edges : Array[(Int, Int)],
) -> MorseComplex {
  let n = values.length()
  if n == 0 {
    return { values: [], critical_indices: [], stable_cells: [], unstable_cells: [] }
  }
  let adj = build_adjacency(n, edges)
  let critical = find_critical_points(values, adj)
  let stable_cells : Array[MorseCell] = []
  let unstable_cells : Array[MorseCell] = []
  for c in critical {
    let is_min = is_minimum(c, adj, values)
    let is_max = is_maximum(c, adj, values)
    if is_min {
      let sm = compute_stable_manifold(c, values, adj)
      stable_cells.push({ critical_idx: c, dimension: 0, simplices: sm })
    }
    if is_max {
      let um = compute_unstable_manifold(c, values, adj)
      unstable_cells.push({ critical_idx: c, dimension: 0, simplices: um })
    }
  }
  { values: values.copy(), critical_indices: critical.copy(), stable_cells, unstable_cells }
}

fn is_minimum(
  v : Int,
  adj : Array[Array[Int]],
  values : Array[Double],
) -> Bool {
  for j in adj[v] {
    if values[j] < values[v] - 0.0000000001 {
      return false
    }
  }
  true
}

fn is_maximum(
  v : Int,
  adj : Array[Array[Int]],
  values : Array[Double],
) -> Bool {
  for j in adj[v] {
    if values[j] > values[v] + 0.0000000001 {
      return false
    }
  }
  true
}

///|
/// Get the stable manifold of a critical point by index. / 按索引获取临界点的稳定流形。
pub fn stable_manifold(
  mc : MorseComplex,
  critical_idx : Int,
) -> MorseCell {
  for c in mc.stable_cells {
    if c.critical_idx == critical_idx {
      return c
    }
  }
  { critical_idx, dimension: 0, simplices: [] }
}

///|
/// Get the unstable manifold of a critical point by index. / 按索引获取临界点的不稳定流形。
pub fn unstable_manifold(
  mc : MorseComplex,
  critical_idx : Int,
) -> MorseCell {
  for c in mc.unstable_cells {
    if c.critical_idx == critical_idx {
      return c
    }
  }
  { critical_idx, dimension: 0, simplices: [] }
}

///|
/// Count critical points in the Morse complex. / 计算 Morse 复形中临界点数。
pub fn critical_point_count(mc : MorseComplex) -> Int {
  mc.critical_indices.length()
}