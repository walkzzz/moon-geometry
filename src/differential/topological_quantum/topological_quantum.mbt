///| Topological Quantum Computing | 拓扑量子计算
///| Anyons, braiding statistics, topological gates
///| 任意子、辫子统计、拓扑门

///| Braid phase of an anyon after n exchanges. / 任意子 n 次交换后的辫子相位。
pub fn anyon_braid_phase(theta : Double, n : Int) -> Double {
  n.to_double() * theta
}

///| Braid phase for Fibonacci anyon. / Fibonacci 任意子的辫子相位。
pub fn fibonacci_anyon_phase(n : Int) -> Double {
  let tau = (1.0 + 5.0.sqrt()) / 2.0
  n.to_double() * 2.0 * @math.PI / (tau * tau)
}

///| Braid phase for Ising anyon. / Ising 任意子的辫子相位。
pub fn ising_anyon_phase(n : Int) -> Double {
  n.to_double() * @math.PI / 4.0
}

///| Check braid group relation (Yang-Baxter). / 检查辫子群关系（Yang-Baxter）。
pub fn braid_group_relation(a : Double, b : Double, c : Double) -> Bool {
  (a + b + a - b - a - b).abs() < 1.0e-10 && (b + c + b - c - b - c).abs() < 1.0e-10
}

///| Fidelity between two topological gates. / 两个拓扑门之间的保真度。
pub fn topological_gate_fidelity(phase1 : Double, phase2 : Double) -> Double {
  let diff = (phase1 - phase2).abs()
  @math.cos(diff / 2.0) * @math.cos(diff / 2.0)
}

///| Majorana fusion rule result mod 2. / Majorana 融合规则结果模 2。
pub fn majorana_fusion_rule(n : Int) -> Int {
  n % 2
}
