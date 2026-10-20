///|
/// Voxel grid for marching cubes. / Marching Cubes 体素网格。
pub struct McGrid {
  values : Array[Double]
  nx : Int
  ny : Int
  nz : Int
}

///|
/// Construct a voxel grid. / 构造体素网格。
pub fn McGrid::new(
  values : Array[Double],
  nx : Int,
  ny : Int,
  nz : Int,
) -> McGrid {
  { values, nx, ny, nz }
}

///|
/// Get value at (i, j, k). / 获取 (i, j, k) 处的值。
pub fn McGrid::get(g : McGrid, i : Int, j : Int, k : Int) -> Double {
  g.values[i + g.nx * (j + g.ny * k)]
}

///|
/// Marching cubes isosurface extraction. Returns list of triangles.
/// Uses edge-crossing detection with fan triangulation per voxel.
/// Marching Cubes 等值面提取。返回三角形列表。
/// 使用边相交检测与逐体素扇形三角化。
pub fn marching_cubes(
  grid : McGrid,
  isolevel : Double,
) -> Array[(@core.Point3D, @core.Point3D, @core.Point3D)] {
  let result : Array[(@core.Point3D, @core.Point3D, @core.Point3D)] = []
  for k in 0..<(grid.nz - 1) {
    for j in 0..<(grid.ny - 1) {
      for i in 0..<(grid.nx - 1) {
        process_cube(grid, i, j, k, isolevel, result)
      }
    }
  }
  result
}

fn process_cube(
  grid : McGrid,
  i : Int,
  j : Int,
  k : Int,
  isolevel : Double,
  result : Array[(@core.Point3D, @core.Point3D, @core.Point3D)],
) -> Unit {
  let v = [
    McGrid::get(grid, i, j, k),
    McGrid::get(grid, i + 1, j, k),
    McGrid::get(grid, i + 1, j + 1, k),
    McGrid::get(grid, i, j + 1, k),
    McGrid::get(grid, i, j, k + 1),
    McGrid::get(grid, i + 1, j, k + 1),
    McGrid::get(grid, i + 1, j + 1, k + 1),
    McGrid::get(grid, i, j + 1, k + 1),
  ]
  let mut cube_idx = 0
  for b in 0..<8 {
    if v[b] < isolevel {
      cube_idx = cube_idx | (1 << b)
    }
  }
  if cube_idx == 0 || cube_idx == 255 {
    return
  }
  let px = [
    i.to_double(),
    (i + 1).to_double(),
    (i + 1).to_double(),
    i.to_double(),
    i.to_double(),
    (i + 1).to_double(),
    (i + 1).to_double(),
    i.to_double(),
  ]
  let py = [
    j.to_double(),
    j.to_double(),
    (j + 1).to_double(),
    (j + 1).to_double(),
    j.to_double(),
    j.to_double(),
    (j + 1).to_double(),
    (j + 1).to_double(),
  ]
  let pz = [
    k.to_double(),
    k.to_double(),
    k.to_double(),
    k.to_double(),
    (k + 1).to_double(),
    (k + 1).to_double(),
    (k + 1).to_double(),
    (k + 1).to_double(),
  ]
  // 12 edges of a cube: (corner_a, corner_b)
  let edges = [
    (0, 1),
    (1, 2),
    (2, 3),
    (3, 0),
    (4, 5),
    (5, 6),
    (6, 7),
    (7, 4),
    (0, 4),
    (1, 5),
    (2, 6),
    (3, 7),
  ]
  let verts : Array[@core.Point3D] = []
  for e in edges {
    let va = v[e.0]
    let vb = v[e.1]
    if (va < isolevel && vb >= isolevel) || (va >= isolevel && vb < isolevel) {
      let t = if vb - va == 0.0 {
        0.5
      } else {
        (isolevel - va) / (vb - va)
      }
      verts.push(
        @core.Point3D::new(
          px[e.0] + t * (px[e.1] - px[e.0]),
          py[e.0] + t * (py[e.1] - py[e.0]),
          pz[e.0] + t * (pz[e.1] - pz[e.0]),
        ),
      )
    }
  }
  // fan triangulation
  if verts.length() >= 3 {
    for t in 1..<(verts.length() - 1) {
      result.push((verts[0], verts[t], verts[t + 1]))
    }
  }
}

///|
/// Count triangles generated. / 统计生成的三角形数。
pub fn marching_cubes_count(
  grid : McGrid,
  isolevel : Double,
) -> Int {
  marching_cubes(grid, isolevel).length()
}

///|
/// Classify cube configuration into one of 33 equivalence classes.
/// 将立方体配置分类为 33 个等价类之一。
pub fn cube_config_class(cube_idx : Int) -> Int {
  // Count inside corners; use popcount to reduce to base classes.
  // 统计内部角数，归约为基类。
  let mut bits = 0
  for b in 0..<8 {
    if ((cube_idx >> b) & 1) == 1 {
      bits += 1
    }
  }
  if bits == 0 || bits == 8 {
    0
  } else if bits == 1 || bits == 7 {
    1
  } else if bits == 2 || bits == 6 {
    // edge-connected or face-diagonal or body-diagonal
    if is_edge_pair(cube_idx) {
      2
    } else if is_face_diag(cube_idx) {
      3
    } else {
      4
    }
  } else if bits == 3 || bits == 5 {
    5
  } else {
    // bits == 4
    6
  }
}

fn is_edge_pair(idx : Int) -> Bool {
  let pairs = [
    (0, 1),
    (1, 2),
    (2, 3),
    (3, 0),
    (4, 5),
    (5, 6),
    (6, 7),
    (7, 4),
    (0, 4),
    (1, 5),
    (2, 6),
    (3, 7),
  ]
  for p in pairs {
    if ((idx >> p.0) & 1) == 1 && ((idx >> p.1) & 1) == 1 {
      return true
    }
  }
  false
}

fn is_face_diag(idx : Int) -> Bool {
  let diags = [
    (0, 2),
    (1, 3),
    (4, 6),
    (5, 7),
    (0, 5),
    (1, 4),
    (2, 7),
    (3, 6),
    (0, 6),
    (1, 7),
    (2, 4),
    (3, 5),
  ]
  for d in diags {
    if ((idx >> d.0) & 1) == 1 && ((idx >> d.1) & 1) == 1 {
      return true
    }
  }
  false
}

///|
/// Count active (non-empty) voxel configurations. / 统计活动（非空）体素配置数。
pub fn count_active_configs(grid : McGrid, isolevel : Double) -> Int {
  let mut count = 0
  for k in 0..<(grid.nz - 1) {
    for j in 0..<(grid.ny - 1) {
      for i in 0..<(grid.nx - 1) {
        let mut idx = 0
        for b in 0..<8 {
          let (bi, bj, bk) = corner_offset(b, i, j, k)
          if McGrid::get(grid, bi, bj, bk) < isolevel {
            idx = idx | (1 << b)
          }
        }
        if idx != 0 && idx != 255 {
          count += 1
        }
      }
    }
  }
  count
}

fn corner_offset(b : Int, i : Int, j : Int, k : Int) -> (Int, Int, Int) {
  match b {
    0 => (i, j, k)
    1 => (i + 1, j, k)
    2 => (i + 1, j + 1, k)
    3 => (i, j + 1, k)
    4 => (i, j, k + 1)
    5 => (i + 1, j, k + 1)
    6 => (i + 1, j + 1, k + 1)
    7 => (i, j + 1, k + 1)
    _ => (i, j, k)
  }
}