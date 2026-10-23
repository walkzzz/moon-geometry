///|
test "buffon needle" {
  let p = buffon_needle_probability(1.0, 2.0)
  assert_true(p > 0.31 && p < 0.33)
}

///|
test "bertrand probability" {
  assert_eq(bertrand_probability(1), 1.0 / 3.0)
  assert_eq(bertrand_probability(2), 1.0 / 4.0)
}

///|
test "geometric probability hit" {
  assert_eq(geometric_probability_hit(1.0, 4.0), 0.25)
}
