///|
pub type PSOTopology = @pso.PSOTopology

///|
pub fn pso_config_new(
  n_particles : Int,
  n_dims : Int,
  w : Double,
  c1 : Double,
  c2 : Double,
  lo : Array[Double],
  hi : Array[Double],
  v_max : Double,
) -> PSOConfig {
  @pso.PSOConfig::new(n_particles, n_dims, w, c1, c2, lo, hi, v_max)
}

///|
pub fn pso_result_new(
  x : Array[Double],
  value : Double,
  iterations : Int,
) -> PSOResult {
  @pso.PSOResult::new(x, value, iterations)
}

///|
pub fn pso(
  f : (Array[Double]) -> Double,
  config : PSOConfig,
  topology : PSOTopology,
  max_iter : Int,
  seed : UInt,
) -> PSOResult {
  @pso.pso(f, config, topology, max_iter, seed)
}

///|
pub fn pso_decreasing_w(
  f : (Array[Double]) -> Double,
  config : PSOConfig,
  w_max : Double,
  w_min : Double,
  topology : PSOTopology,
  max_iter : Int,
  seed : UInt,
) -> PSOResult {
  @pso.pso_decreasing_w(f, config, w_max, w_min, topology, max_iter, seed)
}

///|
pub fn pso_1d(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_particles : Int,
  max_iter : Int,
  seed : UInt,
) -> Double {
  @pso.pso_1d(f, lo, hi, n_particles, max_iter, seed)
}

pub fn pso_swarm_radius(positions : Array[Double]) -> Double {
  @pso.pso_swarm_radius(positions)
}

pub fn pso_inertia_schedule(
  w_max : Double,
  decay : Double,
  iteration : Int,
) -> Double {
  @pso.pso_inertia_schedule(w_max, decay, iteration)
}// ---------------------------------------------------------------------------
// obj_io: OBJ file I/O / OBJ 文件读写
// ---------------------------------------------------------------------------

///|
pub type ObjFaceVertex = @obj_io.ObjFaceVertex