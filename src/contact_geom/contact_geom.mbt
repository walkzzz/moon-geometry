///| Contact Geometry | 接触几何
///| Contact forms, Legendre submanifolds, Reeb vector fields
///| 接触形式、Legendre 子流形、Reeb 向量场

pub struct ContactForm {
  a_x : Double
  a_y : Double
  a_z : Double
} derive(Show)

pub fn ContactForm::eval(self : ContactForm, vx : Double, vy : Double, vz : Double) -> Double {
  self.a_x * vx + self.a_y * vy + self.a_z * vz
}

pub fn ContactForm::is_contact(self : ContactForm) -> Bool {
  self.a_z.abs() > 1.0e-10
}

pub fn legendre_lift(x : Double, y : Double, f : (Double) -> Double) -> (Double, Double, Double) {
  (x, y, f(x))
}

pub fn reeb_vector(a_x : Double, a_y : Double, a_z : Double) -> (Double, Double, Double) {
  (0.0, 0.0, 1.0 / a_z)
}

pub fn contact_hamiltonian(h : Double, a_z : Double) -> Double {
  h / a_z
}
