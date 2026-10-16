import re
import os

MODULES = [
    "grobner_basis", "polynomial_ideal", "algebraic_variety", "rational_map",
    "intersection_theory", "chow_ring", "hilbert_function", "bezout_theorem",
    "multiplicity", "elimination_ideal",
    "discrete_curvature", "gauss_bonnet", "geodesic_dist", "discrete_laplacian",
    "harmonic_map", "conformal_map", "surface_ricci", "discrete_yamabe",
    "willmore_energy", "minimal_surface",
    "persistence_diagram", "bottleneck_dist", "wasserstein_dist", "persistence_landscape",
    "persistence_image", "mapper_algo", "zigzag_persistence", "multidim_persistence",
    "sheaf_theory", "tda_features",
    "spectral_method", "finite_element", "boundary_element", "meshfree_method",
    "level_set", "fast_marching", "fast_sweeping", "lattice_boltzmann",
    "discontinuous_galerkin", "radial_basis",
]

TYPE_CONFLICTS = {
    ("interval_arithmetic", "Interval"): "IAInterval",
}

CONFLICTS = {
    ("discrete_morse", "critical_points"): "discrete_morse_critical_points",
    ("normal_est", "estimate_normal"): "pc_estimate_normal",
    ("homology_group", "euler_characteristic"): "homology_euler_characteristic",
    ("interval_arithmetic", "interval_contains"): "ia_interval_contains",
    ("interval_arithmetic", "interval_midpoint"): "ia_interval_midpoint",
    ("branch_bound", "lower_bound"): "bb_lower_bound",
    ("sdp", "matrix_trace"): "sdp_matrix_trace",
    ("curvature_est", "principal_curvatures"): "pc_principal_curvatures",
    ("voxel_grid", "voxel_index"): "vg_voxel_index",
    ("conformal_map", "area_distortion"): "cm_area_distortion",
    ("bottleneck_dist", "bottleneck_distance"): "bd_bottleneck_distance",
    ("harmonic_map", "laplacian_smooth"): "hm_laplacian_smooth",
    ("grobner_basis", "poly_degree"): "gb_poly_degree",
    ("grobner_basis", "poly_sub"): "gb_poly_sub",
}

output = []

for mod in MODULES:
    src_file = f"src/{mod}/{mod}.mbt"
    if not os.path.exists(src_file):
        output.append(f"// WARNING: {src_file} not found")
        continue

    with open(src_file, 'r', encoding='utf-8') as f:
        content = f.read()

    output.append("")
    output.append(f"// ========== {mod} ==========")

    # Extract pub structs
    for m in re.finditer(r'^pub struct (\w+)', content, re.MULTILINE):
        struct_name = m.group(1)
        export_name = TYPE_CONFLICTS.get((mod, struct_name), struct_name)
        output.append(f"pub type {export_name} = @{mod}.{struct_name}")

    # Extract pub fn declarations (not methods)
    for m in re.finditer(r'^pub fn (\w+)\s*\(', content, re.MULTILINE):
        fn_name = m.group(1)
        if '::' in fn_name:
            continue

        start = m.start()
        brace_pos = content.index('{', start)
        sig = content[start:brace_pos].strip()

        paren_start = sig.index('(')
        depth = 0
        paren_end = paren_start
        for i in range(paren_start, len(sig)):
            if sig[i] == '(':
                depth += 1
            elif sig[i] == ')':
                depth -= 1
                if depth == 0:
                    paren_end = i
                    break

        params = sig[paren_start+1:paren_end]

        after_paren = sig[paren_end+1:].strip()
        if '->' in after_paren:
            ret_type = after_paren.split('->', 1)[1].strip()
        else:
            ret_type = "Unit"

        param_names = []
        depth = 0
        current_param = ""
        for ch in params:
            if ch in '([{':
                depth += 1
                current_param += ch
            elif ch in ')]}':
                depth -= 1
                current_param += ch
            elif ch == ',' and depth == 0:
                p = current_param.strip()
                if p:
                    name = p.split(':')[0].strip()
                    if name.startswith('let '):
                        name = name[4:]
                    if name:
                        param_names.append(name)
                current_param = ""
            else:
                current_param += ch
        p = current_param.strip()
        if p:
            name = p.split(':')[0].strip()
            if name.startswith('let '):
                name = name[4:]
            if name:
                param_names.append(name)

        call_args = ', '.join(param_names)

        export_name = CONFLICTS.get((mod, fn_name), fn_name)

        # Fix type references for renamed types
        if mod == "interval_arithmetic":
            params = params.replace("Interval", "IAInterval")
            ret_type = ret_type.replace("Interval", "IAInterval")

        if params.strip():
            output.append(f"pub fn {export_name}({params}) -> {ret_type} {{")
        else:
            output.append(f"pub fn {export_name}() -> {ret_type} {{")
        output.append(f"  @{mod}.{fn_name}({call_args})")
        output.append("}")

print('\n'.join(output))