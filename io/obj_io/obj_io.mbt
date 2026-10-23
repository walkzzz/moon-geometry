///|
/// OBJ face vertex: vertex / texcoord / normal indices (1-based, 0 = absent).
/// OBJ 面顶点：顶点 / 纹理 / 法线索引（1 起，0 表示无）。
pub struct ObjFaceVertex {
  v : Int32
  vt : Int32
  vn : Int32
}

///|
/// Construct an OBJ face vertex. / 构造 OBJ 面顶点。
pub fn ObjFaceVertex::new(v : Int32, vt : Int32, vn : Int32) -> ObjFaceVertex {
  { v, vt, vn, }
}

///|
/// OBJ face: list of face vertices. / OBJ 面：面顶点列表。
pub struct ObjFace {
  verts : Array[ObjFaceVertex]
}

///|
/// Construct an OBJ face. / 构造 OBJ 面。
pub fn ObjFace::new(verts : Array[ObjFaceVertex]) -> ObjFace {
  { verts, }
}

///|
/// OBJ mesh: vertices, texcoords, normals, faces.
/// OBJ 网格：顶点、纹理坐标、法线、面。
pub struct ObjMesh {
  vertices : Array[@core.Point3D]
  texcoords : Array[(Double, Double)]
  normals : Array[@core.Point3D]
  faces : Array[ObjFace]
}

///|
pub extend ObjMesh with @core.VertexCountable::{vertex_count}

///|
pub extend ObjMesh with @core.FaceCountable::{face_count}
