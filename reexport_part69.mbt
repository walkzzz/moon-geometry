///|
pub fn trapezoidal_above_segment(s : Segment, p : Point2D) -> Bool {
  @trapezoidal.trapezoidal_above_segment(s, p)
}

///|
pub fn trapezoidal_expected_count(m : TrapezoidalMap) -> Int {
  @trapezoidal.trapezoidal_expected_count(m)
}

// ---------------------------------------------------------------------------
// zone: zone theorem / 区域定理
// ---------------------------------------------------------------------------

///|
pub type Zone = @zone.Zone

///|
pub fn compute_zone(line : Line, segs : Array[Segment]) -> Zone {
  @zone.compute_zone(line, segs)
}

///|
pub fn zone_crossed_count(z : Zone) -> Int {
  @zone.zone_crossed_count(z)
}

///|
pub fn zone_entry_points(z : Zone) -> Array[Point2D] {
  @zone.zone_entry_points(z)
}

///|
pub fn zone_crossed_faces(z : Zone) -> Array[Int] {
  @zone.zone_crossed_faces(z)
}