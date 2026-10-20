test "astar_grid no obstacles" {
  let grid = AStarGrid::new(10, 10)
  let result = astar_grid(grid, (0, 0), (9, 9), Euclidean, false)
  assert_true(result.success)
  assert_true(result.path.length() >= 2)
}

test "astar_grid with obstacle" {
  let grid = AStarGrid::new(10, 10)
  for i in 0..<8 {
    grid.set_blocked(5, i)
  }
  let result = astar_grid(grid, (0, 0), (9, 9), Manhattan, false)
  assert_true(result.success)
}

test "astar_grid diagonal" {
  let grid = AStarGrid::new(10, 10)
  let result = astar_grid(grid, (0, 0), (9, 9), Euclidean, true)
  assert_true(result.success)
}

test "astar_grid blocked start" {
  let grid = AStarGrid::new(10, 10)
  grid.set_blocked(0, 0)
  let result = astar_grid(grid, (0, 0), (9, 9), Manhattan, false)
  assert_false(result.success)
}

test "astar_grid blocked goal" {
  let grid = AStarGrid::new(10, 10)
  grid.set_blocked(9, 9)
  let result = astar_grid(grid, (0, 0), (9, 9), Manhattan, false)
  assert_false(result.success)
}

test "astar_grid start equals goal" {
  let grid = AStarGrid::new(10, 10)
  let result = astar_grid(grid, (5, 5), (5, 5), Euclidean, false)
  assert_true(result.success)
  assert_eq(result.path.length(), 1)
}

test "astar_grid no path" {
  let grid = AStarGrid::new(10, 10)
  for i in 0..<10 {
    grid.set_blocked(5, i)
  }
  let result = astar_grid(grid, (0, 0), (9, 0), Manhattan, false)
  assert_false(result.success)
}

test "astar_graph basic" {
  let nodes = [
    AStarGraphNode::new(0, 0.0, 0.0),
    AStarGraphNode::new(1, 1.0, 0.0),
    AStarGraphNode::new(2, 2.0, 0.0),
  ]
  let adj : Array[Array[(Int, Double)]] = [
    [(1, 1.0)],
    [(0, 1.0), (2, 1.0)],
    [(1, 1.0)],
  ]
  let result = astar_graph(nodes, adj, 0, 2)
  assert_true(result.success)
  assert_eq(result.path.length(), 3)
}

test "astar_graph no path" {
  let nodes = [
    AStarGraphNode::new(0, 0.0, 0.0),
    AStarGraphNode::new(1, 5.0, 5.0),
  ]
  let adj : Array[Array[(Int, Double)]] = [[], []]
  let result = astar_graph(nodes, adj, 0, 1)
  assert_false(result.success)
}

test "astar_path_cost basic" {
  let path = [(0, 0), (3, 4)]
  let cost = astar_path_cost(path)
  assert_true((cost - 5.0).abs() < 0.001)
}

test "astar_grid chebyshev heuristic" {
  let grid = AStarGrid::new(10, 10)
  let result = astar_grid(grid, (0, 0), (9, 9), Chebyshev, true)
  assert_true(result.success)
}