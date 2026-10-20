///| Geometric Coding Theory | 几何编码理论
///| Lattice codes, sphere packing, kissing numbers
///| 格码、球填充、接吻数

pub fn sphere_packing_density_sc() -> Double {
  @math.PI / 6.0
}

pub fn sphere_packing_density_fcc() -> Double {
  @math.PI / (3.0 * 1.4142135623730951)
}

pub fn kissing_number_2d() -> Int {
  6
}

pub fn kissing_number_3d() -> Int {
  12
}

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
