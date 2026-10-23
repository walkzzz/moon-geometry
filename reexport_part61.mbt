///|
pub type DCEL = @dcel.DCEL

///|
pub fn dcel_new() -> DCEL {
  @dcel.DCEL::new()
}

///|
pub fn dcel_add_vertex(d : DCEL, p : Point2D) -> Int {
  @dcel.DCEL::add_vertex(d, p)
}

///|
pub fn dcel_add_edge(d : DCEL, from : Int, to : Int) -> Int {
  @dcel.DCEL::add_edge(d, from, to)
}

///|
pub fn dcel_add_face(d : DCEL, outer : Int) -> Int {
  @dcel.DCEL::add_face(d, outer)
}

///|
pub fn dcel_set_next(d : DCEL, he : Int, next : Int) -> Unit {
  @dcel.DCEL::set_next(d, he, next)
}

///|
pub fn dcel_set_face(d : DCEL, he : Int, face : Int) -> Unit {
  @dcel.DCEL::set_face(d, he, face)
}