test "witness_complex_landmarks" {
  let sc = witness_complex_landmarks(100, 3)
  assert_true(sc.length() >= 3)
}

test "witness_skeleton" {
  let n = witness_skeleton(1, 3)
  assert_eq(n, 6)
}

test "landmark_count" {
  assert_eq(landmark_count(100, 0.1), 10)
}
