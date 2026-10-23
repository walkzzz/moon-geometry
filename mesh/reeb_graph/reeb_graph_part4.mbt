///|
/// Find critical points of a scalar field on a mesh. / 寻找网格上标量场的临界点。
pub fn critical_points(
  values : Array[Double],
  edges : Array[(Int32, Int32)],
) -> Array[ReebNode] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let adj = build_adjacency(n, edges)
  let nodes : Array[ReebNode] = []
  for i in 0..<n {
    let mut lower_count = 0
    let mut upper_count = 0
    for j in adj[i] {
      if values[j] < values[i] - 0.0000000001 {
        lower_count += 1
      }
      if values[j] > values[i] + 0.0000000001 {
        upper_count += 1
      }
    }
    let crit_type = if lower_count == 0 && upper_count == 0 {
      Regular
    } else if lower_count == 0 {
      Minimum
    } else if upper_count == 0 {
      Maximum
    } else {
      let lower_components = count_components(i, adj, values, true)
      let upper_components = count_components(i, adj, values, false)
      if lower_components > 1 || upper_components > 1 {
        Saddle
      } else {
        Regular
      }
    }
    nodes.push({ vertex_idx: i, level: values[i], crit_type, })
  }
  nodes
}
