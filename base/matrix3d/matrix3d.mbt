/// |
/// # 3D Matrix Operations
/// # 3D 矩阵运算
///
/// 4×4 transformation matrices for 3D affine geometry.
/// 用于 3D 仿射几何的 4×4 变换矩阵。
///
/// ## Representation: row-major Array[Array[Double]], 4×4
/// ## 表示: 行主序 Array[Array[Double]], 4×4

///|
/// |
/// Create 4×4 identity matrix.
/// 创建 4×4 单位矩阵。
pub fn identity4() -> Array[Array[Double]] {
  [
    [1.0, 0.0, 0.0, 0.0],
    [0.0, 1.0, 0.0, 0.0],
    [0.0, 0.0, 1.0, 0.0],
    [0.0, 0.0, 0.0, 1.0],
  ]
}

///|
/// |
/// Create translation matrix.
/// 创建平移矩阵。
///
/// # Arguments / 参数
/// - `tx`, `ty`, `tz`: translation offsets / 平移偏移量
pub fn translation(
  tx : Double,
  ty : Double,
  tz : Double,
) -> Array[Array[Double]] {
  [
    [1.0, 0.0, 0.0, tx],
    [0.0, 1.0, 0.0, ty],
    [0.0, 0.0, 1.0, tz],
    [0.0, 0.0, 0.0, 1.0],
  ]
}

///|
/// |
/// Create scaling matrix.
/// 创建缩放矩阵。
///
/// # Arguments / 参数
/// - `sx`, `sy`, `sz`: scale factors / 缩放因子
pub fn scaling(sx : Double, sy : Double, sz : Double) -> Array[Array[Double]] {
  [
    [sx, 0.0, 0.0, 0.0],
    [0.0, sy, 0.0, 0.0],
    [0.0, 0.0, sz, 0.0],
    [0.0, 0.0, 0.0, 1.0],
  ]
}

///|
/// |
/// Create rotation matrix around X-axis.
/// 创建绕 X 轴旋转矩阵。
///
/// # Arguments / 参数
/// - `angle`: rotation angle in radians / 旋转角度（弧度）
pub fn rotation_x(angle : Double) -> Array[Array[Double]] {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  [
    [1.0, 0.0, 0.0, 0.0],
    [0.0, c, -s, 0.0],
    [0.0, s, c, 0.0],
    [0.0, 0.0, 0.0, 1.0],
  ]
}

///|
/// |
/// Create rotation matrix around Y-axis.
/// 创建绕 Y 轴旋转矩阵。
///
/// # Arguments / 参数
/// - `angle`: rotation angle in radians / 旋转角度（弧度）
pub fn rotation_y(angle : Double) -> Array[Array[Double]] {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  [
    [c, 0.0, s, 0.0],
    [0.0, 1.0, 0.0, 0.0],
    [-s, 0.0, c, 0.0],
    [0.0, 0.0, 0.0, 1.0],
  ]
}

///|
/// |
/// Create rotation matrix around Z-axis.
/// 创建绕 Z 轴旋转矩阵。
///
/// # Arguments / 参数
/// - `angle`: rotation angle in radians / 旋转角度（弧度）
pub fn rotation_z(angle : Double) -> Array[Array[Double]] {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  [
    [c, -s, 0.0, 0.0],
    [s, c, 0.0, 0.0],
    [0.0, 0.0, 1.0, 0.0],
    [0.0, 0.0, 0.0, 1.0],
  ]
}

///|
/// |
/// Multiply two 4×4 matrices: result = a × b.
/// 两个 4×4 矩阵相乘: result = a × b。
pub fn mat4_mul(
  a : Array[Array[Double]],
  b : Array[Array[Double]],
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<4 {
    let row : Array[Double] = []
    for j in 0..<4 {
      let mut sum = 0.0
      for k in 0..<4 {
        sum += a[i][k] * b[k][j]
      }
      row.push(sum)
    }
    result.push(row)
  }
  result
}

///|
/// |
/// Transform a 3D point by a 4×4 matrix (homogeneous coordinates).
/// 用 4×4 矩阵变换 3D 点（齐次坐标）。
///
/// # Arguments / 参数
/// - `m`: 4×4 matrix / 4×4 矩阵
/// - `x`, `y`, `z`: point coordinates / 点坐标
///
/// Returns `(x', y', z')` after perspective divide.
/// 返回透视除法后的 `(x', y', z')`。
pub fn transform_point(
  m : Array[Array[Double]],
  x : Double,
  y : Double,
  z : Double,
) -> (Double, Double, Double) {
  let w = m[3][0] * x + m[3][1] * y + m[3][2] * z + m[3][3]
  let wx = m[0][0] * x + m[0][1] * y + m[0][2] * z + m[0][3]
  let wy = m[1][0] * x + m[1][1] * y + m[1][2] * z + m[1][3]
  let wz = m[2][0] * x + m[2][1] * y + m[2][2] * z + m[2][3]
  if w.abs() < 0.0000000001 {
    (wx, wy, wz)
  } else {
    (wx / w, wy / w, wz / w)
  }
}

///|
/// |
/// Transform a 3D direction vector by a 4×4 matrix (ignores translation).
/// 用 4×4 矩阵变换 3D 方向向量（忽略平移分量）。
///
/// # Arguments / 参数
/// - `m`: 4×4 matrix / 4×4 矩阵
/// - `x`, `y`, `z`: direction components / 方向分量
pub fn transform_direction(
  m : Array[Array[Double]],
  x : Double,
  y : Double,
  z : Double,
) -> (Double, Double, Double) {
  let wx = m[0][0] * x + m[0][1] * y + m[0][2] * z
  let wy = m[1][0] * x + m[1][1] * y + m[1][2] * z
  let wz = m[2][0] * x + m[2][1] * y + m[2][2] * z
  (wx, wy, wz)
}

///|
/// |
/// Transpose a 4×4 matrix.
/// 转置 4×4 矩阵。
pub fn mat4_transpose(m : Array[Array[Double]]) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<4 {
    let row : Array[Double] = []
    for j in 0..<4 {
      row.push(m[j][i])
    }
    result.push(row)
  }
  result
}

///|
/// |
/// Compute 4×4 matrix determinant using cofactor expansion.
/// 使用余子式展开计算 4×4 矩阵行列式。
pub fn mat4_determinant(m : Array[Array[Double]]) -> Double {
  let mut det = 0.0
  for j in 0..<4 {
    let sign = if j % 2 == 0 { 1.0 } else { -1.0 }
    det += sign * m[0][j] * mat3_determinant(m, 0, j)
  }
  det
}

///|
/// |
/// Compute 3×3 minor determinant (excluding row `excl_row` and col `excl_col`).
/// 计算 3×3 子行列式（排除行 `excl_row` 和列 `excl_col`）。
fn mat3_determinant(
  m : Array[Array[Double]],
  excl_row : Int32,
  excl_col : Int32,
) -> Double {
  let rows : Array[Int32] = []
  let cols : Array[Int32] = []
  for i in 0..<4 {
    if i != excl_row {
      rows.push(i)
    }
  }
  for j in 0..<4 {
    if j != excl_col {
      cols.push(j)
    }
  }
  let a = m[rows[0]][cols[0]]
  let b = m[rows[0]][cols[1]]
  let c = m[rows[0]][cols[2]]
  let d = m[rows[1]][cols[0]]
  let e = m[rows[1]][cols[1]]
  let f = m[rows[1]][cols[2]]
  let g = m[rows[2]][cols[0]]
  let h = m[rows[2]][cols[1]]
  let k = m[rows[2]][cols[2]]
  a * (e * k - f * h) - b * (d * k - f * g) + c * (d * h - e * g)
}

///|
/// |
/// Compute 4×4 matrix inverse using adjugate method.
/// 使用伴随矩阵法计算 4×4 矩阵逆。
///
/// Returns `None` if matrix is singular.
/// 矩阵奇异时返回 `None`。
pub fn mat4_inverse(m : Array[Array[Double]]) -> Array[Array[Double]]? {
  let det = mat4_determinant(m)
  if det.abs() < 0.0000000001 {
    return None
  }
  let inv : Array[Array[Double]] = []
  for i in 0..<4 {
    let row : Array[Double] = []
    for j in 0..<4 {
      let sign = if (i + j) % 2 == 0 { 1.0 } else { -1.0 }
      let cofactor = sign * mat3_determinant(m, j, i)
      row.push(cofactor / det)
    }
    inv.push(row)
  }
  Some(inv)
}

///|
/// |
/// Create a look-at view matrix (camera transformation).
/// 创建观察矩阵（相机变换）。
///
/// # Arguments / 参数
/// - `eye`: camera position (ex, ey, ez) / 相机位置
/// - `target`: look-at target (tx, ty, tz) / 目标点
/// - `up`: up direction (ux, uy, uz) / 上方向
pub fn look_at(
  eye : (Double, Double, Double),
  target : (Double, Double, Double),
  up : (Double, Double, Double),
) -> Array[Array[Double]] {
  let (ex, ey, ez) = eye
  let (tx, ty, tz) = target
  let (ux, uy, uz) = up
  let fx = tx - ex
  let fy = ty - ey
  let fz = tz - ez
  let flen = (fx * fx + fy * fy + fz * fz).sqrt()
  let fxn = fx / flen
  let fyn = fy / flen
  let fzn = fz / flen
  let rx = fyn * uz - fzn * uy
  let ry = fzn * ux - fxn * uz
  let rz = fxn * uy - fyn * ux
  let rlen = (rx * rx + ry * ry + rz * rz).sqrt()
  let rxn = rx / rlen
  let ryn = ry / rlen
  let rzn = rz / rlen
  let uxn = ryn * fzn - rzn * fyn
  let uyn = rzn * fxn - rxn * fzn
  let uzn = rxn * fyn - ryn * fxn
  [
    [rxn, ryn, rzn, -(rxn * ex + ryn * ey + rzn * ez)],
    [uxn, uyn, uzn, -(uxn * ex + uyn * ey + uzn * ez)],
    [-fxn, -fyn, -fzn, fxn * ex + fyn * ey + fzn * ez],
    [0.0, 0.0, 0.0, 1.0],
  ]
}

///|
/// |
/// Create a perspective projection matrix.
/// 创建透视投影矩阵。
///
/// # Arguments / 参数
/// - `fovy`: field of view in radians / 视野角度（弧度）
/// - `aspect`: aspect ratio (width/height) / 宽高比
/// - `near`, `far`: clipping planes / 裁剪平面
pub fn perspective(
  fovy : Double,
  aspect : Double,
  near : Double,
  far : Double,
) -> Array[Array[Double]] {
  let f = 1.0 / @math.tan(fovy / 2.0)
  let nf = 1.0 / (near - far)
  [
    [f / aspect, 0.0, 0.0, 0.0],
    [0.0, f, 0.0, 0.0],
    [0.0, 0.0, (far + near) * nf, 2.0 * far * near * nf],
    [0.0, 0.0, -1.0, 0.0],
  ]
}

///|
/// |
/// Create an orthographic projection matrix.
/// 创建正交投影矩阵。
///
/// # Arguments / 参数
/// - `left`, `right`, `bottom`, `top`, `near`, `far`: clipping bounds / 裁剪边界
pub fn ortho(
  left : Double,
  right : Double,
  bottom : Double,
  top : Double,
  near : Double,
  far : Double,
) -> Array[Array[Double]] {
  let rl = 1.0 / (right - left)
  let tb = 1.0 / (top - bottom)
  let nf = 1.0 / (near - far)
  [
    [2.0 * rl, 0.0, 0.0, -(right + left) * rl],
    [0.0, 2.0 * tb, 0.0, -(top + bottom) * tb],
    [0.0, 0.0, 2.0 * nf, (far + near) * nf],
    [0.0, 0.0, 0.0, 1.0],
  ]
}
