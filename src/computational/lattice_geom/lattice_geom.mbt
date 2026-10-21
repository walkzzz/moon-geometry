///| Lattice Geometry | 格几何
///| Bravais lattices, reciprocal lattices, Brillouin zones
///| Bravais 格、倒格、Brillouin 区

///| Compute the unit cell volume of a 2D Bravais lattice. / 计算二维 Bravais 格原胞体积。
pub fn bravais_lattice_volume(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> Double {
  (a1x * a2y - a1y * a2x).abs()
}

///| Compute the reciprocal lattice basis vectors. / 计算倒格基矢。
pub fn reciprocal_lattice(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> (Double, Double, Double, Double) {
  let vol = a1x * a2y - a1y * a2x
  let b1x = a2y / vol
  let b1y = -a2x / vol
  let b2x = -a1y / vol
  let b2y = a1x / vol
  (b1x, b1y, b2x, b2y)
}

///| Find the nearest lattice point to a given point. / 求给定点最近的格点。
pub fn nearest_lattice_point(px : Double, py : Double, a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> (Int, Int) {
  let vol = a1x * a2y - a1y * a2x
  let n1 = (px * a2y - py * a2x) / vol
  let n2 = (-px * a1y + py * a1x) / vol
  (n1.round().to_int(), n2.round().to_int())
}

///| Compute the first Brillouin zone radius. / 计算第一 Brillouin 区半径。
pub fn brillouin_zone_radius(a : Double) -> Double {
  @math.PI / a
}

///| Compute the simple-cubic packing fraction. / 计算简单立方填充率。
pub fn packing_fraction_sc(r : Double, a : Double) -> Double {
  let vol_sphere = 4.0 / 3.0 * @math.PI * r * r * r
  let vol_cell = a * a * a
  vol_sphere / vol_cell
}
