/// |
/// # Graph Cut
/// # 图割
///
/// Min-cut / max-flow using Ford-Fulkerson method.
/// 使用 Ford-Fulkerson 方法的最小割/最大流。
///
/// ## Complexity: O(V × E × max_flow)
/// ## 复杂度: O(V × E × max_flow)

/// |
/// Compute max flow from source to sink.
/// 计算从源点到汇点的最大流。
///
/// # Arguments / 参数
/// - `n`: number of vertices / 顶点数
/// - `capacity`: capacity matrix (n × n) / 容量矩阵（n × n）
/// - `src`: source / 源点
/// - `sink`: sink / 汇点
pub fn max_flow(
  n : Int,
  capacity : Array[Array[Double]],
  src : Int,
  sink : Int,
) -> Double {
  let mut flow = 0.0
  let residual : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(capacity[i][j])
    }
    residual.push(row)
  }
  let mut iter = 0
  while iter < n * n * 100 {
    let path = bfs_path(n, residual, src, sink)
    if path.is_empty() {
      break
    }
    let mut min_cap = 1000000.0
    for i in 0..<(path.length() - 1) {
      let cap = residual[path[i]][path[i + 1]]
      if cap < min_cap {
        min_cap = cap
      }
    }
    for i in 0..<(path.length() - 1) {
      residual[path[i]][path[i + 1]] -= min_cap
      residual[path[i + 1]][path[i]] += min_cap
    }
    flow += min_cap
    iter += 1
  }
  flow
}

/// |
/// Compute min cut value (equals max flow).
/// 计算最小割值（等于最大流）。
pub fn min_cut(
  n : Int,
  capacity : Array[Array[Double]],
  src : Int,
  sink : Int,
) -> Double {
  max_flow(n, capacity, src, sink)
}

/// |
/// Find min cut partition (S, T).
/// 查找最小割划分 (S, T)。
///
/// Returns vertices reachable from source in residual graph.
/// 返回残量图中从源点可达的顶点。
pub fn min_cut_partition(
  n : Int,
  capacity : Array[Array[Double]],
  src : Int,
  sink : Int,
) -> Array[Int] {
  let _ = max_flow(n, capacity, src, sink)
  let visited : Array[Bool] = []
  for _ in 0..<n {
    visited.push(false)
  }
  visited[src] = true
  let queue : Array[Int] = [src]
  while queue.length() > 0 {
    let v = queue.remove(0)
    ignore(queue.length())
    for u in 0..<n {
      if !visited[u] && capacity[v][u] > 0.0 {
        visited[u] = true
        queue.push(u)
      }
    }
  }
  let result : Array[Int] = []
  for i in 0..<n {
    if visited[i] {
      result.push(i)
    }
  }
  result
}

fn bfs_path(
  n : Int,
  residual : Array[Array[Double]],
  src : Int,
  sink : Int,
) -> Array[Int] {
  let visited : Array[Bool] = []
  let prev : Array[Int] = []
  for _ in 0..<n {
    visited.push(false)
    prev.push(-1)
  }
  visited[src] = true
  let queue : Array[Int] = [src]
  while queue.length() > 0 {
    let v = queue.remove(0)
    ignore(queue.length())
    if v == sink {
      let path : Array[Int] = []
      let mut cur = sink
      while cur != -1 {
        path.insert(0, cur)
        cur = prev[cur]
      }
      return path
    }
    for u in 0..<n {
      if !visited[u] && residual[v][u] > 0.0000000001 {
        visited[u] = true
        prev[u] = v
        queue.push(u)
      }
    }
  }
  []
}