///|
/// # Diffusion Solver | 扩散求解器
/// General diffusion solver. / 通用扩散求解器。
///|
pub fn crank_nicolson_coef(d : Double, dt : Double, dx : Double) -> Double {
  d * dt / (2.0 * dx * dx)
}
///|
pub fn diffusion_2d_step(field : Array[Array[Double]], d : Double, dt : Double, dx : Double, dy : Double) -> Array[Array[Double]] {
  let rows = field.length()
  let result = []
  for i in 0..<rows {
    let cols = field[i].length()
    let row = Array::make(cols, 0.0)
    for j in 0..<cols {
      let left = if j > 0 { field[i][j - 1] } else { field[i][j] }
      let right = if j < cols - 1 { field[i][j + 1] } else { field[i][j] }
      let up = if i > 0 { field[i - 1][j] } else { field[i][j] }
      let down = if i < rows - 1 { field[i + 1][j] } else { field[i][j] }
      let rx = d * dt / (dx * dx)
      let ry = d * dt / (dy * dy)
      row[j] = field[i][j] + rx * (left - 2.0 * field[i][j] + right) + ry * (up - 2.0 * field[i][j] + down)
    }
    result.push(row)
  }
  result
}
///|
pub fn diffusion_stability_check(d : Double, dt : Double, dx : Double) -> Bool {
  d * dt / (dx * dx) <= 0.5
}
