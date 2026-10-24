///|
test "crossing number" {
  let n = crossing_number([1, 2, 3, 2])
  assert_eq(n, 3)
}

///|
test "writhe" {
  let w = writhe([1, 1, -1, 1])
  assert_eq(w, 2)
}

///|
test "jones unknot" {
  assert_eq(jones_unknot(2.0), 1.0)
}

///|
test "jones trefoil at 1" {
  let v = jones_trefoil(1.0)
  assert_true((v - 0.0).abs() < 0.001)
}

///|
test "jones trefoil at 2" {
  let v = jones_trefoil(2.0)
  let expect = -4.0 - 1.0 / 4.0 + 1.0 / 2.0 + 2.0
  assert_true((v - expect).abs() < 0.001)
}

///|
test "jones figure8 at 1" {
  let v = jones_figure8(1.0)
  assert_true((v - 1.0).abs() < 0.001)
}

///|
test "jones figure8 at 2" {
  let v = jones_figure8(2.0)
  let t2 = 4.0
  let t4 = 16.0
  let expect = t2 - 1.0 / 2.0 + 1.0 / t2 - 1.0 / t4 + t4
  assert_true((v - expect).abs() < 0.001)
}

///|
test "linking number" {
  let c1 = [(0.0, 0.0, 0.0), (1.0, 0.0, 0.0)]
  let c2 = [(0.0, 1.0, 0.0), (1.0, 1.0, 0.0)]
  assert_eq(linking_number(c1, c2), 0)
}

///|
test "unknotting number" {
  assert_eq(unknotting_number(0), 0)
  assert_eq(unknotting_number(1), 1)
  assert_eq(unknotting_number(3), 3)
}

///|
test "crossing number empty" {
  assert_eq(crossing_number([]), 0)
}

///|
test "writhe empty" {
  assert_eq(writhe([]), 0)
}
