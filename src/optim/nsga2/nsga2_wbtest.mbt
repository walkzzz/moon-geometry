test "Nsga2Config::new" {
  let config = Nsga2Config::new(100, 200, 2, 0.9, 0.1)
  assert_eq(config.pop_size, 100)
}

test "non_dominated_sort" {
  let objs = [[1.0, 2.0], [2.0, 1.0], [3.0, 3.0]]
  let fronts = non_dominated_sort(objs)
  assert_true(fronts.length() >= 1)
}
