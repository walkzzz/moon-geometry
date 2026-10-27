///|
test "volume new and get set" {
  let vol = VolumeData::new((3, 3, 3), (1.0, 1.0, 1.0))
  vol.set(1, 2, 0, 5.0)
  assert_true((vol.get(1, 2, 0) - 5.0).abs() < 0.000001)
  assert_true((vol.get(0, 0, 0) - 0.0).abs() < 0.000001)
}

///|
test "volume write vtk" {
  let vol = VolumeData::new((2, 2, 1), (1.0, 1.0, 1.0))
  vol.set(0, 0, 0, 1.0)
  vol.set(1, 1, 0, 2.0)
  let s = write_vtk_ascii(vol)
  assert_true(s.contains("DATASET STRUCTURED_POINTS"))
  assert_true(s.contains("DIMENSIONS 2 2 1"))
  assert_true(s.contains("SCALARS values double 1"))
  assert_true(s.contains("LOOKUP_TABLE default"))
}

///|
test "volume data size" {
  let vol = VolumeData::new((2, 3, 4), (0.5, 0.5, 0.5))
  assert_eq(vol.data.length(), 24)
}

///|
test "volume indexing" {
  let vol = VolumeData::new((2, 2, 2), (1.0, 1.0, 1.0))
  vol.set(0, 0, 0, 1.0)
  vol.set(1, 0, 0, 2.0)
  vol.set(0, 1, 0, 3.0)
  vol.set(1, 1, 1, 4.0)
  assert_true((vol.get(0, 0, 0) - 1.0).abs() < 0.000001)
  assert_true((vol.get(1, 0, 0) - 2.0).abs() < 0.000001)
  assert_true((vol.get(0, 1, 0) - 3.0).abs() < 0.000001)
  assert_true((vol.get(1, 1, 1) - 4.0).abs() < 0.000001)
}
