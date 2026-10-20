///| Isoperimetric Problems | 等周问题
///| Optimal shapes, isoperimetric inequalities
///| 最优形状、等周不等式

pub fn isoperimetric_ratio(perimeter : Double, area : Double) -> Double {
  4.0 * @math.PI * area / (perimeter * perimeter)
}

pub fn isoperimetric_deficit(perimeter : Double, area : Double) -> Double {
  1.0 - isoperimetric_ratio(perimeter, area)
}

pub fn circle_area_from_perimeter(p : Double) -> Double {
  let r = p / (2.0 * @math.PI)
  @math.PI * r * r
}

pub fn circle_perimeter_from_area(a : Double) -> Double {
  2.0 * @math.PI * (a / @math.PI).sqrt()
}

pub fn optimal_shape_area(perimeter : Double) -> Double {
  let r = perimeter / (2.0 * @math.PI)
  @math.PI * r * r
}

pub fn is_isoperimetric_optimal(perimeter : Double, area : Double) -> Bool {
  isoperimetric_deficit(perimeter, area).abs() < 1.0e-10
}
