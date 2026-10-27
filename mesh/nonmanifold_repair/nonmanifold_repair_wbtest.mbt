///|
test "count nonmanifold edges manifold" {
  let faces = [(0, 1, 2), (0, 2, 3)]
  assert_eq(count_nonmanifold_edges(faces), 0)
}

///|
test "count nonmanifold edges nonmanifold" {
  let faces = [(0, 1, 2), (0, 1, 3), (0, 1, 4)]
  assert_eq(count_nonmanifold_edges(faces), 1)
}

///|
test "repair nonmanifold edges" {
  let faces = [(0, 1, 2), (0, 1, 3), (0, 1, 4)]
  let repaired = repair_nonmanifold_edges(faces)
  let count = count_nonmanifold_edges(repaired)
  assert_true(count < count_nonmanifold_edges(faces))
}
