///|
/// UV coordinate for parameterization. / 参数化 UV 坐标。
pub struct UV {
  u : Double
  v : Double
}

///|
/// Construct UV. / 构造 UV。
pub fn UV::new(u : Double, v : Double) -> UV {
  { u, v }
}

///|
/// Mesh parameterization result (UV per vertex). / 网格参数化结果（每顶点 UV）。
pub struct MeshParamResult {
  uv : Array[UV]
  success : Bool
}

///|
/// Construct param result. / 构造参数化结果。
pub fn MeshParamResult::new(uv : Array[UV], success : Bool) -> MeshParamResult {
  { uv, success }
}

///|
/// Simple projection parameterization (project to best-fit plane). / 简单投影参数化（投影到最佳拟合平面）。
pub fn project_parametrize(
  vertices : Array[@core.Point3D],
) -> Array[UV] {
  let n = vertices.length()
  if n == 0 {
    return []
  }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  for p in vertices {
    cx += p.x
    cy += p.y
    cz += p.z
  }
  cx = cx / n.to_double()
  cy = cy / n.to_double()
  cz = cz / n.to_double()
  let mut sxx = 0.0
  let mut syy = 0.0
  let mut _szz = 0.0
  let mut sxy = 0.0
  let mut sxz = 0.0
  let mut syz = 0.0
  for p in vertices {
    let dx = p.x - cx
    let dy = p.y - cy
    let dz = p.z - cz
    sxx += dx * dx
    syy += dy * dy
    _szz += dz * dz
    sxy += dx * dy
    sxz += dx * dz
    syz += dy * dz
  }
  let normal = @core.Point3D::new(sxy * syz - sxz * syy, sxz * sxy - sxx * syz, sxx * syy - sxy * sxy)
  let nlen = (normal.x * normal.x + normal.y * normal.y + normal.z * normal.z).sqrt()
  let nx = if nlen > 0.0000000001 { normal.x / nlen } else { 0.0 }
  let ny = if nlen > 0.0000000001 { normal.y / nlen } else { 0.0 }
  let nz = if nlen > 0.0000000001 { normal.z / nlen } else { 1.0 }
  let uaxis = if nx.abs() < 0.9 {
    @core.Point3D::new(1.0 - nx * nx, -ny * nx, -nz * nx)
  } else {
    @core.Point3D::new(-ny * ny, 1.0 - ny * ny, -nz * ny)
  }
  let ulen = (uaxis.x * uaxis.x + uaxis.y * uaxis.y + uaxis.z * uaxis.z).sqrt()
  let ux = if ulen > 0.0000000001 { uaxis.x / ulen } else { 1.0 }
  let uy = if ulen > 0.0000000001 { uaxis.y / ulen } else { 0.0 }
  let uz = if ulen > 0.0000000001 { uaxis.z / ulen } else { 0.0 }
  let vaxis = @core.Point3D::new(
    ny * uz - nz * uy,
    nz * ux - nx * uz,
    nx * uy - ny * ux,
  )
  let result : Array[UV] = []
  for p in vertices {
    let dx = p.x - cx
    let dy = p.y - cy
    let dz = p.z - cz
    let u = dx * ux + dy * uy + dz * uz
    let v = dx * vaxis.x + dy * vaxis.y + dz * vaxis.z
    result.push({ u, v })
  }
  result
}

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

///|
/// Compute area distortion of parameterization. / 计算参数化面积畸变。
pub fn area_distortion(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
  uv : Array[UV],
) -> Double {
  let mut total_3d = 0.0
  let mut total_2d = 0.0
  for f in faces {
    let p0 = vertices[f.0]
    let p1 = vertices[f.1]
    let p2 = vertices[f.2]
    let v1 = p1.sub(p0)
    let v2 = p2.sub(p0)
    let cross = v1.cross(v2)
    total_3d += 0.5 * (cross.x * cross.x + cross.y * cross.y + cross.z * cross.z).sqrt()
    let du1 = uv[f.1].u - uv[f.0].u
    let dv1 = uv[f.1].v - uv[f.0].v
    let du2 = uv[f.2].u - uv[f.0].u
    let dv2 = uv[f.2].v - uv[f.0].v
    total_2d += 0.5 * (du1 * dv2 - du2 * dv1).abs()
  }
  if total_2d > 0.0000000001 {
    (total_3d - total_2d).abs() / total_3d
  } else {
    0.0
  }
}