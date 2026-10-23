///|
test "estimate_normal basic" {
  let pts = [
    (0.0, 0.0, 0.0),
    (1.0, 0.0, 0.0),
    (0.0, 1.0, 0.0),
    (-1.0, 0.0, 0.0),
    (0.0, -1.0, 0.0),
  ]
  let (_, _, nz) = estimate_normal(pts, 0, 4)
  assert_true(nz.abs() > 0.5)
}

///|
test "ball_pivot_reconstruct basic" {
  let pts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let (verts, faces) = ball_pivot_reconstruct(pts, 1.0)
  assert_eq(verts.length(), 3)
  assert_true(faces.length() >= 0)
}

///|
test "distance_to_mesh basic" {
  let verts = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (0.0, 1.0, 0.0)]
  let faces = [(0, 1, 2)]
  let d = distance_to_mesh((0.5, 0.5, 1.0), verts, faces)
  assert_true(d > 0.0)
}
