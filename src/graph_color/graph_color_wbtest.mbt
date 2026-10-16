test "greedy_color basic" {
  let n = 4
  let adj : Array[Array[Int]] = [[1, 2], [0, 2, 3], [0, 1, 3], [1, 2]]
  let colors = greedy_color(n, adj)
  assert_eq(colors.length(), 4)
  assert_true(is_valid_coloring(n, adj, colors))
}

test "chromatic_number_upper triangle" {
  let n = 3
  let adj : Array[Array[Int]] = [[1, 2], [0, 2], [0, 1]]
  let chi = chromatic_number_upper(n, adj)
  assert_eq(chi, 3)
}

test "is_bipartite even cycle" {
  let n = 4
  let adj : Array[Array[Int]] = [[1, 3], [0, 2], [1, 3], [0, 2]]
  assert_true(is_bipartite(n, adj))
}

test "is_bipartite odd cycle" {
  let n = 3
  let adj : Array[Array[Int]] = [[1, 2], [0, 2], [0, 1]]
  assert_false(is_bipartite(n, adj))
}

test "greedy_color empty graph" {
  let n = 3
  let adj : Array[Array[Int]] = [[], [], []]
  let colors = greedy_color(n, adj)
  assert_eq(colors[0], 0)
  assert_eq(colors[1], 0)
  assert_eq(colors[2], 0)
}