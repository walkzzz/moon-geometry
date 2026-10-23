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
