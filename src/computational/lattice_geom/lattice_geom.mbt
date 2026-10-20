///| Lattice Geometry | 格几何
///| Bravais lattices, reciprocal lattices, Brillouin zones
///| Bravais 格、倒格、Brillouin 区

pub fn bravais_lattice_volume(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> Double {
  (a1x * a2y - a1y * a2x).abs()
}

pub fn reciprocal_lattice(a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> (Double, Double, Double, Double) {
  let vol = a1x * a2y - a1y * a2x
  let b1x = a2y / vol
  let b1y = -a2x / vol
  let b2x = -a1y / vol
  let b2y = a1x / vol
  (b1x, b1y, b2x, b2y)
}

pub fn nearest_lattice_point(px : Double, py : Double, a1x : Double, a1y : Double, a2x : Double, a2y : Double) -> (Int, Int) {
  let vol = a1x * a2y - a1y * a2x
  let n1 = (px * a2y - py * a2x) / vol
  let n2 = (-px * a1y + py * a1x) / vol
  (n1.round().to_int(), n2.round().to_int())
}

pub fn brillouin_zone_radius(a : Double) -> Double {
  @math.PI / a
}

pub fn packing_fraction_sc(r : Double, a : Double) -> Double {
  let vol_sphere = 4.0 / 3.0 * @math.PI * r * r * r
  let vol_cell = a * a * a
  vol_sphere / vol_cell
}
