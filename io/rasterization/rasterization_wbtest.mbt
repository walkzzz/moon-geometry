///|
test "buffer create" {
  let buf = RasterBuffer::new(10, 10)
  assert_eq(buf.width, 10)
  assert_eq(buf.height, 10)
  assert_eq(get_pixel(buf, 0, 0), 0)
}

///|
test "set pixel" {
  let buf = RasterBuffer::new(10, 10)
  set_pixel(buf, 5, 5, 1)
  assert_eq(get_pixel(buf, 5, 5), 1)
  assert_eq(get_pixel(buf, 0, 0), 0)
}

///|
test "set pixel out of bounds" {
  let buf = RasterBuffer::new(10, 10)
  set_pixel(buf, -1, 0, 1)
  set_pixel(buf, 10, 0, 1)
  assert_eq(get_pixel(buf, 0, 0), 0)
}

///|
test "raster horizontal line" {
  let buf = RasterBuffer::new(10, 10)
  raster_line(buf, 0, 5, 9, 5, 1)
  let mut count = 0
  for x in 0..<10 {
    if get_pixel(buf, x, 5) == 1 {
      count += 1
    }
  }
  assert_eq(count, 10)
}

///|
test "raster vertical line" {
  let buf = RasterBuffer::new(10, 10)
  raster_line(buf, 5, 0, 5, 9, 1)
  let mut count = 0
  for yA in 0..<10 {
    if get_pixel(buf, 5, yA) == 1 {
      count += 1
    }
  }
  assert_eq(count, 10)
}

///|
test "raster diagonal line" {
  let buf = RasterBuffer::new(10, 10)
  raster_line(buf, 0, 0, 9, 9, 1)
  assert_eq(get_pixel(buf, 0, 0), 1)
  assert_eq(get_pixel(buf, 9, 9), 1)
  assert_eq(get_pixel(buf, 5, 5), 1)
}

///|
test "raster triangle" {
  let buf = RasterBuffer::new(10, 10)
  raster_triangle(
    buf,
    @core.Point3D::new(2.0, 2.0, 0.5),
    @core.Point3D::new(8.0, 2.0, 0.5),
    @core.Point3D::new(5.0, 8.0, 0.5),
    1,
  )
  assert_eq(get_pixel(buf, 5, 3), 1)
  assert_true(count_filled(buf, 0) > 0)
}

///|
test "depth test" {
  let buf = RasterBuffer::new(10, 10)
  set_pixel_depth(buf, 5, 5, 1, 0.5)
  assert_eq(get_pixel(buf, 5, 5), 1)
  set_pixel_depth(buf, 5, 5, 2, 0.8)
  assert_eq(get_pixel(buf, 5, 5), 1)
  set_pixel_depth(buf, 5, 5, 3, 0.3)
  assert_eq(get_pixel(buf, 5, 5), 3)
}

///|
test "clear buffer" {
  let buf = RasterBuffer::new(5, 5)
  set_pixel(buf, 2, 2, 1)
  clear_buffer(buf, 0, 1000000.0)
  assert_eq(get_pixel(buf, 2, 2), 0)
}

///|
test "count filled" {
  let buf = RasterBuffer::new(10, 10)
  set_pixel(buf, 0, 0, 1)
  set_pixel(buf, 1, 1, 1)
  assert_eq(count_filled(buf, 0), 2)
}

///|
test "triangle depth interpolation" {
  let buf = RasterBuffer::new(10, 10)
  raster_triangle(
    buf,
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(9.0, 0.0, 1.0),
    @core.Point3D::new(0.0, 9.0, 1.0),
    1,
  )
  assert_eq(get_pixel(buf, 0, 0), 1)
  let d = get_depth(buf, 0, 0)
  assert_true(d < 1000000.0)
}
