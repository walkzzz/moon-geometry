///|
/// Harmonic parameterization (Tutte embedding with boundary on unit circle). / 调和参数化（Tutte 嵌入，边界在单位圆上）。
pub fn harmonic_parametrize(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
  boundary : Array[Int],
) -> MeshParamResult {
  let n = vertices.length()
  if n == 0 {
    return { uv: [], success: false }
  }
  let uv = Array::make(n, UV::new(0.0, 0.0))
  let is_boundary = Array::make(n, false)
  for idx in boundary {
    if idx >= 0 && idx < n {
      is_boundary[idx] = true
    }
  }
  let m = boundary.length()
  if m >= 3 {
    for i in 0..<m {
      let angle = 2.0 * 3.14159265358979323846 * i.to_double() / m.to_double()
      uv[boundary[i]] = { u: @math.cos(angle), v: @math.sin(angle) }
    }
  }
  let adj : Array[Array[Int]] = []
  for _ in 0..<n {
    adj.push([])
  }
  for f in faces {
    add_adj(adj, f.0, f.1)
    add_adj(adj, f.1, f.2)
    add_adj(adj, f.2, f.0)
  }
  for iter in 0..<100 {
    let mut max_change = 0.0
    for i in 0..<n {
      if is_boundary[i] {
        continue
      }
      if adj[i].length() == 0 {
        continue
      }
      let mut su = 0.0
      let mut sv = 0.0
      for j in adj[i] {
        su += uv[j].u
        sv += uv[j].v
      }
      let new_u = su / adj[i].length().to_double()
      let new_v = sv / adj[i].length().to_double()
      let change = (new_u - uv[i].u).abs() + (new_v - uv[i].v).abs()
      if change > max_change {
        max_change = change
      }
      uv[i] = { u: new_u, v: new_v }
    }
    if max_change < 0.0000001 {
      ignore(iter)
      break
    }
  }
  { uv, success: true }
}

fn add_adj(adj : Array[Array[Int]], a : Int, b : Int) -> Unit {
  let mut found = false
  for x in adj[a] {
    if x == b {
      found = true
      break
    }
  }
  if !(found) {
    adj[a].push(b)
  }
  found = false
  for x in adj[b] {
    if x == a {
      found = true
      break
    }
  }
  if !(found) {
    adj[b].push(a)
  }
}
