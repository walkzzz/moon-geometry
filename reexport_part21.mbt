///|
/// Trace of the matrix. / 矩阵的迹。
pub fn mat2_trace(m : Mat2) -> Double {
  @matrix.Mat2::trace(m)
}

// ---------------------------------------------------------------------------
// angle: angle utilities / 角度工具
// ---------------------------------------------------------------------------


///|
/// Degrees to radians. / 角度转弧度。
pub fn deg_to_rad(deg : Double) -> Double {
  @angle.deg_to_rad(deg)
}


///|
/// Radians to degrees. / 弧度转角度。
pub fn rad_to_deg(rad : Double) -> Double {
  @angle.rad_to_deg(rad)
}


///|
/// Normalize angle to [0, 2π). / 归一化角度到 [0, 2π)。
pub fn normalize_angle(angle : Double) -> Double {
  @angle.normalize_angle(angle)
}


///|
/// Normalize angle to [-π, π). / 归一化角度到 [-π, π)。
pub fn normalize_angle_signed(angle : Double) -> Double {
  @angle.normalize_angle_signed(angle)
}


///|
/// Angular difference (b - a) normalized to [-π, π]. / 角差归一化到 [-π, π]。
pub fn angle_diff(a : Double, b : Double) -> Double {
  @angle.angle_diff(a, b)
}


///|
/// Bisector angle of two angles. / 两角平分线角度。
pub fn angle_bisector(a : Double, b : Double) -> Double {
  @angle.bisector(a, b)
}
