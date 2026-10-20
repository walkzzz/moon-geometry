/// |
/// # Minimum Spanning Tree (Kruskal's Algorithm)
/// # 最小生成树（Kruskal 算法）
///
/// Find minimum spanning tree using Kruskal's algorithm with union-find.
/// 使用 Kruskal 算法和并查集查找最小生成树。
///
/// ## Complexity: O(E log E)
/// ## 复杂度: O(E log E)

/// |
/// Weighted edge.
/// 加权边。
pub struct WEdge {
  u : Int
  v : Int
  w : Double
}

pub fn WEdge::new(u : Int, v : Int, w : Double) -> WEdge {
  { u, v, w }
}

/// |
/// Find MST using Kruskal's algorithm.
/// 使用 Kruskal 算法查找 MST。
///
/// # Arguments / 参数
/// - `n`: number of vertices / 顶点数
/// - `edges`: all edges / 所有边
///
/// Returns MST edges.
/// 返回 MST 边集。
pub fn kruskal_mst(n : Int, edges : Array[WEdge]) -> Array[WEdge] {
  let sorted = edges.copy()
  sorted.sort_by(fn(a, b) {
    if a.w < b.w {
      -1
    } else if a.w > b.w {
      1
    } else {
      0
    }
  })
  let parent : Array[Int] = []
  for i in 0..<n {
    parent.push(i)
  }
  let result : Array[WEdge] = []
  for i in 0..<sorted.length() {
    let e = sorted[i]
    let ru = find(parent, e.u)
    let rv = find(parent, e.v)
    if ru != rv {
      parent[ru] = rv
      result.push(e)
      if result.length() == n - 1 {
        break
      }
    }
  }
  result
}

/// |
/// Compute total weight of MST.
/// 计算 MST 总权重。
pub fn mst_weight(n : Int, edges : Array[WEdge]) -> Double {
  let mst = kruskal_mst(n, edges)
  let mut sum = 0.0
  for i in 0..<mst.length() {
    sum += mst[i].w
  }
  sum
}

/// |
/// Count edges in MST.
/// 计算 MST 中的边数。
pub fn mst_edge_count(n : Int, edges : Array[WEdge]) -> Int {
  kruskal_mst(n, edges).length()
}

/// |
/// Check if the graph is connected (MST has n-1 edges).
/// 检查图是否连通（MST 有 n-1 条边）。
pub fn is_connected(n : Int, edges : Array[WEdge]) -> Bool {
  mst_edge_count(n, edges) == n - 1
}

fn find(parent : Array[Int], x : Int) -> Int {
  let mut root = x
  while parent[root] != root {
    root = parent[root]
  }
  let mut cur = x
  while parent[cur] != root {
    let next = parent[cur]
    parent[cur] = root
    cur = next
  }
  root
}