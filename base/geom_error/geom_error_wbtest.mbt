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
