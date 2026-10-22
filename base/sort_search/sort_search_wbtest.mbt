
test "sort_search_binary_found" {
  let arr = [1.0, 3.0, 5.0, 7.0, 9.0]
  match binary_search(arr, 5.0) {
    Some(idx) => assert_eq(idx, 2)
    None => assert_true(false)
  }
}

test "sort_search_binary_not_found" {
  let arr = [1.0, 3.0, 5.0, 7.0, 9.0]
  match binary_search(arr, 4.0) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "sort_search_lower_bound" {
  let arr = [1.0, 3.0, 5.0, 7.0, 9.0]
  assert_eq(lower_bound(arr, 5.0), 2)
  assert_eq(lower_bound(arr, 4.0), 2)
  assert_eq(lower_bound(arr, 0.0), 0)
  assert_eq(lower_bound(arr, 10.0), 5)
}

test "sort_search_upper_bound" {
  let arr = [1.0, 3.0, 5.0, 7.0, 9.0]
  assert_eq(upper_bound(arr, 5.0), 3)
  assert_eq(upper_bound(arr, 4.0), 2)
  assert_eq(upper_bound(arr, 0.0), 0)
  assert_eq(upper_bound(arr, 10.0), 5)
}

test "sort_search_unique" {
  let arr = [1.0, 1.0, 2.0, 3.0, 3.0, 3.0, 4.0]
  let result = unique_sorted(arr)
  assert_eq(result.length(), 4)
  assert_true((result[0] - 1.0).abs() < 0.000000000001)
  assert_true((result[3] - 4.0).abs() < 0.000000000001)
}

test "sort_search_is_sorted" {
  assert_true(is_sorted([1.0, 2.0, 3.0, 4.0]))
  assert_false(is_sorted([1.0, 3.0, 2.0, 4.0]))
  assert_true(is_sorted([]))
  assert_true(is_sorted([5.0]))
}

test "sort_search_kth" {
  let arr = [9.0, 3.0, 7.0, 1.0, 5.0]
  match kth_element(arr, 2) {
    Some(v) => assert_true((v - 5.0).abs() < 0.000000000001)
    None => assert_true(false)
  }
}

test "sort_search_merge" {
  let a = [1.0, 3.0, 5.0]
  let b = [2.0, 4.0, 6.0]
  let result = merge_sorted(a, b)
  assert_eq(result.length(), 6)
  assert_true(is_sorted(result))
}