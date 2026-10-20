test "loft_linear basic" {
  let c1 = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)]
  let c2 = [(0.0, 0.0, 1.0), (1.0, 0.0, 1.0)]
  let mid = loft_linear(c1, c2, 0.5)
  let (x, _, z) = mid[0]
  assert_true(x.abs() < 0.0001)
  assert_true((z - 0.5).abs() < 0.0001)
}

test "loft_cubic endpoints" {
  let c0 = [(0.0, 0.0, 0.0)]
  let c1 = [(0.0, 0.0, 0.0)]
  let c2 = [(0.0, 0.0, 1.0)]
  let c3 = [(0.0, 0.0, 1.0)]
  let r0 = loft_cubic(c0, c1, c2, c3, 0.0)
  let (_, _, z0) = r0[0]
  assert_true(z0.abs() < 0.0001)
  let r1 = loft_cubic(c0, c1, c2, c3, 1.0)
  let (_, _, z1) = r1[0]
  assert_true((z1 - 1.0).abs() < 0.0001)
}

test "loft_mesh basic" {
  let s1 = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)]
  let s2 = [(0.0, 0.0, 1.0), (1.0, 0.0, 1.0)]
  let sections = [s1, s2]
  let (verts, faces) = loft_mesh(sections, 2)
  assert_true(verts.length() > 0)
  assert_true(faces.length() > 0)
}

test "loft_point basic" {
  let s1 = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)]
  let s2 = [(0.0, 0.0, 1.0), (1.0, 0.0, 1.0)]
  let sections = [s1, s2]
  let (x, _, z) = loft_point(sections, 0.5, 0.5)
  assert_true((x - 0.5).abs() < 0.0001)
  assert_true((z - 0.5).abs() < 0.0001)
}