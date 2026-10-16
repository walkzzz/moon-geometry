test "nerve_of_cover" {
  let n = nerve_of_cover(3, [(0, 1), (1, 2)])
  assert_eq(n.length(), 5)
}

test "nerve_homology" {
  let nerve = [[0], [1], [2], [0, 1], [1, 2]]
  let h = nerve_homology(nerve)
  assert_eq(h.length(), 2)
}

test "is_good_cover" {
  assert_true(is_good_cover([(0, 1)]))
}
