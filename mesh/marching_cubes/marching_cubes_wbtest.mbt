///|
test "mc empty grid" {
  let g = McGrid::new([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], 2, 2, 2)
  let tris = marching_cubes(g, 0.5)
  assert_eq(tris.length(), 0)
}

///|
test "mc single inside" {
  // one corner below isolevel
  let vals = [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
  let g = McGrid::new(vals, 2, 2, 2)
  let tris = marching_cubes(g, 0.5)
  assert_true(tris.length() >= 1)
}

///|
test "mc sphere isosurface" {
  // 3x3x3 grid with sphere field
  let vals : Array[Double] = []
  for k in 0..<3 {
    for j in 0..<3 {
      for i in 0..<3 {
        let dx = i.to_double() - 1.0
        let dy = j.to_double() - 1.0
        let dz = k.to_double() - 1.0
        vals.push(dx * dx + dy * dy + dz * dz)
      }
    }
  }
  let g = McGrid::new(vals, 3, 3, 3)
  let tris = marching_cubes(g, 1.0)
  assert_true(tris.length() > 0)
}

///|
test "mc count function" {
  let vals = [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
  let g = McGrid::new(vals, 2, 2, 2)
  let cnt = marching_cubes_count(g, 0.5)
  assert_true(cnt >= 1)
}

///|
test "mc all below" {
  let vals = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  let g = McGrid::new(vals, 2, 2, 2)
  let tris = marching_cubes(g, 0.5)
  assert_eq(tris.length(), 0)
}

///|
test "mc all above" {
  let vals = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
  let g = McGrid::new(vals, 2, 2, 2)
  let tris = marching_cubes(g, 0.5)
  assert_eq(tris.length(), 0)
}

///|
test "mc config class empty" {
  assert_eq(cube_config_class(0), 0)
}

///|
test "mc config class full" {
  assert_eq(cube_config_class(255), 0)
}

///|
test "mc config class single" {
  assert_eq(cube_config_class(1), 1)
  assert_eq(cube_config_class(128), 1)
}

///|
test "mc config class pair" {
  assert_eq(cube_config_class(3), 2)
}

///|
test "mc count active configs" {
  let vals = [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
  let g = McGrid::new(vals, 2, 2, 2)
  assert_eq(count_active_configs(g, 0.5), 1)
}

///|
test "mc two voxel grid" {
  // 3x2x2 grid, two voxels in x
  let vals = [
    0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
    1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
  ]
  let g = McGrid::new(vals, 3, 2, 2)
  let tris = marching_cubes(g, 0.5)
  assert_true(tris.length() >= 1)
}

///|
test "mc config class face diagonal" {
  // bits==2, face diagonal (bits 0 和 2) → 类 3
  // 覆盖 is_face_diag 函数体（第 208, 223 行）和 face_diag 分支（第 169 行）
  assert_eq(cube_config_class(5), 3)
}

///|
test "mc config class body diagonal" {
  // bits==2, body diagonal (bits 0 和 7) → 类 4
  // 覆盖 body_diag 返回（第 172 行）
  assert_eq(cube_config_class(129), 4)
}

///|
test "mc config class three bits" {
  // bits==3 → 类 5
  // 覆盖 bits==3 分支（第 174 行）
  assert_eq(cube_config_class(7), 5)
}

///|
test "mc config class five bits" {
  // bits==5 → 类 5
  // 覆盖 bits==5 分支（第 174 行）
  assert_eq(cube_config_class(31), 5)
}

///|
test "mc config class four bits" {
  // bits==4 → 类 6
  // 覆盖 bits==4 返回（第 178 行）
  assert_eq(cube_config_class(15), 6)
}

///|
test "mc config class six bits" {
  // bits==6 → 6 个 set 中必有 edge pair → 类 2
  assert_eq(cube_config_class(63), 2)
}

///|
test "mc process cube with edge crossing" {
  // 构造一个体素，使得 va==vb（vb-va==0.0）触发 t=0.5 分支
  // 顶点 0 低于 isolevel，顶点 1 高于，但让某条边两端相等
  let vals = [0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0]
  let g = McGrid::new(vals, 2, 2, 2)
  let tris = marching_cubes(g, 0.5)
  assert_true(tris.length() >= 1)
}

///|
test "mc count active configs all active" {
  // 3x2x2 网格，所有体素都活动
  let vals = [
    0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0,
    0.0, 1.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0,
  ]
  let g = McGrid::new(vals, 3, 2, 2)
  let cnt = count_active_configs(g, 0.5)
  assert_true(cnt >= 1)
}

///|
test "mc grid get" {
  // 覆盖 McGrid::get
  let g = McGrid::new([0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0], 2, 2, 2)
  assert_true((McGrid::get(g, 0, 0, 0) - 0.0).abs() < 0.0000001)
  assert_true((McGrid::get(g, 1, 0, 0) - 1.0).abs() < 0.0000001)
  assert_true((McGrid::get(g, 0, 1, 0) - 2.0).abs() < 0.0000001)
  assert_true((McGrid::get(g, 1, 1, 0) - 3.0).abs() < 0.0000001)
  assert_true((McGrid::get(g, 0, 0, 1) - 4.0).abs() < 0.0000001)
}
