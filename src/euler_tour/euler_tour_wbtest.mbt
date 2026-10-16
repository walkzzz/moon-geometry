test "euler tour single node" {
  let adj : Array[Array[Int]] = [[]]
  let tour = build_euler_tour(1, adj, 0)
  assert_eq(euler_tour_length(tour), 1)
}

test "euler tour path" {
  let adj : Array[Array[Int]] = [[1], [0, 2], [1]]
  let tour = build_euler_tour(3, adj, 0)
  let seq = euler_tour_sequence(tour)
  assert_eq(seq[0], 0)
  assert_true(euler_tour_is_valid(tour))
}

test "euler tour star" {
  let adj : Array[Array[Int]] = [[1, 2, 3], [0], [0], [0]]
  let tour = build_euler_tour(4, adj, 0)
  let seq = euler_tour_sequence(tour)
  assert_eq(seq[0], 0)
  assert_eq(seq[seq.length() - 1], 0)
}

test "euler tour lca" {
  let adj : Array[Array[Int]] = [[1, 2], [0, 3, 4], [0], [1], [1]]
  let tour = build_euler_tour(5, adj, 0)
  let lca = euler_tour_lca(tour, 3, 4)
  assert_eq(lca, 1)
  let lca2 = euler_tour_lca(tour, 3, 2)
  assert_eq(lca2, 0)
}

test "euler tour depth" {
  let adj : Array[Array[Int]] = [[1], [0, 2], [1]]
  let tour = build_euler_tour(3, adj, 0)
  let depths = euler_tour_depths(tour)
  assert_eq(depths[0], 0)
}