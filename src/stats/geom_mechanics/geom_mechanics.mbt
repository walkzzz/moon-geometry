///| Geometric Mechanics | 几何力学
///| Lagrangian and Hamiltonian mechanics on manifolds
///| 流形上的 Lagrangian 和 Hamiltonian 力学

///| Compute Lagrangian as kinetic minus potential energy. / 计算 Lagrangian 量（动能减势能）。
pub fn lagrangian(kinetic : Double, potential : Double) -> Double {
  kinetic - potential
}

///| Compute Hamiltonian as kinetic plus potential energy. / 计算 Hamiltonian 量（动能加势能）。
pub fn hamiltonian(kinetic : Double, potential : Double) -> Double {
  kinetic + potential
}

///| Evaluate Euler-Lagrange equation residual. / 计算 Euler-Lagrange 方程残差。
pub fn euler_lagrange(dL_dq : Double, dL_dqdot : Double, dt : Double) -> Double {
  dL_dq - dL_dqdot / dt
}

///| Integrate Hamilton equation for coordinate q. / 积分 Hamilton 方程的坐标 q。
pub fn hamilton_equation_q(dH_dp : Double, dt : Double) -> Double {
  dH_dp * dt
}

///| Integrate Hamilton equation for momentum p. / 积分 Hamilton 方程的动量 p。
pub fn hamilton_equation_p(dH_dq : Double, dt : Double) -> Double {
  -dH_dq * dt
}

///| Compute Noether conserved charge from symmetry generator. / 由对称生成元计算 Noether 守恒荷。
pub fn noether_charge(dL_dqdot : Double, xi : Double) -> Double {
  dL_dqdot * xi
}

///| Approximate action integral by summing Lagrangian values times dt. / 对 Lagrangian 值求和乘以 dt 近似作用量积分。
pub fn action_integral(lagrangian_vals : Array[Double], dt : Double) -> Double {
  let mut sum = 0.0
  for l in lagrangian_vals {
    sum += l
  }
  sum * dt
}
