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
  assert_eq(
    InsufficientInput("need 3").to_message(),
    "Insufficient input: need 3",
  )
  assert_eq(
    NumericalFailure("singular").to_message(),
    "Numerical failure: singular",
  )
  assert_eq(
    TopologyError("non-manifold").to_message(),
    "Topology error: non-manifold",
  )
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

///|
test "GeomError to_message empty string" {
  assert_eq(InsufficientInput("").to_message(), "Insufficient input: ")
  assert_eq(DegenerateGeometry("").to_message(), "Degenerate geometry: ")
  assert_eq(NumericalFailure("").to_message(), "Numerical failure: ")
  assert_eq(InvalidParameter("").to_message(), "Invalid parameter: ")
  assert_eq(TopologyError("").to_message(), "Topology error: ")
  assert_eq(IoError("").to_message(), "I/O error: ")
}

///|
test "GeomError to_message special chars" {
  let msg = "中文消息 with spaces & symbols!"
  assert_true(InvalidParameter(msg).to_message().contains(msg))
  assert_true(IoError(msg).to_message().contains(msg))
}

///|
test "GeomError Eq reflexive all variants" {
  assert_true(EmptyInput == EmptyInput)
  assert_true(InsufficientInput("x") == InsufficientInput("x"))
  assert_true(DegenerateGeometry("x") == DegenerateGeometry("x"))
  assert_true(NumericalFailure("x") == NumericalFailure("x"))
  assert_true(InvalidParameter("x") == InvalidParameter("x"))
  assert_true(TopologyError("x") == TopologyError("x"))
  assert_true(IoError("x") == IoError("x"))
}

///|
test "GeomError Eq cross-variant inequality" {
  assert_true(EmptyInput != InsufficientInput(""))
  assert_true(InsufficientInput("") != DegenerateGeometry(""))
  assert_true(DegenerateGeometry("") != NumericalFailure(""))
  assert_true(NumericalFailure("") != InvalidParameter(""))
  assert_true(InvalidParameter("") != TopologyError(""))
  assert_true(TopologyError("") != IoError(""))
  assert_true(IoError("") != EmptyInput)
}

///|
test "GeomError Debug to_repr all variants" {
  ignore(DegenerateGeometry("m").to_repr())
  ignore(InvalidParameter("m").to_repr())
}
///|
test "GeomError to_message prefix check" {
  assert_true(EmptyInput.to_message().has_prefix("Empty"))
  assert_true(InsufficientInput("x").to_message().has_prefix("Insufficient"))
  assert_true(DegenerateGeometry("x").to_message().has_prefix("Degenerate"))
  assert_true(NumericalFailure("x").to_message().has_prefix("Numerical"))
  assert_true(InvalidParameter("x").to_message().has_prefix("Invalid"))
  assert_true(TopologyError("x").to_message().has_prefix("Topology"))
  assert_true(IoError("x").to_message().has_prefix("I/O"))
}

///|
test "GeomError Eq symmetric" {
  let a = InvalidParameter("a")
  let b = InvalidParameter("a")
  assert_true(a == b && b == a)
  let c = TopologyError("c")
  assert_true(a != c && c != a)
}

///|
test "GeomError Debug repr nonempty" {
  ignore(EmptyInput.to_repr())
  ignore(InsufficientInput("m").to_repr())
  ignore(DegenerateGeometry("m").to_repr())
  ignore(NumericalFailure("m").to_repr())
  ignore(InvalidParameter("m").to_repr())
  ignore(TopologyError("m").to_repr())
  ignore(IoError("m").to_repr())
}

///|
test "GeomError Eq method explicit" {
  assert_true(GeomError::equal(EmptyInput, EmptyInput))
  assert_true(GeomError::not_equal(EmptyInput, IoError("x")))
}

///|
test "GeomError to_message concat" {
  let m1 = NumericalFailure("fail")
  let m2 = TopologyError("topo")
  assert_true(m1.to_message() != m2.to_message())
}
