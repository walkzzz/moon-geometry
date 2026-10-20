test "interval_tree build and query" {
  let intervals = [
    { lo: 0.0, hi: 5.0, id: 0 },
    { lo: 3.0, hi: 8.0, id: 1 },
    { lo: 6.0, hi: 10.0, id: 2 },
    { lo: 1.0, hi: 4.0, id: 3 },
  ]
  let tree = interval_tree_build(intervals)
  assert_eq(interval_tree_count(tree), 4)
}

test "interval_tree stabbing query" {
  let intervals = [
    { lo: 0.0, hi: 5.0, id: 0 },
    { lo: 3.0, hi: 8.0, id: 1 },
    { lo: 6.0, hi: 10.0, id: 2 },
    { lo: 1.0, hi: 4.0, id: 3 },
  ]
  let tree = interval_tree_build(intervals)
  let result = interval_tree_query(tree, 3.5)
  assert_eq(result.length(), 3)
}

test "interval_tree empty" {
  let tree = interval_tree_build([])
  assert_eq(interval_tree_count(tree), 0)
}

test "interval_tree single" {
  let intervals = [{ lo: 0.0, hi: 5.0, id: 0 }]
  let tree = interval_tree_build(intervals)
  let result = interval_tree_query(tree, 2.5)
  assert_eq(result.length(), 1)
}

test "interval_tree no match" {
  let intervals = [
    { lo: 0.0, hi: 5.0, id: 0 },
    { lo: 10.0, hi: 15.0, id: 1 },
  ]
  let tree = interval_tree_build(intervals)
  let result = interval_tree_query(tree, 7.5)
  assert_eq(result.length(), 0)
}