test "mapper_cover" {
  let cover = mapper_cover([0.0, 1.0, 2.0, 3.0, 4.0], 2, 0.1)
  assert_eq(cover.length(), 2)
}

test "mapper_cluster" {
  let c = mapper_cluster([0.5, 1.5, 2.5], (0.0, 1.0))
  assert_eq(c.length(), 1)
}
