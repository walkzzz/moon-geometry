///|
/// Topology consistency checking for meshes. / 网格拓扑一致性检查。
pub enum TopologyIssue {
  NonManifoldEdge
  NonManifoldVertex
  DanglingEdge
  InconsistentNormal
  IsolatedVertex
} derive(Debug, Eq)

///|
pub extend TopologyIssue with Eq::{not_equal, equal}

///|
pub extend TopologyIssue with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Suppress unused constructor warnings — all variants are part of public API. / 抑制未使用构造子警告。
fn _suppress_unused_topology() -> Unit {
  ignore(NonManifoldVertex)
  ignore(InconsistentNormal)
}

///|
pub struct TopologyResult {
  issue_type : TopologyIssue
  element_index : Int32
  message : String
}

///|
fn edge_key(v1 : Int32, v2 : Int32) -> String {
  if v1 < v2 {
    v1.to_string() + "-" + v2.to_string()
  } else {
    v2.to_string() + "-" + v1.to_string()
  }
}

///|
fn count_edges(faces : Array[(Int32, Int32, Int32)]) -> Array[(String, Int32)] {
  let all_edges : Array[String] = []
  for i in 0..<faces.length() {
    let (a, b, c) = faces[i]
    all_edges.push(edge_key(a, b))
    all_edges.push(edge_key(b, c))
    all_edges.push(edge_key(c, a))
  }
  let keys : Array[String] = []
  let counts : Array[Int32] = []
  for i in 0..<all_edges.length() {
    let key = all_edges[i]
    let mut found_idx = -1
    for j in 0..<keys.length() {
      if keys[j] == key {
        found_idx = j
        break
      }
    }
    if found_idx >= 0 {
      counts[found_idx] = counts[found_idx] + 1
    } else {
      keys.push(key)
      counts.push(1)
    }
  }
  let result : Array[(String, Int32)] = []
  for i in 0..<keys.length() {
    result.push((keys[i], counts[i]))
  }
  result
}

///|
/// Check if a mesh is a closed manifold. / 检查网格是否为闭合流形。
pub fn is_closed_manifold(faces : Array[(Int32, Int32, Int32)]) -> Bool {
  let edges = count_edges(faces)
  for i in 0..<edges.length() {
    if edges[i].1 != 2 {
      return false
    }
  }
  true
}

///|
/// Find all non-manifold edges. / 查找所有非流形边。
pub fn find_nonmanifold_edges(
  faces : Array[(Int32, Int32, Int32)],
) -> Array[TopologyResult] {
  let results : Array[TopologyResult] = []
  let edges = count_edges(faces)
  for i in 0..<edges.length() {
    if edges[i].1 > 2 {
      results.push({
        issue_type: NonManifoldEdge,
        element_index: i,
        message: "Edge {edges[i].0} shared by {edges[i].1} faces",
      })
    }
  }
  results
}

///|
/// Find dangling edges. / 查找悬挂边。
pub fn find_dangling_edges(
  faces : Array[(Int32, Int32, Int32)],
) -> Array[TopologyResult] {
  let results : Array[TopologyResult] = []
  let edges = count_edges(faces)
  for i in 0..<edges.length() {
    if edges[i].1 == 1 {
      results.push({
        issue_type: DanglingEdge,
        element_index: i,
        message: "Edge {edges[i].0} is dangling",
      })
    }
  }
  results
}

///|
/// Find isolated vertices. / 查找孤立顶点。
pub fn find_isolated_vertices(
  num_vertices : Int32,
  faces : Array[(Int32, Int32, Int32)],
) -> Array[TopologyResult] {
  let results : Array[TopologyResult] = []
  let used : Array[Bool] = Array::make(num_vertices, false)
  for i in 0..<faces.length() {
    let (a, b, c) = faces[i]
    if a >= 0 && a < num_vertices {
      used[a] = true
    }
    if b >= 0 && b < num_vertices {
      used[b] = true
    }
    if c >= 0 && c < num_vertices {
      used[c] = true
    }
  }
  for i in 0..<num_vertices {
    if !used[i] {
      results.push({
        issue_type: IsolatedVertex,
        element_index: i,
        message: "Vertex {i} is isolated",
      })
    }
  }
  results
}

///|
/// Full topology validation. / 完整拓扑验证。
pub fn validate_topology(
  num_vertices : Int32,
  faces : Array[(Int32, Int32, Int32)],
) -> Array[TopologyResult] {
  let results : Array[TopologyResult] = []
  for r in find_nonmanifold_edges(faces) {
    results.push(r)
  }
  for r in find_dangling_edges(faces) {
    results.push(r)
  }
  for r in find_isolated_vertices(num_vertices, faces) {
    results.push(r)
  }
  results
}
