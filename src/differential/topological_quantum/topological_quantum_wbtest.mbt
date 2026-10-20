test "anyon braid phase" {
  let p = anyon_braid_phase(1.5707963267948966, 2)
  assert_eq(p, 3.141592653589793)
}

test "ising anyon phase" {
  let p = ising_anyon_phase(2)
  assert_eq(p, 1.5707963267948966)
}

test "majorana fusion rule" {
  assert_eq(majorana_fusion_rule(3), 1)
  assert_eq(majorana_fusion_rule(4), 0)
}
