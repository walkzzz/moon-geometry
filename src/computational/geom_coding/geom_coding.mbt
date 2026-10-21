///| Geometric Coding Theory | 几何编码理论
///| Lattice codes, sphere packing, kissing numbers
///| 格码、球填充、接吻数

///| Return the simple-cubic sphere packing density. / 返回简单立方球填充密度。
pub fn sphere_packing_density_sc() -> Double {
  @math.PI / 6.0
}

///| Return the face-centered-cubic sphere packing density. / 返回面心立方球填充密度。
pub fn sphere_packing_density_fcc() -> Double {
  @math.PI / (3.0 * 1.4142135623730951)
}

///| Return the 2D kissing number (6). / 返回二维接吻数（6）。
pub fn kissing_number_2d() -> Int {
  6
}

///| Return the 3D kissing number (12). / 返回三维接吻数（12）。
pub fn kissing_number_3d() -> Int {
  12
}

///| Compute the Hamming (sphere-packing) bound for codes. / 计算编码的 Hamming（球填充）界。
pub fn hamming_bound(n : Int, _d : Int, t : Int) -> Double {
  let mut vol = 0.0
  for i in 0..=t {
    let mut comb = 1.0
    for j in 0..<i {
      comb *= (n - j).to_double() / (j + 1).to_double()
    }
    vol += comb
  }
  @math.pow(2.0, n.to_double()) / vol
}

///| Compute the Gilbert-Varshamov bound for codes. / 计算编码的 Gilbert-Varshamov 界。
pub fn gilbert_varshamov_bound(n : Int, d : Int) -> Double {
  let mut vol = 0.0
  let t = (d - 1) / 2
  for i in 0..=t {
    let mut comb = 1.0
    for j in 0..<i {
      comb *= (n - j).to_double() / (j + 1).to_double()
    }
    vol += comb
  }
  @math.pow(2.0, n.to_double()) / vol
}
