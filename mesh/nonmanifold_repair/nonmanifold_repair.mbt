///|
/// Count non-manifold edges (edges shared by more than 2 faces). / 统计非流形边（被超过2个面共享的边）。
pub fn count_nonmanifold_edges(faces : Array[(Int32, Int32, Int32)]) -> Int32 {
  let all_edges : Array[(Int32, Int32)] = []
  for f in faces {
    let (a, b, c) = f
    all_edges.push(canonical_edge(a, b))
    all_edges.push(canonical_edge(b, c))
    all_edges.push(canonical_edge(c, a))
  }
  let mut count = 0
  let processed : Array[(Int32, Int32)] = []
  for e in all_edges {
    if !contains_edge(processed, e) {
      processed.push(e)
      let mut c = 0
      for e2 in all_edges {
        if e2 == e {
          c = c + 1
        }
      }
      if c > 2 {
        count = count + 1
      }
    }
  }
  count
}

///|
/// Repair non-manifold edges by duplicating vertices for faces sharing non-manifold edges. / 通过为共享非流形边的面复制顶点来修复非流形边。
pub fn repair_nonmanifold_edges(
  faces : Array[(Int32, Int32, Int32)],
) -> Array[(Int32, Int32, Int32)] {
  let result : Array[(Int32, Int32, Int32)] = []
  for f in faces {
    result.push(f)
  }
  let mut next_vert = max_vertex_index(result) + 1
  let all_edges : Array[(Int32, Int32)] = []
  for f in result {
    let (a, b, c) = f
    all_edges.push(canonical_edge(a, b))
    all_edges.push(canonical_edge(b, c))
    all_edges.push(canonical_edge(c, a))
  }
  let processed : Array[(Int32, Int32)] = []
  for e in all_edges {
    if !contains_edge(processed, e) {
      processed.push(e)
      let (lo, hi) = e
      let face_list : Array[Int32] = []
      for fj in 0..<result.length() {
        if edge_in_face(result[fj], lo, hi) {
          face_list.push(fj)
        }
      }
      if face_list.length() > 2 {
        for k in 2..<face_list.length() {
          let fj = face_list[k]
          let (x, y, z) = result[fj]
          let new_v = next_vert
          next_vert = next_vert + 1
          result[fj] = (
            replace_idx(x, hi, new_v),
            replace_idx(y, hi, new_v),
            replace_idx(z, hi, new_v),
          )
        }
      }
    }
  }
  result
}

///|
/// Canonical edge representation with smaller index first. / 规范化边表示，较小索引在前。
fn canonical_edge(a : Int32, b : Int32) -> (Int32, Int32) {
  if a < b {
    (a, b)
  } else {
    (b, a)
  }
}

///|
/// Check if edge array contains a specific edge. / 检查边数组是否包含特定边。
fn contains_edge(arr : Array[(Int32, Int32)], e : (Int32, Int32)) -> Bool {
  for x in arr {
    if x == e {
      return true
    }
  }
  false
}

///|
/// Check if edge (a,b) is in face f. / 检查边 (a,b) 是否在面 f 中。
fn edge_in_face(f : (Int32, Int32, Int32), a : Int32, b : Int32) -> Bool {
  let (x, y, z) = f
  canonical_edge(x, y) == (a, b) ||
  canonical_edge(y, z) == (a, b) ||
  canonical_edge(z, x) == (a, b)
}

///|
/// Find maximum vertex index in faces. / 查找面中的最大顶点索引。
fn max_vertex_index(faces : Array[(Int32, Int32, Int32)]) -> Int32 {
  let mut max = 0
  for f in faces {
    let (a, b, c) = f
    if a > max {
      max = a
    }
    if b > max {
      max = b
    }
    if c > max {
      max = c
    }
  }
  max
}

///|
/// Replace index `from` with `to` in a vertex index. / 在顶点索引中将 `from` 替换为 `to`。
fn replace_idx(idx : Int32, from : Int32, to : Int32) -> Int32 {
  if idx == from {
    to
  } else {
    idx
  }
}
