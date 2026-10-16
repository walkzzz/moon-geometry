test "dominates" {
  assert_true(dominates([1.0, 1.0], [2.0, 2.0]))
  assert_false(dominates([1.0, 2.0], [2.0, 1.0]))
}

test "pareto_front_points" {
  let objs = [[1.0, 4.0], [2.0, 2.0], [3.0, 1.0], [4.0, 4.0]]
  let pf = pareto_front_points(objs)
  assert_true(pf.length() >= 2)
}

test "hypervolume_2d" {
  let pts = [(1.0, 1.0)]
  let hv = hypervolume_2d(pts, (5.0, 5.0))
  assert_true(hv > 0.0)
}
