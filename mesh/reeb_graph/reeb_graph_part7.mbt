///|
/// Compute the Reeb graph of a scalar field. / 计算标量场的 Reeb 图。
pub fn reeb_graph(
  values : Array[Double],
  edges : Array[(Int32, Int32)],
) -> ReebGraph {
  let nodes = critical_points(values, edges)
  let n = values.length()
  if n == 0 {
    return { nodes: [], edges: [], }
  }
  let adj = build_adjacency(n, edges)
  let order = sort_by_value(values)
  let component : Array[Int32] = Array::make(n, -1)
  let mut next_component = 0
  let reeb_edges : Array[ReebEdge] = []
  let comp_start : Array[Int32] = Array::make(n, -1)
  for vi in order {
    let lower_comps : Array[Int32] = []
    for j in adj[vi] {
      if values[j] < values[vi] - 0.0000000001 && component[j] != -1 {
        let mut found = false
        for c in lower_comps {
          if c == component[j] {
            found = true
            break
          }
        }
        if !found {
          lower_comps.push(component[j])
        }
      }
    }
    let node = nodes[vi]
    match node.crit_type {
      Minimum => {
        component[vi] = next_component
        comp_start[next_component] = vi
        next_component += 1
      }
      Maximum =>
        if lower_comps.length() > 0 {
          reeb_edges.push({ from: comp_start[lower_comps[0]], to: vi, })
          component[vi] = lower_comps[0]
        }
      Saddle =>
        if lower_comps.length() >= 2 {
          for c in lower_comps {
            reeb_edges.push({ from: comp_start[c], to: vi, })
          }
          component[vi] = lower_comps[0]
          for j in 0..<n {
            if component[j] == lower_comps[1] {
              component[j] = lower_comps[0]
            }
          }
        } else if lower_comps.length() == 1 {
          component[vi] = lower_comps[0]
        }
      Regular =>
        if lower_comps.length() == 1 {
          component[vi] = lower_comps[0]
        } else {
          component[vi] = next_component
          comp_start[next_component] = vi
          next_component += 1
        }
    }
  }
  { nodes, edges: reeb_edges, }
}

///|
fn sort_by_value(values : Array[Double]) -> Array[Int32] {
  let n = values.length()
  let order = Array::make(n, 0)
  for i in 0..<n {
    order[i] = i
  }
  for i in 0..<(n - 1) {
    for j in 0..<(n - 1 - i) {
      if values[order[j]] > values[order[j + 1]] {
        let tmp = order[j]
        order[j] = order[j + 1]
        order[j + 1] = tmp
      }
    }
  }
  order
}
