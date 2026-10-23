///|
test "pack_circles basic" {
  let radii = [1.0, 1.0, 1.0]
  let positions = pack_circles(radii, 10.0)
  assert_true(positions.length() == 3)
}

///|
test "pack_rectangles basic" {
  let rects = [(2.0, 2.0), (3.0, 1.0), (1.0, 1.0)]
  let positions = pack_rectangles(rects, 10.0, 10.0)
  assert_true(positions.length() == 3)
}

///|
test "packing_density basic" {
  let radii = [1.0, 1.0]
  let density = packing_density(radii, 10.0)
  assert_true(density > 0.0 && density < 1.0)
}

///|
test "pack_circles too large" {
  let radii = [10.0]
  let positions = pack_circles(radii, 5.0)
  assert_true(positions.length() == 0)
}
