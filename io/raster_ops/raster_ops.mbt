///|
/// Raster grid: rows x cols of double values. / 栅格网格：rows x cols 的双精度值。
pub struct Raster {
  cols : Int32
  rows : Int32
  data : Array[Double]
  nodata : Double
}

///|
/// Construct a raster filled with a value. / 用指定值填充构造栅格。
pub fn Raster::new(
  cols : Int32,
  rows : Int32,
  fill : Double,
  nodata : Double,
) -> Raster {
  let n = cols * rows
  let data = Array::make(n, fill)
  { cols, rows, data, nodata, }
}

///|
/// Construct a raster from raw data. / 从原始数据构造栅格。
pub fn Raster::from_data(
  cols : Int32,
  rows : Int32,
  data : Array[Double],
  nodata : Double,
) -> Raster {
  { cols, rows, data, nodata, }
}
