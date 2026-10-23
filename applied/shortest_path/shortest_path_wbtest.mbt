///|
test "dijkstra basic" {
  let n = 4
  let adj : Array[Array[GraphEdge]] = [
    [{ to: 1, weight: 1.0, }, { to: 2, weight: 4.0, }],
    [{ to: 0, weight: 1.0, }, { to: 2, weight: 2.0, }, { to: 3, weight: 5.0, }],
    [{ to: 0, weight: 4.0, }, { to: 1, weight: 2.0, }, { to: 3, weight: 1.0, }],
    [{ to: 1, weight: 5.0, }, { to: 2, weight: 1.0, }],
  ]
  let dist = dijkstra(n, adj, 0)
  assert_true((dist[0] - 0.0).abs() < 0.001)
  assert_true((dist[1] - 1.0).abs() < 0.001)
  assert_true((dist[2] - 3.0).abs() < 0.001)
  assert_true((dist[3] - 4.0).abs() < 0.001)
}

///|
test "shortest_path_dist basic" {
  let n = 3
  let adj : Array[Array[GraphEdge]] = [
    [{ to: 1, weight: 2.0, }],
    [{ to: 2, weight: 3.0, }],
    [],
  ]
  let d = shortest_path_dist(n, adj, 0, 2)
  assert_true((d - 5.0).abs() < 0.001)
}

///|
test "shortest_path_vertices basic" {
  let n = 3
  let adj : Array[Array[GraphEdge]] = [
    [{ to: 1, weight: 2.0, }],
    [{ to: 2, weight: 3.0, }],
    [],
  ]
  let path = shortest_path_vertices(n, adj, 0, 2)
  assert_eq(path.length(), 3)
  assert_eq(path[0], 0)
  assert_eq(path[2], 2)
}

///|
test "dijkstra unreachable" {
  let n = 3
  let adj : Array[Array[GraphEdge]] = [[], [], []]
  let d = shortest_path_dist(n, adj, 0, 2)
  assert_true(d < 0.0)
}

///|
test "dijkstra single vertex" {
  let n = 1
  let adj : Array[Array[GraphEdge]] = [[]]
  let dist = dijkstra(n, adj, 0)
  assert_true((dist[0] - 0.0).abs() < 0.001)
}
