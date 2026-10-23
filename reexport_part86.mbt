///|
pub fn circle_sample(c : Point2D, r : Double, n : Int) -> Array[Point2D] {
  @sampling.circle_sample(c, r, n)
}

///|
pub fn circle_interior_sample(c : Point2D, r : Double, n : Int) -> Array[Point2D] {
  @sampling.circle_interior_sample(c, r, n)
}

///|
pub fn poisson_disk_sample(xlo : Double, xhi : Double, ylo : Double, yhi : Double, md : Double) -> Array[Point2D] {
  @sampling.poisson_disk_sample(xlo, xhi, ylo, yhi, md)
}

///|
pub fn segment_sample(p1 : Point2D, p2 : Point2D, n : Int) -> Array[Point2D] {
  @sampling.segment_sample(p1, p2, n)
}

///|
pub fn halton_sample(bx : Int, by : Int, n : Int) -> Array[Point2D] {
  @sampling.halton_sample(bx, by, n)
}

// ---------------------------------------------------------------------------
// svg_out: SVG output / SVG 输出
// ---------------------------------------------------------------------------

///|
pub type SvgSettings = @svg_out.SvgSettings

///|
pub fn svg_settings_default() -> SvgSettings {
  @svg_out.SvgSettings::default()
}