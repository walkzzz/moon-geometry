test "ramachandran allowed" {
  assert_true(ramachandran_allowed(-1.0472, -0.6981))
}

test "helix pitch" {
  let p = helix_pitch(1.5, 1.7453292519943295)
  assert_true(p > 5.0 && p < 6.0)
}

test "secondary structure" {
  let s = secondary_structure_type(-1.0472, -0.6981)
  assert_eq(s, "helix")
}
