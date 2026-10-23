/// |
/// # Minimum Spanning Tree (Kruskal's Algorithm)
/// # 最小生成树（Kruskal 算法）
///
/// Find minimum spanning tree using Kruskal's algorithm with union-find.
/// 使用 Kruskal 算法和并查集查找最小生成树。
///
/// ## Complexity: O(E log E)
/// ## 复杂度: O(E log E)

///|
/// |
/// Weighted edge.
/// 加权边。
pub struct WEdge {
  u : Int32
  v : Int32
  w : Double
}
