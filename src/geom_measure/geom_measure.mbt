///| Geometric Measure Theory | 几何测度论
///| Hausdorff measure, rectifiable sets, density
///| Hausdorff 测度、可求长集、密度

pub fn hausdorff_dim_0(count : Int) -> Double {
  count.to_double()
}

pub fn hausdorff_measure_1d(length : Double) -> Double {
  length
}

pub fn hausdorff_measure_2d(area : Double) -> Double {
  area
}

pub fn density_2d(measure : Double, radius : Double) -> Double {
  measure / (@math.PI * radius * radius)
}

pub fn rectifiable_length(segments : Array[(Double, Double, Double, Double)]) -> Double {
  let mut total = 0.0
  for s in segments {
    let dx = s.1 - s.0
    let dy = s.3 - s.2
    total += (dx * dx + dy * dy).sqrt()
  }
  total
}

pub fn coarea_formula(fx : Double, fy : Double, level : Double) -> Double {
  let grad_norm = (fx * fx + fy * fy).sqrt()
  if grad_norm < 1.0e-10 {
    0.0
  } else {
    level / grad_norm
  }
}
