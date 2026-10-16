///| Topological Quantum Computing | 拓扑量子计算
///| Anyons, braiding statistics, topological gates
///| 任意子、辫子统计、拓扑门

pub fn anyon_braid_phase(theta : Double, n : Int) -> Double {
  n.to_double() * theta
}

pub fn fibonacci_anyon_phase(n : Int) -> Double {
  let tau = (1.0 + 5.0.sqrt()) / 2.0
  n.to_double() * 2.0 * @math.PI / (tau * tau)
}

pub fn ising_anyon_phase(n : Int) -> Double {
  n.to_double() * @math.PI / 4.0
}

pub fn braid_group_relation(a : Double, b : Double, c : Double) -> Bool {
  (a + b + a - b - a - b).abs() < 1.0e-10 && (b + c + b - c - b - c).abs() < 1.0e-10
}

pub fn topological_gate_fidelity(phase1 : Double, phase2 : Double) -> Double {
  let diff = (phase1 - phase2).abs()
  @math.cos(diff / 2.0) * @math.cos(diff / 2.0)
}

pub fn majorana_fusion_rule(n : Int) -> Int {
  n % 2
}
