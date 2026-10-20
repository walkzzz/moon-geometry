///| Geometric Mechanics | 几何力学
///| Lagrangian and Hamiltonian mechanics on manifolds
///| 流形上的 Lagrangian 和 Hamiltonian 力学

pub fn lagrangian(kinetic : Double, potential : Double) -> Double {
  kinetic - potential
}

pub fn hamiltonian(kinetic : Double, potential : Double) -> Double {
  kinetic + potential
}

pub fn euler_lagrange(dL_dq : Double, dL_dqdot : Double, dt : Double) -> Double {
  dL_dq - dL_dqdot / dt
}

pub fn hamilton_equation_q(dH_dp : Double, dt : Double) -> Double {
  dH_dp * dt
}

pub fn hamilton_equation_p(dH_dq : Double, dt : Double) -> Double {
  -dH_dq * dt
}

pub fn noether_charge(dL_dqdot : Double, xi : Double) -> Double {
  dL_dqdot * xi
}

pub fn action_integral(lagrangian_vals : Array[Double], dt : Double) -> Double {
  let mut sum = 0.0
  for l in lagrangian_vals {
    sum += l
  }
  sum * dt
}
