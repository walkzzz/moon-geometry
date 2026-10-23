///|
test "is_closed_manifold" {
  let faces = [(0, 1, 2), (0, 2, 3), (0, 3, 1), (1, 3, 2)]
  let result = is_closed_manifold(faces)
  assert_true(result)
}

///|
test "find_dangling_edges" {
  let faces = [(0, 1, 2), (0, 2, 3)]
  let results = find_dangling_edges(faces)
  assert_true(results.length() >= 1)
}

///|
test "find_isolated_vertices" {
  let faces = [(0, 1, 2)]
  let results = find_isolated_vertices(5, faces)
  assert_eq(results.length(), 2)
}

///|
test "validate_topology" {
  let faces = [(0, 1, 2), (0, 2, 3)]
  let results = validate_topology(4, faces)
  assert_true(results.length() >= 1)
}

///|
test "TopologyIssue variants" {
  ignore(NonManifoldEdge)
  ignore(NonManifoldVertex)
  ignore(DanglingEdge)
  ignore(InconsistentNormal)
  ignore(IsolatedVertex)
}
