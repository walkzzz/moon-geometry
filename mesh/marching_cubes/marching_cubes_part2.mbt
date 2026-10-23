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
