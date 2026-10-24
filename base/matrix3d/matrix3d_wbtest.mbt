///|
test "identity4 basic" {
  let m = identity4()
  for i in 0..<4 {
    for j in 0..<4 {
      let expected = if i == j { 1.0 } else { 0.0 }
      assert_true((m[i][j] - expected).abs() < 0.0000001)
    }
  }
}

///|
test "translation and transform" {
  let t = translation(1.0, 2.0, 3.0)
  let (x, y, z) = transform_point(t, 0.0, 0.0, 0.0)
  assert_true((x - 1.0).abs() < 0.0000001)
  assert_true((y - 2.0).abs() < 0.0000001)
  assert_true((z - 3.0).abs() < 0.0000001)
}

///|
test "mat4_mul basic" {
  let a = translation(1.0, 0.0, 0.0)
  let b = translation(0.0, 2.0, 0.0)
  let c = mat4_mul(a, b)
  let (x, y, z) = transform_point(c, 0.0, 0.0, 0.0)
  assert_true((x - 1.0).abs() < 0.0000001)
  assert_true((y - 2.0).abs() < 0.0000001)
  assert_true((z - 0.0).abs() < 0.0000001)
}

///|
test "rotation_z 90 degrees" {
  let r = rotation_z(1.5707963267948966)
  let (x, y, _) = transform_point(r, 1.0, 0.0, 0.0)
  assert_true(x.abs() < 0.0001)
  assert_true((y - 1.0).abs() < 0.0001)
}

///|
test "mat4_determinant identity" {
  let m = identity4()
  let det = mat4_determinant(m)
  assert_true((det - 1.0).abs() < 0.0000001)
}

///|
test "mat4_inverse basic" {
  let m = scaling(2.0, 4.0, 8.0)
  let inv = mat4_inverse(m)
  match inv {
    Some(mi) => {
      assert_true((mi[0][0] - 0.5).abs() < 0.0001)
      assert_true((mi[1][1] - 0.25).abs() < 0.0001)
      assert_true((mi[2][2] - 0.125).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "mat4_transpose basic" {
  let m = translation(3.0, 5.0, 7.0)
  let mt = mat4_transpose(m)
  assert_true((mt[3][0] - 3.0).abs() < 0.0000001)
  assert_true((mt[3][1] - 5.0).abs() < 0.0000001)
  assert_true((mt[3][2] - 7.0).abs() < 0.0000001)
}

///|
test "scaling and transform" {
  let s = scaling(2.0, 3.0, 4.0)
  let (x, y, z) = transform_point(s, 1.0, 1.0, 1.0)
  assert_true((x - 2.0).abs() < 0.0000001)
  assert_true((y - 3.0).abs() < 0.0000001)
  assert_true((z - 4.0).abs() < 0.0000001)
}

///|
test "transform_direction ignores translation" {
  let t = translation(10.0, 20.0, 30.0)
  let (x, y, z) = transform_direction(t, 1.0, 0.0, 0.0)
  assert_true((x - 1.0).abs() < 0.0000001)
  assert_true((y - 0.0).abs() < 0.0000001)
  assert_true((z - 0.0).abs() < 0.0000001)
}

///|
test "rotation_x 90 degrees" {
  let r = rotation_x(1.5707963267948966)
  let (_, y, z) = transform_point(r, 0.0, 1.0, 0.0)
  assert_true(y.abs() < 0.0001)
  assert_true((z - 1.0).abs() < 0.0001)
}

///|
test "rotation_y 90 degrees" {
  let r = rotation_y(1.5707963267948966)
  let (x, _, z) = transform_point(r, 0.0, 0.0, 1.0)
  assert_true((x - 1.0).abs() < 0.0001)
  assert_true(z.abs() < 0.0001)
}

///|
test "rotation_x zero angle is identity" {
  let r = rotation_x(0.0)
  let (x, y, z) = transform_point(r, 1.0, 2.0, 3.0)
  assert_true((x - 1.0).abs() < 0.0001)
  assert_true((y - 2.0).abs() < 0.0001)
  assert_true((z - 3.0).abs() < 0.0001)
}

///|
test "rotation_y zero angle is identity" {
  let r = rotation_y(0.0)
  let (x, y, z) = transform_point(r, 1.0, 2.0, 3.0)
  assert_true((x - 1.0).abs() < 0.0001)
  assert_true((y - 2.0).abs() < 0.0001)
  assert_true((z - 3.0).abs() < 0.0001)
}

///|
test "look_at basic" {
  let m = look_at((0.0, 0.0, 5.0), (0.0, 0.0, 0.0), (0.0, 1.0, 0.0))
  let (x, y, z) = transform_point(m, 0.0, 0.0, 0.0)
  ignore(x)
  ignore(y)
  assert_true(z.abs() <= 5.0)
}

///|
test "perspective basic" {
  let m = perspective(1.5707963267948966, 1.0, 0.1, 100.0)
  let (x, y, z) = transform_point(m, 0.0, 0.0, -1.0)
  ignore(x)
  ignore(y)
  ignore(z)
}

///|
test "ortho basic" {
  let m = ortho(-1.0, 1.0, -1.0, 1.0, 0.1, 100.0)
  let (x, y, z) = transform_point(m, 0.0, 0.0, 0.0)
  assert_true(x.abs() < 0.0001)
  assert_true(y.abs() < 0.0001)
  ignore(z)
}

///|
test "mat4_inverse singular returns None" {
  let m = [
    [0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0],
  ]
  assert_true(mat4_inverse(m) is None)
}

///|
test "mat4_determinant scaling" {
  let m = scaling(2.0, 3.0, 4.0)
  let det = mat4_determinant(m)
  assert_true((det - 24.0).abs() < 0.0001)
}

///|
test "mat4_mul identity" {
  let m = translation(1.0, 2.0, 3.0)
  let id = identity4()
  let c = mat4_mul(m, id)
  let (x, y, z) = transform_point(c, 0.0, 0.0, 0.0)
  assert_true((x - 1.0).abs() < 0.0001)
  assert_true((y - 2.0).abs() < 0.0001)
  assert_true((z - 3.0).abs() < 0.0001)
}

///|
test "transform_point w near zero" {
  // 构造一个 w 分量接近 0 的情况（透视矩阵在 z=0 处）
  let m = perspective(1.5707963267948966, 1.0, 0.1, 100.0)
  let (x, y, z) = transform_point(m, 1.0, 1.0, 0.0)
  ignore(x)
  ignore(y)
  ignore(z)
}

///|
test "mat4_transpose identity" {
  let m = identity4()
  let mt = mat4_transpose(m)
  for i in 0..<4 {
    for j in 0..<4 {
      assert_true((mt[i][j] - m[i][j]).abs() < 0.0000001)
    }
  }
}
