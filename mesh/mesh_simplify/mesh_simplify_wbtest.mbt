///|
test "simplify edge length" {
  let m = @mesh_data.Mesh::new()
  let v0 = add_vertex_coords(m, 0.0, 0.0, 0.0)
  let v1 = add_vertex_coords(m, 1.0, 0.0, 0.0)
  let v2 = add_vertex_coords(m, 0.0, 1.0, 0.0)
  m.add_face(v0, v1, v2)
  let simplified = simplify_by_edge_length(m, 0.5)
  assert_true(@mesh_data.Mesh::vertex_count(simplified) <= 3)
}

///|
test "edge collapse cost" {
  let m = @mesh_data.Mesh::new()
  let v0 = add_vertex_coords(m, 0.0, 0.0, 0.0)
  let v1 = add_vertex_coords(m, 3.0, 4.0, 0.0)
  let cost = edge_collapse_cost(m, v0, v1)
  assert_true((cost - 5.0).abs() < 0.001)
}

///|
test "collapsible edges" {
  let m = @mesh_data.Mesh::new()
  ignore(add_vertex_coords(m, 0.0, 0.0, 0.0))
  ignore(add_vertex_coords(m, 0.5, 0.0, 0.0))
  ignore(add_vertex_coords(m, 5.0, 0.0, 0.0))
  let count = collapsible_edges(m, 1.0)
  assert_eq(count, 1)
}

///|
test "simplification ratio" {
  let m1 = @mesh_data.Mesh::new()
  ignore(add_vertex_coords(m1, 0.0, 0.0, 0.0))
  ignore(add_vertex_coords(m1, 1.0, 0.0, 0.0))
  ignore(add_vertex_coords(m1, 0.0, 1.0, 0.0))
  let m2 = @mesh_data.Mesh::new()
  ignore(add_vertex_coords(m2, 0.0, 0.0, 0.0))
  let ratio = simplification_ratio(m1, m2)
  assert_true((ratio - 0.6667).abs() < 0.01)
}

///|
test "simplify no change" {
  let m = @mesh_data.Mesh::new()
  let v0 = add_vertex_coords(m, 0.0, 0.0, 0.0)
  let v1 = add_vertex_coords(m, 10.0, 0.0, 0.0)
  let v2 = add_vertex_coords(m, 0.0, 10.0, 0.0)
  m.add_face(v0, v1, v2)
  let simplified = simplify_by_edge_length(m, 0.001)
  assert_eq(@mesh_data.Mesh::vertex_count(simplified), 3)
}
