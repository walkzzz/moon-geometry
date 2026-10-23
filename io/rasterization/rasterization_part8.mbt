///|
/// Count non-background pixels. / 统计非背景像素数。
pub fn count_filled(buf : RasterBuffer, bg : Int) -> Int {
  let mut count = 0
  for c in buf.color {
    if c != bg {
      count += 1
    }
  }
  count
}

fn min3(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

fn max3(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

fn min2(a : Int, b : Int) -> Int {
  if a < b {
    a
  } else {
    b
  }
}

fn max2(a : Int, b : Int) -> Int {
  if a > b {
    a
  } else {
    b
  }
}

fn floor_int(x : Double) -> Int {
  let f = @math.floor(x)
  f.to_int()
}

fn ceil_int(x : Double) -> Int {
  let f = @math.ceil(x)
  f.to_int()
}