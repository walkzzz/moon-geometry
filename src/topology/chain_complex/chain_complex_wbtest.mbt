test "ChainComplex::new" {
  let cc = ChainComplex::new([3, 3, 1])
  assert_eq(chain_rank(cc, 0), 3)
  assert_eq(chain_rank(cc, 2), 1)
}

test "chain_total_rank" {
  let cc = ChainComplex::new([3, 3, 1])
  assert_eq(chain_total_rank(cc), 7)
}
