///| Adaptive Precision | 自适应精度谓词
///| Progressive refinement from fast to exact evaluation
///| 从快速到精确的渐进细化

///| Adaptive 2D orientation sign of points a, b, c. / 自适应二维定向符号判定点 a, b, c 的方向。
pub fn adaptive_orient2d(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  let maxc = [ax.abs(), ay.abs(), bx.abs(), by.abs(), cx.abs(), cy.abs()]
  let mut m = 0.0
  for v in maxc {
    if v > m {
      m = v
    }
  }
  let bound = 3.0 * @math.pow(2.0, -52.0) * m * m
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else if det.abs() < bound * 1.0e-10 {
    0
  } else {
    if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
  }
}

///| Adaptive incircle test for points a, b, c, d. / 自适应圆内判定，测试点 d 相对 a, b, c 外接圆的位置。
pub fn adaptive_incircle(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double, dx : Double, dy : Double) -> Int {
  let adx = ax - dx
  let ady = ay - dy
  let bdx = bx - dx
  let bdy = by - dy
  let cdx = cx - dx
  let cdy = cy - dy
  let alift = adx * adx + ady * ady
  let blift = bdx * bdx + bdy * bdy
  let clift = cdx * cdx + cdy * cdy
  let det = alift * (bdx * cdy - cdx * bdy) - blift * (adx * cdy - cdx * ady) + clift * (adx * bdy - bdx * ady)
  if det > 0.0 { 1 } else if det < 0.0 { -1 } else { 0 }
}

///| Return precision level (0=high, 1=medium, 2=low) from det vs bound. / 根据行列式与误差界的比值返回精度级别（0=高，1=中，2=低）。
pub fn precision_level(det : Double, bound : Double) -> Int {
  if det.abs() > bound * 100.0 { 0 }
  else if det.abs() > bound { 1 }
  else { 2 }
}
