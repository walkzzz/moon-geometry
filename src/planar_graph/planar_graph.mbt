///|
/// Edge in a planar graph. / 平面图中的边。
pub struct PlanarEdge {
  from : Int
  to : Int
}

///|
/// Planar graph with vertices and edges. / 带顶点和边的平面图。
pub struct PlanarGraph {
  vertices : Array[@core.Point2D]
  edges : Array[PlanarEdge]
  adj : Array[Array[Int]]
}

///|
/// Create an empty planar graph. / 创建空平面图。
pub fn PlanarGraph::new() -> PlanarGraph {
  { vertices: [], edges: [], adj: [] }
}

///|
/// Add a vertex to the planar graph, returns its index. / 向平面图添加顶点，返回其索引。
pub fn PlanarGraph::add_vertex(
  graph : PlanarGraph,
  p : @core.Point2D,
) -> Int {
  let idx = graph.vertices.length()
  graph.vertices.push(p)
  graph.adj.push([])
  idx
}

///|
/// Add an edge between two vertices. / 在两个顶点之间添加边。
pub fn PlanarGraph::add_edge(
  graph : PlanarGraph,
  from : Int,
  to : Int,
) -> Unit {
  graph.edges.push({ from, to })
  graph.adj[from].push(to)
  graph.adj[to].push(from)
}

///|
/// Get the number of vertices. / 获取顶点数。
pub fn PlanarGraph::vertex_count(graph : PlanarGraph) -> Int {
  graph.vertices.length()
}

///|
/// Get the number of edges. / 获取边数。
pub fn PlanarGraph::edge_count(graph : PlanarGraph) -> Int {
  graph.edges.length()
}

///|
/// Check if the graph is planar using Euler's formula (V - E + F = 2, E <= 3V - 6 for V >= 3). / 用欧拉公式检查平面性（V >= 3 时 E <= 3V - 6）。
pub fn PlanarGraph::is_planar(graph : PlanarGraph) -> Bool {
  let v = graph.vertices.length()
  let e = graph.edges.length()
  if v < 3 {
    return true
  }
  e <= 3 * v - 6
}

///|
/// Compute the degree of a vertex. / 计算顶点的度数。
pub fn PlanarGraph::degree(graph : PlanarGraph, v : Int) -> Int {
  graph.adj[v].length()
}

///|
/// Get neighbors of a vertex. / 获取顶点的邻居。
pub fn PlanarGraph::neighbors(
  graph : PlanarGraph,
  v : Int,
) -> Array[Int] {
  graph.adj[v]
}

///|
/// Check if the graph is connected using BFS. / 使用 BFS 检查图是否连通。
pub fn PlanarGraph::is_connected(graph : PlanarGraph) -> Bool {
  let n = graph.vertices.length()
  if n == 0 {
    return true
  }
  let visited = Array::make(n, false)
  let queue : Array[Int] = [0]
  visited[0] = true
  while queue.length() > 0 {
    let v = queue.remove(0)
    for u in graph.adj[v] {
      if !visited[u] {
        visited[u] = true
        queue.push(u)
      }
    }
  }
  for v in 0..<n {
    if !visited[v] {
      return false
    }
  }
  true
}

///|
/// Compute the number of faces using Euler's formula (F = E - V + 2 for connected planar graphs). / 用欧拉公式计算面数（连通平面图 F = E - V + 2）。
pub fn PlanarGraph::face_count(graph : PlanarGraph) -> Int {
  if graph.is_connected() {
    graph.edges.length() - graph.vertices.length() + 2
  } else {
    0
  }
}

///|
/// Build a planar graph from a polygon's edges. / 由多边形的边构建平面图。
pub fn PlanarGraph::from_polygon(
  graph : PlanarGraph,
  poly : @core.Polygon,
) -> PlanarGraph {
  let n = poly.size()
  if n < 3 {
    return graph
  }
  let indices : Array[Int] = []
  for i in 0..<n {
    indices.push(graph.add_vertex(poly.get(i)))
  }
  for i in 0..<n {
    graph.add_edge(indices[i], indices[(i + 1) % n])
  }
  graph
}