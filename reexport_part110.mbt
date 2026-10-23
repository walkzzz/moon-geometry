///|
pub fn rotation_y(angle : Double) -> Array[Array[Double]] {
  @matrix3d.rotation_y(angle)
}

///|
pub fn rotation_z(angle : Double) -> Array[Array[Double]] {
  @matrix3d.rotation_z(angle)
}

///|
pub fn mat4_mul(
  a : Array[Array[Double]],
  b : Array[Array[Double]],
) -> Array[Array[Double]] {
  @matrix3d.mat4_mul(a, b)
}

///|
pub fn transform_point(
  m : Array[Array[Double]],
  x : Double,
  y : Double,
  z : Double,
) -> (Double, Double, Double) {
  @matrix3d.transform_point(m, x, y, z)
}

///|
pub fn transform_direction(
  m : Array[Array[Double]],
  x : Double,
  y : Double,
  z : Double,
) -> (Double, Double, Double) {
  @matrix3d.transform_direction(m, x, y, z)
}

///|
pub fn mat4_transpose(m : Array[Array[Double]]) -> Array[Array[Double]] {
  @matrix3d.mat4_transpose(m)
}

///|
pub fn mat4_determinant(m : Array[Array[Double]]) -> Double {
  @matrix3d.mat4_determinant(m)
}