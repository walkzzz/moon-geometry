test "HomologyGroup::new" {
  let hg = HomologyGroup::new(1, 2, [])
  assert_eq(betti_number(hg), 2)
}

test "is_trivial" {
  assert_true(is_trivial(HomologyGroup::new(0, 0, [])))
  assert_false(is_trivial(HomologyGroup::new(0, 1, [])))
}

test "euler_characteristic" {
  let groups = [HomologyGroup::new(0, 1, []), HomologyGroup::new(2, 1, [])]
  assert_eq(euler_characteristic(groups), 2)
}
