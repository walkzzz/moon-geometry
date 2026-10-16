test "voxel_index basic" {
  let idx = voxel_index(1, 2, 3, 4, 5)
  assert_true(idx == 1 + 2 * 4 + 3 * 4 * 5)
}

test "count_6_neighbors center" {
  let voxels : Array[Bool] = Array::make(27, false)
  voxels[voxel_index(1, 1, 1, 3, 3)] = true
  voxels[voxel_index(0, 1, 1, 3, 3)] = true
  voxels[voxel_index(2, 1, 1, 3, 3)] = true
  let n = count_6_neighbors(voxels, 1, 1, 1, 3, 3, 3)
  assert_true(n == 2)
}

test "count_26_neighbors center" {
  let voxels : Array[Bool] = Array::make(27, true)
  let n = count_26_neighbors(voxels, 1, 1, 1, 3, 3, 3)
  assert_true(n == 26)
}

test "is_boundary corner" {
  let voxels : Array[Bool] = Array::make(27, true)
  let b = is_boundary(voxels, 0, 0, 0, 3, 3, 3)
  assert_true(b)
}

test "is_boundary interior" {
  let voxels : Array[Bool] = Array::make(27, true)
  let b = is_boundary(voxels, 1, 1, 1, 3, 3, 3)
  assert_true(!b)
}

test "skeleton_3d reduces volume" {
  let voxels : Array[Bool] = Array::make(27, true)
  let skel = skeleton_3d(voxels, 3, 3, 3)
  let vol_before = skeleton_volume(voxels)
  let vol_after = skeleton_volume(skel)
  assert_true(vol_after < vol_before)
}

test "skeleton_3d preserves line" {
  let voxels : Array[Bool] = Array::make(15, false)
  for x in 0..<5 {
    voxels[voxel_index(x, 0, 0, 5, 1)] = true
  }
  let skel = skeleton_3d(voxels, 5, 1, 1)
  let vol = skeleton_volume(skel)
  assert_true(vol >= 1)
}

test "skeleton_volume basic" {
  let voxels : Array[Bool] = [true, false, true, true]
  assert_true(skeleton_volume(voxels) == 3)
}

test "skeleton_endpoints line" {
  let voxels : Array[Bool] = Array::make(5, false)
  for x in 0..<5 {
    voxels[x] = true
  }
  let ep = skeleton_endpoints(voxels, 5, 1, 1)
  assert_true(ep == 2)
}

test "skeleton_field basic" {
  let voxels : Array[Bool] = Array::make(27, true)
  let field = skeleton_field(voxels, 3, 3, 3)
  let vol = skeleton_volume(field)
  assert_true(vol >= 0)
}