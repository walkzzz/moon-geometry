///|
pub type ObjFace = @obj_io.ObjFace

///|
pub type ObjMesh = @obj_io.ObjMesh

pub fn obj_face_vertex_new(v : Int, vt : Int, vn : Int) -> ObjFaceVertex {
  @obj_io.ObjFaceVertex::new(v, vt, vn)
}

pub fn obj_face_new(verts : Array[ObjFaceVertex]) -> ObjFace {
  @obj_io.ObjFace::new(verts)
}

pub fn obj_mesh_new() -> ObjMesh {
  @obj_io.ObjMesh::new()
}

pub fn obj_mesh_vertex_count(m : ObjMesh) -> Int {
  @obj_io.ObjMesh::vertex_count(m)
}

pub fn obj_mesh_face_count(m : ObjMesh) -> Int {
  @obj_io.ObjMesh::face_count(m)
}

pub fn obj_write(mesh : ObjMesh) -> String {
  @obj_io.obj_write(mesh)
}

pub fn obj_parse(text : String) -> ObjMesh {
  @obj_io.obj_parse(text)
}
// ---------------------------------------------------------------------------
// stl_io: STL file I/O / STL 文件读写
// ---------------------------------------------------------------------------

///|
pub type StlTriangle = @stl_io.StlTriangle

///|
pub type StlMesh = @stl_io.StlMesh

pub fn stl_triangle_new(
  normal : Point3D,
  v0 : Point3D,
  v1 : Point3D,
  v2 : Point3D,
) -> StlTriangle {
  @stl_io.StlTriangle::new(normal, v0, v1, v2)
}

pub fn stl_mesh_new(name : String) -> StlMesh {
  @stl_io.StlMesh::new(name)
}

pub fn stl_mesh_triangle_count(m : StlMesh) -> Int {
  @stl_io.StlMesh::triangle_count(m)
}

pub fn stl_write_ascii(mesh : StlMesh) -> String {
  @stl_io.stl_write_ascii(mesh)
}

pub fn stl_parse_ascii(text : String) -> StlMesh {
  @stl_io.stl_parse_ascii(text)
}

pub fn stl_write_binary(mesh : StlMesh) -> Bytes {
  @stl_io.stl_write_binary(mesh)
}

pub fn stl_parse_binary(data : Bytes) -> StlMesh {
  @stl_io.stl_parse_binary(data)
}
// ---------------------------------------------------------------------------
// ply_io: PLY file I/O / PLY 文件读写
// ---------------------------------------------------------------------------

///|
pub type PlyMesh = @ply_io.PlyMesh

pub fn ply_mesh_new() -> PlyMesh {
  @ply_io.PlyMesh::new()
}

pub fn ply_mesh_vertex_count(m : PlyMesh) -> Int {
  @ply_io.PlyMesh::vertex_count(m)
}

pub fn ply_mesh_face_count(m : PlyMesh) -> Int {
  @ply_io.PlyMesh::face_count(m)
}

pub fn ply_write_ascii(mesh : PlyMesh) -> String {
  @ply_io.ply_write_ascii(mesh)
}

pub fn ply_parse_ascii(text : String) -> PlyMesh {
  @ply_io.ply_parse_ascii(text)
}

pub fn ply_write_binary(mesh : PlyMesh) -> Bytes {
  @ply_io.ply_write_binary(mesh)
}

pub fn ply_parse_binary(data : Bytes) -> PlyMesh {
  @ply_io.ply_parse_binary(data)
}
// ---------------------------------------------------------------------------
// gltf_io: glTF file I/O / glTF 文件读写
// ---------------------------------------------------------------------------

///|
pub type GltfMesh = @gltf_io.GltfMesh

pub fn gltf_mesh_new() -> GltfMesh {
  @gltf_io.GltfMesh::new()
}

pub fn gltf_mesh_vertex_count(m : GltfMesh) -> Int {
  @gltf_io.GltfMesh::vertex_count(m)
}

pub fn gltf_mesh_index_count(m : GltfMesh) -> Int {
  @gltf_io.GltfMesh::index_count(m)
}

pub fn gltf_write_json(mesh : GltfMesh) -> String {
  @gltf_io.gltf_write_json(mesh)
}

pub fn gltf_parse_json(text : String) -> GltfMesh {
  @gltf_io.gltf_parse_json(text)
}

pub fn gltf_write_binary(mesh : GltfMesh) -> Bytes {
  @gltf_io.gltf_write_binary(mesh)
}

pub fn gltf_parse_binary(data : Bytes) -> GltfMesh {
  @gltf_io.gltf_parse_binary(data)
}
// ---------------------------------------------------------------------------
// geojson_io: GeoJSON I/O / GeoJSON 读写
// ---------------------------------------------------------------------------

///|
pub type GeoJsonGeometry = @geojson_io.GeoJsonGeometry

pub fn geojson_point(p : Point2D) -> String {
  @geojson_io.geojson_point(p)
}

pub fn geojson_linestring(points : Array[Point2D]) -> String {
  @geojson_io.geojson_linestring(points)
}

pub fn geojson_polygon(rings : Array[Array[Point2D]]) -> String {
  @geojson_io.geojson_polygon(rings)
}

pub fn geojson_multipoint(points : Array[Point2D]) -> String {
  @geojson_io.geojson_multipoint(points)
}

pub fn geojson_multilinestring(lines : Array[Array[Point2D]]) -> String {
  @geojson_io.geojson_multilinestring(lines)
}

pub fn geojson_multipolygon(polygons : Array[Array[Array[Point2D]]]) -> String {
  @geojson_io.geojson_multipolygon(polygons)
}

pub fn geojson_write(geom : GeoJsonGeometry) -> String {
  @geojson_io.geojson_write(geom)
}

pub fn geojson_parse(text : String) -> GeoJsonGeometry? {
  @geojson_io.geojson_parse(text)
}
// ---------------------------------------------------------------------------
// dxf_io: DXF file I/O / DXF 文件读写
// ---------------------------------------------------------------------------