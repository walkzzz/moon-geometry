///|
test "face extract triangle" {
  let verts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let edges = [(0, 1), (1, 2), (2, 0)]
  let faces = extract_faces(verts, edges)
  assert_true(faces.length() >= 1)
}

///|
test "face area" {
  let face : Face = {
    boundary: [
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(4.0, 0.0),
      @core.Point2D::new(4.0, 4.0),
      @core.Point2D::new(0.0, 4.0),
    ],
    holes: [],
  }
  let area = face_area(face)
  assert_true((area - 16.0).abs() < 0.0001)
}

///|
test "face count" {
  let faces : Array[Face] = []
  assert_eq(face_count(faces), 0)
}

///|
test "face extract square" {
  let verts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let edges = [(0, 1), (1, 2), (2, 3), (3, 0)]
  let faces = extract_faces(verts, edges)
  assert_true(faces.length() >= 1)
}

///|
test "face area triangle" {
  let face : Face = {
    boundary: [
      @core.Point2D::new(0.0, 0.0),
      @core.Point2D::new(6.0, 0.0),
      @core.Point2D::new(0.0, 6.0),
    ],
    holes: [],
  }
  let area = face_area(face)
  assert_true((area - 18.0).abs() < 0.0001)
}
