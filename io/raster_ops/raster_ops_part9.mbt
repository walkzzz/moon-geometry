///|
/// Min value in raster (ignoring nodata). / 栅格最小值（忽略 nodata）。
pub fn raster_min(r : Raster) -> Double {
  let mut min_val = 0.0
  let mut found = false
  for v in r.data {
    if v != r.nodata {
      if !found {
        min_val = v
        found = true
      } else if v < min_val {
        min_val = v
      }
    }
  }
  if found {
    min_val
  } else {
    r.nodata
  }
}
