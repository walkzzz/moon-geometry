///| Symplectic Integrators | 辛积分器
///| Verlet, Stormer-Verlet, variational integrators
///| Verlet、Stormer-Verlet、变分积分器

pub fn stormer_verlet(q : Double, p : Double, force : (Double) -> Double, dt : Double) -> (Double, Double) {
  let p_half = p + force(q) * dt / 2.0
  let q_new = q + p_half * dt
  let p_new = p_half + force(q_new) * dt / 2.0
  (q_new, p_new)
}

pub fn leapfrog(q : Double, p : Double, force : (Double) -> Double, dt : Double) -> (Double, Double) {
  let p_half = p + force(q) * dt / 2.0
  let q_new = q + p_half * dt
  let p_new = p_half + force(q_new) * dt / 2.0
  (q_new, p_new)
}

pub fn ruth3(q : Double, p : Double, force : (Double) -> Double, dt : Double) -> (Double, Double) {
  let c1 = 1.0
  let c2 = -2.0 / 3.0
  let c3 = 2.0 / 3.0
  let d1 = -1.0 / 24.0
  let d2 = 3.0 / 4.0
  let d3 = 7.0 / 24.0
  let q1 = q + c1 * p * dt
  let p1 = p + d1 * force(q1) * dt
  let q2 = q1 + c2 * p1 * dt
  let p2 = p1 + d2 * force(q2) * dt
  let q3 = q2 + c3 * p2 * dt
  let p3 = p2 + d3 * force(q3) * dt
  (q3, p3)
}

pub fn energy_conservation_error(h0 : Double, h1 : Double) -> Double {
  (h1 - h0).abs() / h0.abs()
}
