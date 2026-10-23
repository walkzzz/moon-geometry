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
