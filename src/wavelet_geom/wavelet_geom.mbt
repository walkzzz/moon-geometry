///| Wavelet Geometry | 小波几何
///| Wavelet transforms on geometric data, multi-resolution analysis
///| 几何数据上的小波变换、多分辨率分析

pub fn haar_wavelet(x : Double) -> Double {
  if x >= 0.0 && x < 0.5 {
    1.0
  } else if x >= 0.5 && x < 1.0 {
    -1.0
  } else {
    0.0
  }
}

pub fn haar_scaling(x : Double) -> Double {
  if x >= 0.0 && x < 1.0 {
    1.0
  } else {
    0.0
  }
}

pub fn daubechies4_weight(j : Int) -> Double {
  let h0 = (1.0 + 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  let h1 = (3.0 + 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  let h2 = (3.0 - 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  let h3 = (1.0 - 3.0.sqrt()) / (4.0 * 2.0.sqrt())
  if j == 0 { h0 } else if j == 1 { h1 } else if j == 2 { h2 } else if j == 3 { h3 } else { 0.0 }
}

pub fn wavelet_transform_1d(data : Array[Double]) -> Array[Double] {
  let n = data.length() / 2
  let result = Array::make(data.length(), 0.0)
  for i in 0..<n {
    result[i] = (data[2 * i] + data[2 * i + 1]) / 2.0.sqrt()
    result[n + i] = (data[2 * i] - data[2 * i + 1]) / 2.0.sqrt()
  }
  result
}

pub fn multi_resolution_level(data : Array[Double], level : Int) -> Array[Double] {
  let mut current = data
  for _ in 0..<level {
    current = wavelet_transform_1d(current)
  }
  current
}
