///|
test "icp_point_to_point translation" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let source = [
    @core.Point3D::new(0.3, 0.3, 0.3),
    @core.Point3D::new(1.3, 0.3, 0.3),
    @core.Point3D::new(0.3, 1.3, 0.3),
    @core.Point3D::new(0.3, 0.3, 1.3),
  ]
  let result = icp_point_to_point(source, target, 100)

  assert_true(result.error < 0.01)
}

///|
test "icp_point_to_point identical" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let result = icp_point_to_point(pts, pts, 10)
  assert_true(result.error < 0.001)
}

///|
test "icp_point_to_point empty" {
  let result = icp_point_to_point([], [], 10)
  assert_true(result.error == 0.0)
}

///|
test "icp_point_to_point rotation" {
  let target = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, -1.0, 0.0),
  ]
  let source = [
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(-1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, -1.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  ]
  let result = icp_point_to_point(source, target, 100)
  assert_true(result.error < 0.1)
}

///|
test "icp_point_to_plane basic" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
  ]
  let normals = [
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let source = [
    @core.Point3D::new(0.0, 0.0, 0.5),
    @core.Point3D::new(1.0, 0.0, 0.5),
    @core.Point3D::new(0.0, 1.0, 0.5),
    @core.Point3D::new(1.0, 1.0, 0.5),
  ]
  let result = icp_point_to_plane(source, target, normals, 50)
  assert_true(result.error >= 0.0)
}

///|
test "icp_point_to_plane empty" {
  let result = icp_point_to_plane([], [], [], 10)
  assert_true(result.error == 0.0)
}

///|
test "icp_apply identity" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let result = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 1.0).abs() < 0.001)
  assert_true((applied[0].y - 2.0).abs() < 0.001)
  assert_true((applied[0].z - 3.0).abs() < 0.001)
}

///|
test "icp_apply translation" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let result = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(5.0, 10.0, 15.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 6.0).abs() < 0.001)
  assert_true((applied[0].y - 12.0).abs() < 0.001)
  assert_true((applied[0].z - 18.0).abs() < 0.001)
}

///|
test "icp_rms_error basic" {
  let a = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(1.0, 0.0, 0.0)]
  let b = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(0.0, 0.0, 0.0)]
  let err = icp_rms_error(a, b)
  assert_true((err - 0.7071).abs() < 0.01)
}

///|
test "icp_rms_error zero" {
  let pts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let err = icp_rms_error(pts, pts)
  assert_true(err < 0.001)
}

///|
test "icp result rotation accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.5,
    10,
  )
  let rot = IcpResult::rotation(r)
  assert_eq(rot.length(), 9)
  assert_true((rot[0] - 1.0).abs() < 0.000001)
}

///|
test "icp result translation accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(1.0, 2.0, 3.0),
    0.0,
    0,
  )
  let t = IcpResult::translation(r)
  assert_true((t.x - 1.0).abs() < 0.000001)
  assert_true((t.y - 2.0).abs() < 0.000001)
  assert_true((t.z - 3.0).abs() < 0.000001)
}

///|
test "icp result error accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    1.5,
    0,
  )
  let e = IcpResult::error(r)
  assert_true((e - 1.5).abs() < 0.000001)
}

///|
test "icp result iterations accessor" {
  let r = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.0,
    42,
  )
  assert_eq(IcpResult::iterations(r), 42)
}

///|
test "icp apply with rotation" {
  let pts = [@core.Point3D::new(1.0, 0.0, 0.0)]
  let result = IcpResult::new(
    [0.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 0.0).abs() < 0.001)
  assert_true((applied[0].y - 1.0).abs() < 0.001)
}

///|
test "icp rms error empty" {
  let err = icp_rms_error([], [])
  assert_true(err < 0.000001)
}

///|
test "icp point to point single point" {
  let target = [@core.Point3D::new(5.0, 5.0, 5.0)]
  let source = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let result = icp_point_to_point(source, target, 50)
  assert_true(result.error < 0.01)
}

///|
test "icp point to plane identical" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let normals = [
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let result = icp_point_to_plane(pts, pts, normals, 20)
  assert_true(result.error >= 0.0)
}

///|
test "icp point to point large translation" {
  let target = [
    @core.Point3D::new(10.0, 10.0, 10.0),
    @core.Point3D::new(11.0, 10.0, 10.0),
    @core.Point3D::new(10.0, 11.0, 10.0),
    @core.Point3D::new(10.0, 10.0, 11.0),
  ]
  let source = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let result = icp_point_to_point(source, target, 100)
  assert_true(result.error < 0.1)
}

///|
test "icp apply multiple points" {
  let pts = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let result = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(1.0, 1.0, 1.0),
    0.0,
    0,
  )
  let applied = icp_apply(pts, result)
  assert_true((applied[0].x - 2.0).abs() < 0.001)
  assert_true((applied[1].y - 2.0).abs() < 0.001)
}

///|
test "icp rms error symmetric" {
  let a = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(3.0, 4.0, 0.0)]
  let b = [@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(0.0, 0.0, 0.0)]
  let err = icp_rms_error(a, b)
  assert_true((err - 3.5355).abs() < 0.01)
}

///|
test "mat3_identity basic" {
  let m = mat3_identity()
  assert_eq(m.length(), 9)
  assert_true((m[0] - 1.0).abs() < 0.000001)
  assert_true((m[4] - 1.0).abs() < 0.000001)
  assert_true((m[8] - 1.0).abs() < 0.000001)
  assert_true(m[1].abs() < 0.000001)
  assert_true(m[2].abs() < 0.000001)
}

///|
test "mat3_mul identity" {
  let id = mat3_identity()
  let a = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
  let r = mat3_mul(a, id)
  for i in 0..<9 {
    assert_true((r[i] - a[i]).abs() < 0.000001)
  }
}

///|
test "mat3_mul basic" {
  let a = [1.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0, 3.0]
  let b = [2.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, 4.0]
  let r = mat3_mul(a, b)
  assert_true((r[0] - 2.0).abs() < 0.000001)
  assert_true((r[4] - 6.0).abs() < 0.000001)
  assert_true((r[8] - 12.0).abs() < 0.000001)
}

///|
test "mat3_transpose basic" {
  let a = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0]
  let t = mat3_transpose(a)
  assert_true((t[1] - 4.0).abs() < 0.000001)
  assert_true((t[3] - 2.0).abs() < 0.000001)
  assert_true((t[0] - 1.0).abs() < 0.000001)
}

///|
test "mat3_transpose identity" {
  let id = mat3_identity()
  let t = mat3_transpose(id)
  for i in 0..<9 {
    assert_true((t[i] - id[i]).abs() < 0.000001)
  }
}

///|
test "mat3_vec basic" {
  let id = mat3_identity()
  let v = @core.Point3D::new(3.0, 4.0, 5.0)
  let r = mat3_vec(id, v)
  assert_true((r.x - 3.0).abs() < 0.000001)
  assert_true((r.y - 4.0).abs() < 0.000001)
  assert_true((r.z - 5.0).abs() < 0.000001)
}

///|
test "mat3_vec zero" {
  let a = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  let v = @core.Point3D::new(3.0, 4.0, 5.0)
  let r = mat3_vec(a, v)
  assert_true(r.x.abs() < 0.000001)
  assert_true(r.y.abs() < 0.000001)
  assert_true(r.z.abs() < 0.000001)
}

///|
test "jacobi_eigen diagonal" {
  let m = [2.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, 5.0]
  let (eigenvalues, _) = jacobi_eigen(m)
  assert_true((eigenvalues[0] - 2.0).abs() < 0.0001)
  assert_true((eigenvalues[1] - 3.0).abs() < 0.0001)
  assert_true((eigenvalues[2] - 5.0).abs() < 0.0001)
}

///|
test "jacobi_eigen identity" {
  let m = mat3_identity()
  let (eigenvalues, _) = jacobi_eigen(m)
  for i in 0..<3 {
    assert_true((eigenvalues[i] - 1.0).abs() < 0.0001)
  }
}

///|
test "kabsch empty" {
  let r = kabsch([], [])
  assert_eq(r.length(), 9)
  assert_true((r[0] - 1.0).abs() < 0.0001)
}

///|
test "kabsch identity" {
  let src = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
  ]
  let r = kabsch(src, src)
  assert_true((r[0] - 1.0).abs() < 0.01)
  assert_true((r[4] - 1.0).abs() < 0.01)
  assert_true((r[8] - 1.0).abs() < 0.01)
}

///|
test "centroid3d empty" {
  let c = centroid3d([])
  assert_true(c.x.abs() < 0.000001)
  assert_true(c.y.abs() < 0.000001)
  assert_true(c.z.abs() < 0.000001)
}

///|
test "centroid3d basic" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 4.0, 6.0),
  ]
  let c = centroid3d(pts)
  assert_true((c.x - 1.0).abs() < 0.000001)
  assert_true((c.y - 2.0).abs() < 0.000001)
  assert_true((c.z - 3.0).abs() < 0.000001)
}

///|
test "closest_idx basic" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let p = @core.Point3D::new(1.7, 0.0, 0.0)
  let idx = closest_idx(target, p)
  assert_eq(idx, 2)
}

///|
test "closest_idx exact" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  ]
  let p = @core.Point3D::new(1.0, 0.0, 0.0)
  let idx = closest_idx(target, p)
  assert_eq(idx, 1)
}

///|
test "transform_point identity" {
  let id = mat3_identity()
  let trans = @core.Point3D::new(0.0, 0.0, 0.0)
  let p = @core.Point3D::new(3.0, 4.0, 5.0)
  let r = transform_point(id, trans, p)
  assert_true((r.x - 3.0).abs() < 0.000001)
  assert_true((r.y - 4.0).abs() < 0.000001)
  assert_true((r.z - 5.0).abs() < 0.000001)
}

///|
test "transform_point translation only" {
  let id = mat3_identity()
  let trans = @core.Point3D::new(1.0, 2.0, 3.0)
  let p = @core.Point3D::new(0.0, 0.0, 0.0)
  let r = transform_point(id, trans, p)
  assert_true((r.x - 1.0).abs() < 0.000001)
  assert_true((r.y - 2.0).abs() < 0.000001)
  assert_true((r.z - 3.0).abs() < 0.000001)
}

///|
test "solve_linear basic" {
  let a = [[2.0, 0.0], [0.0, 3.0]]
  let b = [4.0, 9.0]
  match solve_linear(a, b) {
    Some(x) => {
      assert_true((x[0] - 2.0).abs() < 0.0001)
      assert_true((x[1] - 3.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "solve_linear identity" {
  let a = [[1.0, 0.0], [0.0, 1.0]]
  let b = [5.0, 7.0]
  match solve_linear(a, b) {
    Some(x) => {
      assert_true((x[0] - 5.0).abs() < 0.0001)
      assert_true((x[1] - 7.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "solve_linear empty" {
  match solve_linear([], []) {
    Some(x) => assert_eq(x.length(), 0)
    None => assert_true(false)
  }
}

///|
test "solve_linear singular" {
  let a = [[1.0, 1.0], [1.0, 1.0]]
  let b = [1.0, 2.0]
  match solve_linear(a, b) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

///|
test "solve_linear 3x3" {
  let a = [[1.0, 0.0, 0.0], [0.0, 2.0, 0.0], [0.0, 0.0, 4.0]]
  let b = [1.0, 4.0, 12.0]
  match solve_linear(a, b) {
    Some(x) => {
      assert_true((x[0] - 1.0).abs() < 0.0001)
      assert_true((x[1] - 2.0).abs() < 0.0001)
      assert_true((x[2] - 3.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
test "rodrigues zero" {
  let w = @core.Point3D::new(0.0, 0.0, 0.0)
  let r = rodrigues(w)
  assert_true((r[0] - 1.0).abs() < 0.0001)
  assert_true((r[4] - 1.0).abs() < 0.0001)
  assert_true((r[8] - 1.0).abs() < 0.0001)
}

///|
test "rodrigues z axis" {
  let angle = 1.5707963267948966
  let w = @core.Point3D::new(0.0, 0.0, angle)
  let r = rodrigues(w)
  assert_true((r[0] - 0.0).abs() < 0.001)
  assert_true((r[4] - 0.0).abs() < 0.001)
  assert_true((r[8] - 1.0).abs() < 0.0001)
}

///|
test "icp_point_to_point zero iterations" {
  let target = [@core.Point3D::new(1.0, 0.0, 0.0)]
  let source = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let result = icp_point_to_point(source, target, 0)
  assert_eq(result.iterations, 0)
}

///|
test "icp_point_to_plane zero iterations" {
  let target = [@core.Point3D::new(1.0, 0.0, 0.0)]
  let source = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let normals = [@core.Point3D::new(1.0, 0.0, 0.0)]
  let result = icp_point_to_plane(source, target, normals, 0)
  assert_eq(result.iterations, 0)
}

///|
test "icp_apply empty" {
  let result = IcpResult::new(
    [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0],
    @core.Point3D::new(0.0, 0.0, 0.0),
    0.0,
    0,
  )
  let applied = icp_apply([], result)
  assert_eq(applied.length(), 0)
}

///|
/// 触发 kabsch 中 det < 0 的反射修正分支（行 200-211）。
/// 源与目标手性相反（z 轴反射），最优旋转行列式为负，需翻转最小特征值对应向量。
/// 使用不对称点使 H^T*H 特征值分散，覆盖寻找最小特征值的循环（行 202-207）。
test "kabsch reflection det negative" {
  let src = [
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 3.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let tgt = [
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, -3.0),
    @core.Point3D::new(1.0, 1.0, -1.0),
  ]
  let r = kabsch(src, tgt)
  assert_eq(r.length(), 9)
  // 反射矩阵：z 轴翻转，r[8] 应近似 -1
  assert_true((r[8] + 1.0).abs() < 0.05)
  // x、y 轴保持
  assert_true((r[0] - 1.0).abs() < 0.05)
  assert_true((r[4] - 1.0).abs() < 0.05)
}

///|
/// 另一组反射点，确保最小特征值位于不同索引，覆盖行 204。
test "kabsch reflection alternate points" {
  let src = [
    @core.Point3D::new(3.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 2.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(2.0, 1.0, 0.0),
  ]
  let tgt = [
    @core.Point3D::new(3.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 2.0, 0.0),
    @core.Point3D::new(0.0, 0.0, -1.0),
    @core.Point3D::new(1.0, 2.0, -3.0),
    @core.Point3D::new(2.0, 1.0, 0.0),
  ]
  let r = kabsch(src, tgt)
  assert_eq(r.length(), 9)
  // z 轴反射
  assert_true((r[8] + 1.0).abs() < 0.1)
}

///|
/// 触发 solve_linear 部分选主元与行交换分支（行 354、362）。
/// 对角元为 0，消元时需在第一列中选主元并交换两行。
test "solve_linear partial pivoting row swap" {
  let a = [[0.0, 1.0], [1.0, 0.0]]
  let b = [1.0, 2.0]
  match solve_linear(a, b) {
    Some(x) => {
      // 交换后等价于 x + 0*y = 2, 0*x + y = 1
      assert_true((x[0] - 2.0).abs() < 0.0001)
      assert_true((x[1] - 1.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
/// 触发 solve_linear 3x3 选主元（行 354）。
test "solve_linear 3x3 partial pivoting" {
  let a = [[0.0, 1.0, 1.0], [1.0, 0.0, 1.0], [1.0, 1.0, 0.0]]
  let b = [2.0, 2.0, 2.0]
  match solve_linear(a, b) {
    Some(x) => {
      assert_true((x[0] - 1.0).abs() < 0.0001)
      assert_true((x[1] - 1.0).abs() < 0.0001)
      assert_true((x[2] - 1.0).abs() < 0.0001)
    }
    None => assert_true(false)
  }
}

///|
/// 触发 icp_point_to_plane 中 solve_linear 返回 Some 的分支（行 469-481）。
/// 法向量方向各异，使 6x6 AtA 矩阵非奇异，线性系统可解。
test "icp_point_to_plane solvable some branch" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 1.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let normals = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 1.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
    @core.Point3D::new(1.0, 2.0, 3.0),
  ]
  let source = [
    @core.Point3D::new(0.1, 0.1, 0.1),
    @core.Point3D::new(1.1, 0.1, 0.1),
    @core.Point3D::new(0.1, 1.1, 0.1),
    @core.Point3D::new(0.1, 0.1, 1.1),
    @core.Point3D::new(1.1, 1.1, 0.1),
    @core.Point3D::new(1.1, 0.1, 1.1),
    @core.Point3D::new(0.1, 1.1, 1.1),
    @core.Point3D::new(1.1, 1.1, 1.1),
  ]
  let result = icp_point_to_plane(source, target, normals, 30)
  assert_true(result.iterations >= 1)
}

///|
/// 触发 icp_point_to_plane 收敛提前退出分支（行 482-484）。
/// 源与目标几乎重合，首轮即收敛。
test "icp_point_to_plane convergence break" {
  let target = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  let normals = [
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 0.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 1.0),
  ]
  // 源与目标完全一致，应立即收敛
  let result = icp_point_to_plane(target, target, normals, 50)
  assert_true(result.iterations >= 1)
}
