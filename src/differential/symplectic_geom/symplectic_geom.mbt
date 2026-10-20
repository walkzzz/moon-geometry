///| Symplectic Geometry | 辛几何
///| Symplectic forms, Hamiltonian flows, canonical transformations
///| 辛形式、哈密顿流、正则变换

pub struct SymplecticForm {
  omega11 : Double
  omega12 : Double
  omega21 : Double
  omega22 : Double
} derive(Show)

pub fn canonical_form() -> SymplecticForm {
  { omega11: 0.0, omega12: 1.0, omega21: -1.0, omega22: 0.0 }
}

pub fn SymplecticForm::apply(self : SymplecticForm, v1x : Double, v1y : Double, v2x : Double, v2y : Double) -> Double {
  let a = self.omega11 * v1x * v2x + self.omega12 * v1x * v2y
  let b = self.omega21 * v1y * v2x + self.omega22 * v1y * v2y
  a + b
}

pub fn SymplecticForm::is_nondegenerate(self : SymplecticForm) -> Bool {
  let det = self.omega11 * self.omega22 - self.omega12 * self.omega21
  det.abs() > 1.0e-10
}

pub fn hamiltonian_flow(hx : Double, hy : Double, dt : Double) -> (Double, Double) {
  (hx + hy * dt, hy - hx * dt)
}

pub fn poisson_bracket(fx : Double, fy : Double, gx : Double, gy : Double) -> Double {
  fx * gy - fy * gx
}

pub fn liouville_volume(x1 : Double, x2 : Double, y1 : Double, y2 : Double) -> Double {
  (x2 - x1) * (y2 - y1)
}
