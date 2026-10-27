///|
/// Isotropic remeshing: split edges longer than target*1.5 and collapse edges shorter than target*0.5. / 各向同性重网格化：分割超过 target*1.5 的长边，折叠小于 target*0.5 的短边。
pub fn remesh(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
  target_edge : Double,
  iterations : Int32,
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let verts : Array[@core.Point3D] = []
  for v in vertices {
    verts.push(v)
  }
  let fcs : Array[(Int32, Int32, Int32)] = []
  for f in faces {
    fcs.push(f)
  }
  for _ in 0..<iterations {
    split_long_edges(verts, fcs, target_edge * 1.5)
    collapse_short_edges(verts, fcs, target_edge * 0.5)
  }
  (verts, fcs)
}

///|
/// Split edges longer than max_len by inserting midpoint. / 通过插入中点分割超过 max_len 的边。
fn split_long_edges(
  verts : Array[@core.Point3D],
  fcs : Array[(Int32, Int32, Int32)],
  max_len : Double,
) -> Unit {
  let mut changed = true
  while changed {
    changed = false
    let n = fcs.length()
    for fi in 0..<n {
      if changed {
        break
      }
      let (a, b, c) = fcs[fi]
      if try_split(verts, fcs, fi, a, b, c, max_len) {
        changed = true
      } else if try_split(verts, fcs, fi, b, c, a, max_len) {
        changed = true
      } else if try_split(verts, fcs, fi, c, a, b, max_len) {
        changed = true
      }
    }
  }
}

///|
/// Try to split edge (p,q) in face fi, with r the third vertex. Returns true if split. / 尝试分割面 fi 中的边 (p,q)，r 为第三顶点。分割成功返回 true。
fn try_split(
  verts : Array[@core.Point3D],
  fcs : Array[(Int32, Int32, Int32)],
  fi : Int32,
  p : Int32,
  q : Int32,
  r : Int32,
  max_len : Double,
) -> Bool {
  let len = verts[p].dist(verts[q])
  if len > max_len {
    let mid = @core.Point3D::new(
      (verts[p].x + verts[q].x) / 2.0,
      (verts[p].y + verts[q].y) / 2.0,
      (verts[p].z + verts[q].z) / 2.0,
    )
    let mid_idx = verts.length()
    verts.push(mid)
    fcs[fi] = (p, mid_idx, r)
    fcs.push((mid_idx, q, r))
    true
  } else {
    false
  }
}

///|
/// Collapse edges shorter than min_len by merging endpoints. / 通过合并端点折叠小于 min_len 的边。
fn collapse_short_edges(
  verts : Array[@core.Point3D],
  fcs : Array[(Int32, Int32, Int32)],
  min_len : Double,
) -> Unit {
  let mut changed = true
  while changed {
    changed = false
    let n = fcs.length()
    for fi in 0..<n {
      if changed {
        break
      }
      let (a, b, c) = fcs[fi]
      if try_collapse(verts, fcs, a, b, min_len) {
        changed = true
      } else if try_collapse(verts, fcs, b, c, min_len) {
        changed = true
      } else if try_collapse(verts, fcs, c, a, min_len) {
        changed = true
      }
    }
  }
}

///|
/// Try to collapse edge (p,q) by merging q into p. Returns true if collapsed. / 尝试通过将 q 合并到 p 来折叠边 (p,q)。折叠成功返回 true。
fn try_collapse(
  verts : Array[@core.Point3D],
  fcs : Array[(Int32, Int32, Int32)],
  p : Int32,
  q : Int32,
  min_len : Double,
) -> Bool {
  if p == q {
    return false
  }
  let len = verts[p].dist(verts[q])
  if len < min_len {
    let m = fcs.length()
    for j in 0..<m {
      let (x, y, z) = fcs[j]
      fcs[j] = (
        replace_idx(x, q, p),
        replace_idx(y, q, p),
        replace_idx(z, q, p),
      )
    }
    let mut k = 0
    while k < fcs.length() {
      let (x, y, z) = fcs[k]
      if x == y || y == z || x == z {
        let last = fcs.length() - 1
        fcs[k] = fcs[last]
        ignore(fcs.pop())
      } else {
        k = k + 1
      }
    }
    true
  } else {
    false
  }
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
