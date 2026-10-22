///| Isoperimetric Problems | 等周问题
///| Optimal shapes, isoperimetric inequalities
///| 最优形状、等周不等式

///| Compute the isoperimetric ratio 4*pi*A/P^2. / 计算等周比 4*pi*A/P^2。
pub fn isoperimetric_ratio(perimeter : Double, area : Double) -> Double {
  4.0 * @math.PI * area / (perimeter * perimeter)
}

///| Compute the isoperimetric deficit 1 - ratio. / 计算等周亏 1 - ratio。
pub fn isoperimetric_deficit(perimeter : Double, area : Double) -> Double {
  1.0 - isoperimetric_ratio(perimeter, area)
}

///| Compute the area of a circle from its perimeter. / 由周长计算圆面积。
pub fn circle_area_from_perimeter(p : Double) -> Double {
  let r = p / (2.0 * @math.PI)
  @math.PI * r * r
}

///| Compute the perimeter of a circle from its area. / 由面积计算圆周长。
pub fn circle_perimeter_from_area(a : Double) -> Double {
  2.0 * @math.PI * (a / @math.PI).sqrt()
}

///| Compute the optimal (circle) area for a given perimeter. / 计算给定周长下的最优（圆）面积。
pub fn optimal_shape_area(perimeter : Double) -> Double {
  let r = perimeter / (2.0 * @math.PI)
  @math.PI * r * r
}

///| Check whether the shape is isoperimetrically optimal. / 判断形状是否等周最优。
pub fn is_isoperimetric_optimal(perimeter : Double, area : Double) -> Bool {
  isoperimetric_deficit(perimeter, area).abs() < 1.0e-10
}
