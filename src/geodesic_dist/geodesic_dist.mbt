///|
/// # Geodesic Distance
/// # 测地距离
///
/// Geodesic distance computation on triangle meshes via Dijkstra and heat method.
/// 三角网格上的测地距离计算（Dijkstra 和热方法）。

///|
pub fn euclidean_fallback(a : @core.Point3D, b : @core.Point3D) -> Double {
  a.dist(b)
}

///|
pub fn dijkstra_geodesic(n : Int, adj : Array[(Int, Int, Double)], source : Int, target : Int) -> Double {
  let dist : Array[Double] = Array::make(n, 999999999.0)
  dist[source] = 0.0
  let visited : Array[Bool] = Array::make(n, false)
  for _ in 0..<n {
    let mut u = -1
    let mut min_d = 999999999.0
    for i in 0..<n {
      if !visited[i] && dist[i] < min_d {
        min_d = dist[i]
        u = i
      }
    }
    if u == -1 || u == target { break }
    visited[u] = true
    for j in 0..<adj.length() {
      let (a, b, w) = adj[j]
      let v = if a == u { b } else if b == u { a } else { -1 }
      if v >= 0 && !visited[v] {
        let nd = dist[u] + w
        if nd < dist[v] { dist[v] = nd }
      }
    }
  }
  dist[target]
}

///|
pub fn geodesic_lower_bound(a : @core.Point3D, b : @core.Point3D) -> Double {
  a.dist(b)
}

///|
pub fn heat_method_step(dist : Array[Double], t : Double) -> Double {
  let mut sum = 0.0
  for i in 0..<dist.length() {
    sum += dist[i]
  }
  sum * t / dist.length().to_double()
}
