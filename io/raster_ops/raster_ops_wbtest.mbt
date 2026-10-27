///|
test "raster construct and get" {
  let r = Raster::new(3, 2, 5.0, -9999.0)
  assert_eq(Raster::cols(r), 3)
  assert_eq(Raster::rows(r), 2)
  assert_true((Raster::get(r, 0, 0) - 5.0).abs() <= 0.001)
}

///|
test "raster set and get" {
  let r = Raster::new(3, 2, 0.0, -9999.0)
  r.set(1, 1, 42.0)
  assert_true((Raster::get(r, 1, 1) - 42.0).abs() <= 0.001)
}

///|
test "raster get out of bounds" {
  let r = Raster::new(2, 2, 1.0, -9999.0)
  assert_true((Raster::get(r, 5, 5) - -9999.0).abs() <= 0.001)
}

///|
test "resample nearest upscale" {
  let r = Raster::from_data(2, 2, [0.0, 10.0, 20.0, 30.0], -9999.0)
  let r2 = resample_nearest(r, 4, 4)
  assert_eq(Raster::cols(r2), 4)
  assert_true((Raster::get(r2, 0, 0) - 0.0).abs() <= 0.001)
  assert_true((Raster::get(r2, 3, 3) - 30.0).abs() <= 0.001)
}

///|
test "resample bilinear identity" {
  let r = Raster::from_data(
    3,
    3,
    [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0],
    -9999.0,
  )
  let r2 = resample_bilinear(r, 3, 3)
  assert_true((Raster::get(r2, 0, 0) - 0.0).abs() <= 0.001)
  assert_true((Raster::get(r2, 2, 2) - 8.0).abs() <= 0.001)
}

///|
test "mosaic basic" {
  let r1 = Raster::from_data(2, 2, [1.0, 1.0, 1.0, 1.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [2.0, -9999.0, -9999.0, 2.0], -9999.0)
  let m = mosaic(r1, r2)
  assert_true((Raster::get(m, 0, 0) - 2.0).abs() <= 0.001)
  assert_true((Raster::get(m, 1, 0) - 1.0).abs() <= 0.001)
  assert_true((Raster::get(m, 0, 1) - 1.0).abs() <= 0.001)
  assert_true((Raster::get(m, 1, 1) - 2.0).abs() <= 0.001)
}

///|
test "raster add" {
  let r1 = Raster::from_data(2, 2, [1.0, 2.0, 3.0, 4.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [10.0, 20.0, 30.0, 40.0], -9999.0)
  let r3 = raster_add(r1, r2)
  assert_true((Raster::get(r3, 0, 0) - 11.0).abs() <= 0.001)
  assert_true((Raster::get(r3, 1, 1) - 44.0).abs() <= 0.001)
}

///|
test "raster subtract" {
  let r1 = Raster::from_data(2, 2, [10.0, 20.0, 30.0, 40.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [1.0, 2.0, 3.0, 4.0], -9999.0)
  let r3 = raster_subtract(r1, r2)
  assert_true((Raster::get(r3, 0, 0) - 9.0).abs() <= 0.001)
  assert_true((Raster::get(r3, 1, 1) - 36.0).abs() <= 0.001)
}

///|
test "raster multiply" {
  let r1 = Raster::from_data(2, 2, [2.0, 3.0, 4.0, 5.0], -9999.0)
  let r2 = Raster::from_data(2, 2, [2.0, 3.0, 4.0, 5.0], -9999.0)
  let r3 = raster_multiply(r1, r2)
  assert_true((Raster::get(r3, 0, 0) - 4.0).abs() <= 0.001)
  assert_true((Raster::get(r3, 1, 1) - 25.0).abs() <= 0.001)
}

///|
test "raster add scalar" {
  let r = Raster::from_data(2, 2, [1.0, 2.0, 3.0, 4.0], -9999.0)
  let r2 = raster_add_scalar(r, 10.0)
  assert_true((Raster::get(r2, 0, 0) - 11.0).abs() <= 0.001)
  assert_true((Raster::get(r2, 1, 1) - 14.0).abs() <= 0.001)
}

///|
test "raster min max" {
  let r = Raster::from_data(3, 1, [3.0, 7.0, 1.0], -9999.0)
  assert_true((raster_min(r) - 1.0).abs() <= 0.001)
  assert_true((raster_max(r) - 7.0).abs() <= 0.001)
}

///|
test "raster set out of bounds" {
  let r = Raster::new(2, 2, 1.0, -9999.0)
  r.set(5, 5, 42.0)
  assert_true((Raster::get(r, 0, 0) - 1.0).abs() <= 0.001)
}

///|
test "resample nearest downscale" {
  let r = Raster::from_data(
    4,
    4,
    [
      0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0,
      15.0,
    ],
    -9999.0,
  )
  let r2 = resample_nearest(r, 2, 2)
  assert_eq(Raster::cols(r2), 2)
  assert_eq(Raster::rows(r2), 2)
}

///|
test "resample bilinear upscale" {
  let r = Raster::from_data(2, 2, [0.0, 10.0, 20.0, 30.0], -9999.0)
  let r2 = resample_bilinear(r, 4, 4)
  assert_eq(Raster::cols(r2), 4)
  assert_true((Raster::get(r2, 0, 0) - 0.0).abs() <= 0.001)
  assert_true((Raster::get(r2, 3, 3) - 30.0).abs() <= 0.001)
}

///|
test "raster min all nodata" {
  let r = Raster::from_data(2, 2, [-9999.0, -9999.0, -9999.0, -9999.0], -9999.0)
  assert_true((raster_min(r) - -9999.0).abs() <= 0.001)
}

///|
test "raster max all nodata" {
  let r = Raster::from_data(2, 2, [-9999.0, -9999.0, -9999.0, -9999.0], -9999.0)
  assert_true((raster_max(r) - -9999.0).abs() <= 0.001)
}

///|
test "mosaic different sizes" {
  let r1 = Raster::from_data(
    3,
    3,
    [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
    -9999.0,
  )
  let r2 = Raster::from_data(2, 2, [2.0, 2.0, 2.0, 2.0], -9999.0)
  let m = mosaic(r1, r2)
  assert_eq(Raster::cols(m), 3)
  assert_eq(Raster::rows(m), 3)
  assert_true((Raster::get(m, 0, 0) - 2.0).abs() <= 0.001)
  assert_true((Raster::get(m, 2, 2) - 1.0).abs() <= 0.001)
}

///|
test "raster add different sizes" {
  let r1 = Raster::from_data(
    3,
    3,
    [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0],
    -9999.0,
  )
  let r2 = Raster::from_data(2, 2, [10.0, 20.0, 30.0, 40.0], -9999.0)
  let r3 = raster_add(r1, r2)
  assert_eq(Raster::cols(r3), 2)
  assert_eq(Raster::rows(r3), 2)
}

///|
test "raster min with nodata mixed" {
  let r = Raster::from_data(4, 1, [-9999.0, 5.0, -9999.0, 3.0], -9999.0)
  assert_true((raster_min(r) - 3.0).abs() <= 0.001)
}

///|
test "raster max with nodata mixed" {
  let r = Raster::from_data(4, 1, [-9999.0, 5.0, -9999.0, 3.0], -9999.0)
  assert_true((raster_max(r) - 5.0).abs() <= 0.001)
}
