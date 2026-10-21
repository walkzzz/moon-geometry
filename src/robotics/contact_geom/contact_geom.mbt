///| Contact Geometry | 接触几何
///| Contact forms, Legendre submanifolds, Reeb vector fields
///| 接触形式、Legendre 子流形、Reeb 向量场

pub struct ContactForm {
  a_x : Double
  a_y : Double
  a_z : Double
} derive(Debug)

///|
pub extend ContactForm with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub fn ContactForm::new(a_x : Double, a_y : Double, a_z : Double) -> ContactForm {
  { a_x, a_y, a_z }
}

///| Evaluate the contact form on a vector. / 在向量上求值接触形式。
pub fn ContactForm::eval(self : ContactForm, vx : Double, vy : Double, vz : Double) -> Double {
  self.a_x * vx + self.a_y * vy + self.a_z * vz
}

///| Check whether the form is a valid contact form. / 判断该形式是否为有效接触形式。
pub fn ContactForm::is_contact(self : ContactForm) -> Bool {
  self.a_z.abs() > 1.0e-10
}

///| Lift a point to the Legendre submanifold. / 将点提升至 Legendre 子流形。
pub fn legendre_lift(x : Double, y : Double, f : (Double) -> Double) -> (Double, Double, Double) {
  (x, y, f(x))
}

///| Compute the Reeb vector field. / 计算 Reeb 向量场。
pub fn reeb_vector(_ : Double, _ : Double, a_z : Double) -> (Double, Double, Double) {
  (0.0, 0.0, 1.0 / a_z)
}

///| Compute the contact Hamiltonian. / 计算接触哈密顿量。
pub fn contact_hamiltonian(h : Double, a_z : Double) -> Double {
  h / a_z
}
