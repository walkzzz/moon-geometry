///|
/// ECEF coordinate. / 地心地固坐标。
pub type ECEF = @coordinate_convert.ECEF


///|
/// Geodetic coordinate. / 大地坐标。
pub type Geodetic = @coordinate_convert.Geodetic

pub fn ecef_new(x : Double, y : Double, z : Double) -> ECEF {
  @coordinate_convert.ECEF::new(x, y, z)
}

pub fn geodetic_new(lat : Double, lon : Double, h : Double) -> Geodetic {
  @coordinate_convert.Geodetic::new(lat, lon, h)
}

pub fn wgs84_to_ecef(g : Geodetic) -> ECEF {
  @coordinate_convert.wgs84_to_ecef(g)
}

pub fn ecef_to_wgs84(e : ECEF) -> Geodetic {
  @coordinate_convert.ecef_to_wgs84(e)
}

pub fn cgcs2000_to_ecef(g : Geodetic) -> ECEF {
  @coordinate_convert.cgcs2000_to_ecef(g)
}

pub fn ecef_to_cgcs2000(e : ECEF) -> Geodetic {
  @coordinate_convert.ecef_to_cgcs2000(e)
}

pub fn wgs84_to_cgcs2000(g : Geodetic) -> Geodetic {
  @coordinate_convert.wgs84_to_cgcs2000(g)
}

pub fn cgcs2000_to_wgs84(g : Geodetic) -> Geodetic {
  @coordinate_convert.cgcs2000_to_wgs84(g)
}

pub fn ecef_distance(e1 : ECEF, e2 : ECEF) -> Double {
  @coordinate_convert.ecef_distance(e1, e2)
}

// ---------------------------------------------------------------------------
// datum_transform: Datum transformation / 基准转换
// ---------------------------------------------------------------------------


///|
/// 7-parameter Helmert transform. / 七参数 Helmert 变换。
pub type Helmert7 = @datum_transform.Helmert7


///|
/// 3-parameter transform. / 三参数变换。
pub type Helmert3 = @datum_transform.Helmert3

pub fn helmert7_new(
  tx : Double,
  ty : Double,
  tz : Double,
  rx : Double,
  ry : Double,
  rz : Double,
  scale : Double,
) -> Helmert7 {
  @datum_transform.Helmert7::new(tx, ty, tz, rx, ry, rz, scale)
}

pub fn helmert3_new(tx : Double, ty : Double, tz : Double) -> Helmert3 {
  @datum_transform.Helmert3::new(tx, ty, tz)
}

pub fn apply_helmert7(h : Helmert7, x : Double, y : Double, z : Double) -> (Double, Double, Double) {
  @datum_transform.apply_helmert7(h, x, y, z)
}

pub fn apply_helmert3(h : Helmert3, x : Double, y : Double, z : Double) -> (Double, Double, Double) {
  @datum_transform.apply_helmert3(h, x, y, z)
}

pub fn inverse_helmert7(h : Helmert7) -> Helmert7 {
  @datum_transform.inverse_helmert7(h)
}

pub fn inverse_helmert3(h : Helmert3) -> Helmert3 {
  @datum_transform.inverse_helmert3(h)
}

pub fn helmert7_identity() -> Helmert7 {
  @datum_transform.helmert7_identity()
}

pub fn compose_helmert7(a : Helmert7, b : Helmert7) -> Helmert7 {
  @datum_transform.compose_helmert7(a, b)
}

// ---------------------------------------------------------------------------
// raster_ops: Raster operations / 栅格操作
// ---------------------------------------------------------------------------


///|
/// Raster grid. / 栅格网格。
pub type Raster = @raster_ops.Raster

pub fn raster_new(cols : Int, rows : Int, fill : Double, nodata : Double) -> Raster {
  @raster_ops.Raster::new(cols, rows, fill, nodata)
}

pub fn raster_from_data(
  cols : Int,
  rows : Int,
  data : Array[Double],
  nodata : Double,
) -> Raster {
  @raster_ops.Raster::from_data(cols, rows, data, nodata)
}

pub fn raster_get(r : Raster, col : Int, row : Int) -> Double {
  @raster_ops.Raster::get(r, col, row)
}

pub fn raster_set(r : Raster, col : Int, row : Int, val : Double) -> Unit {
  @raster_ops.Raster::set(r, col, row, val)
}

pub fn raster_cols(r : Raster) -> Int {
  @raster_ops.Raster::cols(r)
}

pub fn raster_rows(r : Raster) -> Int {
  @raster_ops.Raster::rows(r)
}

pub fn resample_nearest(r : Raster, new_cols : Int, new_rows : Int) -> Raster {
  @raster_ops.resample_nearest(r, new_cols, new_rows)
}

pub fn resample_bilinear(r : Raster, new_cols : Int, new_rows : Int) -> Raster {
  @raster_ops.resample_bilinear(r, new_cols, new_rows)
}

pub fn raster_mosaic(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.mosaic(r1, r2)
}

pub fn raster_add(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.raster_add(r1, r2)
}

pub fn raster_subtract(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.raster_subtract(r1, r2)
}

pub fn raster_multiply(r1 : Raster, r2 : Raster) -> Raster {
  @raster_ops.raster_multiply(r1, r2)
}

pub fn raster_add_scalar(r : Raster, c : Double) -> Raster {
  @raster_ops.raster_add_scalar(r, c)
}

pub fn raster_min(r : Raster) -> Double {
  @raster_ops.raster_min(r)
}

pub fn raster_max(r : Raster) -> Double {
  @raster_ops.raster_max(r)
}

// ---------------------------------------------------------------------------
// contour_line: Contour line extraction / 等值线提取
// ---------------------------------------------------------------------------


///|
/// Contour line segment. / 等值线段。
pub type ContourSegment = @contour_line.ContourSegment


///|
/// Contour grid. / 等值线栅格。
pub type ContourGrid = @contour_line.ContourGrid

pub fn contour_segment_new(
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> ContourSegment {
  @contour_line.ContourSegment::new(x1, y1, x2, y2)
}

pub fn contour_grid_new(
  cols : Int,
  rows : Int,
  data : Array[Double],
  cell_size : Double,
  x_origin : Double,
  y_origin : Double,
) -> ContourGrid {
  @contour_line.ContourGrid::new(cols, rows, data, cell_size, x_origin, y_origin)
}

pub fn marching_squares(g : ContourGrid, level : Double) -> Array[ContourSegment] {
  @contour_line.marching_squares(g, level)
}

pub fn extract_contours(
  g : ContourGrid,
  levels : Array[Double],
) -> Array[(Double, Array[ContourSegment])] {
  @contour_line.extract_contours(g, levels)
}

pub fn label_cell(g : ContourGrid, col : Int, row : Int, level : Double) -> Int {
  @contour_line.label_cell(g, col, row, level)
}

pub fn count_contour_segments(g : ContourGrid, level : Double) -> Int {
  @contour_line.count_contour_segments(g, level)
}

// ---------------------------------------------------------------------------
// watershed: Watershed algorithm / 分水岭算法
// ---------------------------------------------------------------------------
