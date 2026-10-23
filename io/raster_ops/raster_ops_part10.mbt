///|
/// Max value in raster (ignoring nodata). / 栅格最大值（忽略 nodata）。
pub fn raster_max(r : Raster) -> Double {
  let mut max_val = 0.0
  let mut found = false
  for v in r.data {
    if v != r.nodata {
      if !found {
        max_val = v
        found = true
      } else if v > max_val {
        max_val = v
      }
    }
  }
  if found {
    max_val
  } else {
    r.nodata
  }
}
