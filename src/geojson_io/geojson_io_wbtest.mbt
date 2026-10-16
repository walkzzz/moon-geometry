test "geojson point write" {
  let p = @core.Point2D::new(1.0, 2.0)
  let s = geojson_point(p)
  assert_true(s.contains("\"type\":\"Point\""))
  assert_true(s.contains("[1,2]"))
}

test "geojson linestring write" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let s = geojson_linestring(pts)
  assert_true(s.contains("\"type\":\"LineString\""))
  assert_true(s.contains("[0,0]"))
  assert_true(s.contains("[1,1]"))
}

test "geojson polygon write" {
  let ring = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let s = geojson_polygon([ring])
  assert_true(s.contains("\"type\":\"Polygon\""))
  assert_true(s.contains("[[0,0]"))
}

test "geojson parse point" {
  let text = "{\"type\":\"Point\",\"coordinates\":[3.0,4.0]}"
  match geojson_parse(text) {
    Some(GeoPoint(p)) => {
      assert_true(@core.approx_eq(p.x(), 3.0, 0.000001))
      assert_true(@core.approx_eq(p.y(), 4.0, 0.000001))
    }
    _ => assert_true(false)
  }
}

test "geojson parse linestring" {
  let text = "{\"type\":\"LineString\",\"coordinates\":[[0,0],[1,1],[2,2]]}"
  match geojson_parse(text) {
    Some(GeoLineString(pts)) => assert_eq(pts.length(), 3)
    _ => assert_true(false)
  }
}

test "geojson parse polygon" {
  let text = "{\"type\":\"Polygon\",\"coordinates\":[[[0,0],[1,0],[0,1],[0,0]]]}"
  match geojson_parse(text) {
    Some(GeoPolygon(rings)) => {
      assert_eq(rings.length(), 1)
      assert_eq(rings[0].length(), 4)
    }
    _ => assert_true(false)
  }
}

test "geojson parse multipoint" {
  let text = "{\"type\":\"MultiPoint\",\"coordinates\":[[0,0],[1,1]]}"
  match geojson_parse(text) {
    Some(GeoMultiPoint(pts)) => assert_eq(pts.length(), 2)
    _ => assert_true(false)
  }
}

test "geojson write via geojson_write" {
  let s = geojson_write(GeoPoint(@core.Point2D::new(5.0, 6.0)))
  assert_true(s.contains("\"type\":\"Point\""))
  assert_true(s.contains("[5,6]"))
}

test "geojson roundtrip point" {
  let p = @core.Point2D::new(1.5, 2.5)
  let s = geojson_point(p)
  match geojson_parse(s) {
    Some(GeoPoint(q)) => {
      assert_true(@core.approx_eq(q.x(), 1.5, 0.000001))
      assert_true(@core.approx_eq(q.y(), 2.5, 0.000001))
    }
    _ => assert_true(false)
  }
}

test "geojson parse multipolygon" {
  let text = "{\"type\":\"MultiPolygon\",\"coordinates\":[[[[0,0],[1,0],[0,1],[0,0]]]]}"
  match geojson_parse(text) {
    Some(GeoMultiPolygon(polys)) => {
      assert_eq(polys.length(), 1)
      assert_eq(polys[0].length(), 1)
    }
    _ => assert_true(false)
  }
}