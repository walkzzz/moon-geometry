/// |
/// # Graph Coloring
/// # 图着色
///
/// Greedy graph coloring algorithm.
/// 贪心图着色算法。
///
/// ## Complexity: O(V + E)
/// ## 复杂度: O(V + E)

/// |
/// Color a graph using greedy algorithm.
/// 使用贪心算法着色图。
///
/// # Arguments / 参数
/// - `n`: number of vertices / 顶点数
/// - `adj`: adjacency list / 邻接表
///
/// Returns color assignment (0-indexed colors).
/// 返回着色方案（0 索引颜色）。
pub fn greedy_color(n : Int, adj : Array[Array[Int]]) -> Array[Int] {
  let colors : Array[Int] = []
  for _ in 0..<n {
    colors.push(-1)
  }
  for v in 0..<n {
    let used : Array[Bool] = []
    for _ in 0..<(n + 1) {
      used.push(false)
    }
    for i in 0..<adj[v].length() {
      let u = adj[v][i]
      if colors[u] >= 0 {
        used[colors[u]] = true
      }
    }
    let mut c = 0
    while c < n && used[c] {
      c += 1
    }
    colors[v] = c
  }
  colors
}

/// |
/// Count the number of distinct colors used.
/// 计算使用的不同颜色数。
pub fn chromatic_number_upper(n : Int, adj : Array[Array[Int]]) -> Int {
  let colors = greedy_color(n, adj)
  let mut max_c = 0
  for i in 0..<n {
    if colors[i] > max_c {
      max_c = colors[i]
    }
  }
  max_c + 1
}

/// |
/// Check if a coloring is valid.
/// 检查着色是否有效。
pub fn is_valid_coloring(n : Int, adj : Array[Array[Int]], colors : Array[Int]) -> Bool {
  for v in 0..<n {
    for i in 0..<adj[v].length() {
      let u = adj[v][i]
      if colors[v] == colors[u] {
        return false
      }
    }
  }
  true
}

/// |
/// Check if graph is bipartite (2-colorable).
/// 检查图是否为二部图（可 2 着色）。
pub fn is_bipartite(n : Int, adj : Array[Array[Int]]) -> Bool {
  let colors : Array[Int] = []
  for _ in 0..<n {
    colors.push(-1)
  }
  for start in 0..<n {
    if colors[start] != -1 {
      continue
    }
    colors[start] = 0
    let queue : Array[Int] = [start]
    while queue.length() > 0 {
      let v = queue.remove(0)
      ignore(queue.length())
      for i in 0..<adj[v].length() {
        let u = adj[v][i]
        if colors[u] == -1 {
          colors[u] = 1 - colors[v]
          queue.push(u)
        } else if colors[u] == colors[v] {
          return false
        }
      }
    }
  }
  true
}