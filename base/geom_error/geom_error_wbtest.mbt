///|
test "GeomError to_message" {
  let err = EmptyInput
  assert_eq(err.to_message(), "Empty input")
  let err2 = InvalidParameter("negative radius")
  assert_true(err2.to_message().contains("negative radius"))
  let err3 = DegenerateGeometry("collinear points")
  assert_true(err3.to_message().contains("collinear"))
}

///|
test "GeomError variants" {
  ignore(EmptyInput)
  ignore(InsufficientInput("test"))
  ignore(DegenerateGeometry("test"))
  ignore(NumericalFailure("test"))
  ignore(InvalidParameter("test"))
  ignore(TopologyError("test"))
  ignore(IoError("test"))
}
///|
test "GeomError to_message all variants" {
  assert_eq(InsufficientInput("need 3").to_message(), "Insufficient input: need 3")
  assert_eq(NumericalFailure("singular").to_message(), "Numerical failure: singular")
  assert_eq(TopologyError("non-manifold").to_message(), "Topology error: non-manifold")
  assert_eq(IoError("parse").to_message(), "I/O error: parse")
  assert_eq(EmptyInput.to_message(), "Empty input")
}

///|
test "GeomError Eq equal and not_equal" {
  assert_true(EmptyInput == EmptyInput)
  assert_true(EmptyInput != InvalidParameter("x"))
  assert_true(InvalidParameter("a") == InvalidParameter("a"))
  assert_true(InvalidParameter("a") != InvalidParameter("b"))
  assert_true(DegenerateGeometry("c") != NumericalFailure("c"))
}

///|
test "GeomError Debug to_repr" {
  ignore(EmptyInput.to_repr())
  ignore(InsufficientInput("m").to_repr())
  ignore(NumericalFailure("m").to_repr())
  ignore(TopologyError("m").to_repr())
  ignore(IoError("m").to_repr())
}
