///| Geometric Measure Theory | 几何测度论
///| Hausdorff measure, rectifiable sets, density
///| Hausdorff 测度、可求长集、密度

///| Return the 0-dimensional Hausdorff measure (counting measure). / 返回零维 Hausdorff 测度（计数测度）。
pub fn hausdorff_dim_0(count : Int) -> Double {
  count.to_double()
}

///| Return the 1D Hausdorff measure (length). / 返回一维 Hausdorff 测度（长度）。
pub fn hausdorff_measure_1d(length : Double) -> Double {
  length
}

///| Return the 2D Hausdorff measure (area). / 返回二维 Hausdorff 测度（面积）。
pub fn hausdorff_measure_2d(area : Double) -> Double {
  area
}

///| Compute the 2D density of a measure in a disk. / 计算测度在圆盘中的二维密度。
pub fn density_2d(measure : Double, radius : Double) -> Double {
  measure / (@math.PI * radius * radius)
}

///| Sum the lengths of line segments (rectifiable curve length). / 求线段总长（可求长曲线长度）。
pub fn rectifiable_length(segments : Array[(Double, Double, Double, Double)]) -> Double {
  let mut total = 0.0
  for s in segments {
    let dx = s.1 - s.0
    let dy = s.3 - s.2
    total += (dx * dx + dy * dy).sqrt()
  }
  total
}

///| Apply the coarea formula for a level value. / 对水平值应用 coarea 公式。
pub fn coarea_formula(fx : Double, fy : Double, level : Double) -> Double {
  let grad_norm = (fx * fx + fy * fy).sqrt()
  if grad_norm < 1.0e-10 {
    0.0
  } else {
    level / grad_norm
  }
}
