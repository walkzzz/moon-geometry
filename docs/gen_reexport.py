import re
import os
import sys

MODULES = [
    "point_cloud", "surface_recon", "voxel_grid", "normal_est", "curvature_est",
    "pc_segment", "pc_feature", "ground_detect", "pc_filter", "pc_transform",
    "simplicial_complex", "chain_complex", "boundary_operator", "homology_group",
    "cohomology", "discrete_morse", "witness_complex", "cech_complex", "nerve_theorem", "filtration",
    "exact_predicates", "interval_arithmetic", "filtered_predicates", "perturbation",
    "robust_construction", "big_rational", "de9im", "lazy_exact", "rounded_geometry", "affine_arithmetic",
    "nsga2", "pareto_front", "bayesian_opt", "cmaes", "trust_region", "sqp", "augmented_lagrangian",
    "branch_bound", "sdp", "socp"
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