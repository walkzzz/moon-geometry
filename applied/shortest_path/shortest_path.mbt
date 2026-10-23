/// |
/// # Shortest Path (Dijkstra)
/// # 最短路径（Dijkstra）
///
/// Dijkstra's shortest path algorithm for weighted graphs.
/// 加权图的 Dijkstra 最短路径算法。
///
/// ## Complexity: O((V + E) log V)
/// ## 复杂度: O((V + E) log V)

/// |
/// Weighted graph edge.
/// 加权图边。
pub struct GraphEdge {
  to : Int
  weight : Double
}
