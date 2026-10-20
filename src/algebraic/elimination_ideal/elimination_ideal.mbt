///|
/// # Elimination Ideal
/// # 消元理想
///
/// Elimination ideals for projecting varieties to lower dimensions.
/// 消元理想，用于将簇投影到低维空间。

///|
pub fn eliminate_variable(n_vars : Int, var_index : Int) -> Int {
  if var_index < 0 || var_index >= n_vars { n_vars } else { n_vars - 1 }
}

///|
pub fn elimination_order(n_vars : Int, eliminate_count : Int) -> Int {
  if eliminate_count > n_vars { 0 } else { n_vars - eliminate_count }
}

///|
pub fn projection_dimension(variety_dim : Int, eliminate_count : Int) -> Int {
  let d = variety_dim - eliminate_count
  if d < 0 { 0 } else { d }
}

///|
pub fn closure_is_proper(fiber_dim : Int) -> Bool {
  fiber_dim >= 0
}

///|
pub fn extension_exists(generic_fiber_nonempty : Bool) -> Bool {
  generic_fiber_nonempty
}
