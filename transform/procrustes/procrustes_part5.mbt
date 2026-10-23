///|
/// Generalized Procrustes analysis: align multiple shapes to a common reference.
/// 广义 Procrustes 分析：将多个形状对齐到公共参考。
///
/// Returns aligned shapes (each centered and rotated to reference).
/// 返回对齐后的形状（每个已居中并旋转到参考）。
pub fn procrustes_analyze(
  shapes : Array[Array[@core.Point2D]],
  max_iter : Int,
) -> Array[Array[@core.Point2D]] {
  let n_shapes = shapes.length()
  if n_shapes == 0 {
    return []
  }
  let aligned : Array[Array[@core.Point2D]] = []
  for shape in shapes {
    let c = centroid(shape)
    let centered : Array[@core.Point2D] = []
    for p in shape {
      centered.push(p.sub(c))
    }
    aligned.push(centered)
  }
  for _ in 0..<max_iter {
    let n = aligned[0].length()
    let ref_shape : Array[@core.Point2D] = Array::make(n, @core.Point2D::new(0.0, 0.0))
    for shape in aligned {
      for i in 0..<n {
        ref_shape[i] = @core.Point2D::new(
          ref_shape[i].x() + shape[i].x(),
          ref_shape[i].y() + shape[i].y(),
        )
      }
    }
    let nd = n_shapes.to_double()
    for i in 0..<n {
      ref_shape[i] = @core.Point2D::new(ref_shape[i].x() / nd, ref_shape[i].y() / nd)
    }
    for k in 0..<n_shapes {
      let result = procrustes(aligned[k], ref_shape)
      aligned[k] = procrustes_apply(aligned[k], result)
    }
  }
  aligned
}