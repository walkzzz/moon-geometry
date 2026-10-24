///|
test "project parametrize planar" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let uv = project_parametrize(verts)
  assert_eq(uv.length(), 4)
}

///|
test "project parametrize 3d" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 1.0, 1.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
  ]
  let uv = project_parametrize(verts)
  assert_eq(uv.length(), 4)
}

///|
test "project parametrize empty" {
  let uv = project_parametrize([])
  assert_eq(uv.length(), 0)
}

///|
test "harmonic parametrize" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 2, 3)]
  let boundary = [0, 1, 2, 3]
  let result = harmonic_parametrize(verts, faces, boundary)
  assert_true(result.success)
  assert_eq(result.uv.length(), 4)
}

///|
test "harmonic boundary on circle" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 2.0, 0.0),
    @core.Point3D::new(0.0, 2.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 2, 3)]
  let boundary = [0, 1, 2, 3]
  let result = harmonic_parametrize(verts, faces, boundary)
  for idx in boundary {
    let u = result.uv[idx].u
    let v = result.uv[idx].v
    let r = (u * u + v * v).sqrt()
    assert_true((r - 1.0).abs() < 0.001)
  }
}

///|
test "area distortion" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let uv = [UV::new(0.0, 0.0), UV::new(1.0, 0.0), UV::new(0.0, 1.0)]
  let d = area_distortion(verts, faces, uv)
  assert_true(d < 0.001)
}

///|
test "uv construct" {
  let uv = UV::new(1.0, 2.0)
  assert_eq(uv.u, 1.0)
  assert_eq(uv.v, 2.0)
}

///|
test "harmonic empty" {
  let result = harmonic_parametrize([], [], [])
  assert_false(result.success)
}

///|
test "mesh param result construct" {
  let uv = [UV::new(0.0, 0.0), UV::new(1.0, 1.0)]
  let r = MeshParamResult::new(uv, true)
  assert_true(r.success)
  assert_eq(r.uv.length(), 2)
}

///|
test "mesh param result construct failure" {
  let r = MeshParamResult::new([], false)
  assert_false(r.success)
  assert_eq(r.uv.length(), 0)
}

///|
test "project parametrize single point" {
  let verts = [@core.Point3D::new(1.0, 2.0, 3.0)]
  let uv = project_parametrize(verts)
  assert_eq(uv.length(), 1)
  assert_true(uv[0].u.abs() < 0.0001)
  assert_true(uv[0].v.abs() < 0.0001)
}

///|
test "project parametrize collinear" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
  ]
  let uv = project_parametrize(verts)
  assert_eq(uv.length(), 3)
}

///|
test "harmonic parametrize no boundary" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let result = harmonic_parametrize(verts, faces, [])
  assert_true(result.success)
  assert_eq(result.uv.length(), 3)
}

///|
test "harmonic parametrize boundary out of range" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 1.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2), (0, 2, 3)]
  let boundary = [100, -1]
  let result = harmonic_parametrize(verts, faces, boundary)
  assert_true(result.success)
}

///|
test "area distortion empty faces" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let uv = [UV::new(0.0, 0.0), UV::new(1.0, 0.0), UV::new(0.0, 1.0)]
  let d = area_distortion(verts, [], uv)
  assert_true((d - 0.0).abs() < 0.001)
}

///|
test "area distortion zero 2d" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 1.0, 0.0),
  ]
  let faces = [(0, 1, 2)]
  let uv = [UV::new(0.0, 0.0), UV::new(0.0, 0.0), UV::new(0.0, 0.0)]
  let d = area_distortion(verts, faces, uv)
  assert_true((d - 0.0).abs() < 0.001)
}

///|
test "uv construct zero" {
  let uv = UV::new(0.0, 0.0)
  assert_true(uv.u.abs() < 0.000000001)
  assert_true(uv.v.abs() < 0.000000001)
}

///|
test "project parametrize two points" {
  let verts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  ]
  let uv = project_parametrize(verts)
  assert_eq(uv.length(), 2)
}
