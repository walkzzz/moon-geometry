///|
pub fn euler_tour_is_valid(t : EulerTour) -> Bool {
  @euler_tour.euler_tour_is_valid(t)
}

// ---------------------------------------------------------------------------
// trapezoidal: trapezoidal decomposition / 梯形分解
// ---------------------------------------------------------------------------

///|
pub type Trapezoid = @trapezoidal.Trapezoid

///|
pub type TrapezoidalMap = @trapezoidal.TrapezoidalMap

///|
pub fn build_trapezoidal_map(segs : Array[Segment]) -> TrapezoidalMap {
  @trapezoidal.build_trapezoidal_map(segs)
}

///|
pub fn trapezoidal_locate(m : TrapezoidalMap, p : Point2D) -> Int {
  @trapezoidal.trapezoidal_locate(m, p)
}

///|
pub fn trapezoidal_count(m : TrapezoidalMap) -> Int {
  @trapezoidal.trapezoidal_count(m)
}

///|
pub fn trapezoidal_all(m : TrapezoidalMap) -> Array[Trapezoid] {
  @trapezoidal.trapezoidal_all(m)
}