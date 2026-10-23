///|
/// # Probabilistic Roadmap (PRM)
/// # 概率路线图（PRM）
///
/// PRM construction and shortest path query for motion planning.
/// 概率路线图构建与最短路径查询。
///
/// ## Complexity: O(n²) construction + O(n² log n) query
/// ## 复杂度: 构建 O(n²) + 查询 O(n² log n)

///|
/// PRM configuration. / PRM 配置。
pub struct PRMConfig {
  num_samples : Int32
  connection_radius : Double
  seed : UInt32
  x_min : Double
  x_max : Double
  y_min : Double
  y_max : Double
}

///|
/// Construct PRM configuration. / 构造 PRM 配置。
pub fn PRMConfig::new(
  num_samples : Int32,
  connection_radius : Double,
  seed : UInt32,
  x_min : Double,
  x_max : Double,
  y_min : Double,
  y_max : Double,
) -> PRMConfig {
  { num_samples, connection_radius, seed, x_min, x_max, y_min, y_max, }
}

///|
/// PRM roadmap storing nodes and edges. / PRM 路线图，存储节点和边。
pub struct PRMRoadmap {
  nodes : Array[@core.Point2D]
  edges : Array[Array[(Int32, Double)]]
}

///|
/// Construct PRM roadmap. / 构造 PRM 路线图。
pub fn PRMRoadmap::new(
  nodes : Array[@core.Point2D],
  edges : Array[Array[(Int32, Double)]],
) -> PRMRoadmap {
  { nodes, edges, }
}

///|
/// PRM query result. / PRM 查询结果。
pub struct PRMResult {
  path : Array[@core.Point2D]
  success : Bool
  distance : Double
}
