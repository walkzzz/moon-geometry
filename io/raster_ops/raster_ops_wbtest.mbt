test "raster construct and get" {
  let r = Raster::new(3, 2, 5.0, -9999.0)
  assert_eq(Raster::cols(r), 3)
  assert_eq(Raster::rows(r), 2)
  assert_true(((Raster::get(r, 0, 0)) - (5.0)).abs() <= (0.001))
}

test "raster set and get" {
  let r = Raster::new(3, 2, 0.0, -9999.0)
  r.set(1, 1, 42.0)
  assert_true(((Raster::get(r, 1, 1)) - (42.0)).abs() <= (0.001))
}

test "raster get out of bounds" {
  let r = Raster::new(2, 2, 1.0, -9999.0)
  assert_true(((Raster::get(r, 5, 5)) - (-9999.0)).abs() <= (0.001))
}

test "resample nearest upscale" {
  let r = Raster::from_data(2, 2, [0.0, 10.0, 20.0, 30.0], -9999.0)
  let r2 = resample_nearest(r, 4, 4)
  assert_eq(Raster::cols(r2), 4)
  assert_true(((Raster::get(r2, 0, 0)) - (0.0)).abs() <= (0.001))
  assert_true(((Raster::get(r2, 3, 3)) - (30.0)).abs() <= (0.001))
}

test "resample bilinear identity" {
  let r = Raster::from_data(3, 3, [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0], -9999.0)
  let r2 = resample_bilinear(r, 3, 3)
  assert_true(((Raster::get(r2, 0, 0)) - (0.0)).abs() <= (0.001))
  assert_true(((Raster::get(r2, 2, 2)) - (8.0)).abs() <= (0.001))
}

test "mosaic basic" {
  let r1 = Raster::from_data(2, 2, [1.0, 1.0, 1.0, 1.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [2.0, -9999.0, -9999.0, 2.0], -9999.0)
  let m = mosaic(r1, r2)
  assert_true(((Raster::get(m, 0, 0)) - (2.0)).abs() <= (0.001))
  assert_true(((Raster::get(m, 1, 0)) - (1.0)).abs() <= (0.001))
  assert_true(((Raster::get(m, 0, 1)) - (1.0)).abs() <= (0.001))
  assert_true(((Raster::get(m, 1, 1)) - (2.0)).abs() <= (0.001))
}

test "raster add" {
  let r1 = Raster::from_data(2, 2, [1.0, 2.0, 3.0, 4.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [10.0, 20.0, 30.0, 40.0], -9999.0)
  let r3 = raster_add(r1, r2)
  assert_true(((Raster::get(r3, 0, 0)) - (11.0)).abs() <= (0.001))
  assert_true(((Raster::get(r3, 1, 1)) - (44.0)).abs() <= (0.001))
}

test "raster subtract" {
  let r1 = Raster::from_data(2, 2, [10.0, 20.0, 30.0, 40.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [1.0, 2.0, 3.0, 4.0], -9999.0)
  let r3 = raster_subtract(r1, r2)
  assert_true(((Raster::get(r3, 0, 0)) - (9.0)).abs() <= (0.001))
  assert_true(((Raster::get(r3, 1, 1)) - (36.0)).abs() <= (0.001))
}

test "raster multiply" {
  let r1 = Raster::from_data(2, 2, [2.0, 3.0, 4.0, 5.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [2.0, 3.0, 4.0, 5.0], -9999.0)
  let r3 = raster_multiply(r1, r2)
  assert_true(((Raster::get(r3, 0, 0)) - (4.0)).abs() <= (0.001))
  assert_true(((Raster::get(r3, 1, 1)) - (25.0)).abs() <= (0.001))
}

test "raster add scalar" {
  let r = Raster::from_data(2, 2, [1.0, 2.0, 3.0, 4.0], -9999.0)
  let r2 = raster_add_scalar(r, 10.0)
  assert_true(((Raster::get(r2, 0, 0)) - (11.0)).abs() <= (0.001))
  assert_true(((Raster::get(r2, 1, 1)) - (14.0)).abs() <= (0.001))
}

test "raster min max" {
  let r = Raster::from_data(3, 1, [3.0, 7.0, 1.0], -9999.0)
  assert_true(((raster_min(r)) - (1.0)).abs() <= (0.001))
  assert_true(((raster_max(r)) - (7.0)).abs() <= (0.001))
}