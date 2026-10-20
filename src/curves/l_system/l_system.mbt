///|
/// # L-Systems (Lindenmayer Systems)
/// # L 系统（Lindenmayer 系统）
///
/// String rewriting with turtle graphics interpretation for fractal plants and snowflakes.
/// 字符串重写配合海龟图形解释，生成分形植物和雪花。

///|
/// A single production rule: symbol -> replacement string. / 单条产生式规则。
pub struct LRule {
  symbol : String
  replacement : String
}

///|
/// Construct a production rule. / 构造产生式规则。
pub fn LRule::new(symbol : String, replacement : String) -> LRule {
  { symbol, replacement, }
}

///|
/// An L-system: axiom (initial string) and production rules. / L 系统：公理与产生式规则集。
pub struct LSystem {
  axiom : String
  rules : Array[LRule]
}

///|
/// Construct an L-system. / 构造 L 系统。
pub fn LSystem::new(axiom : String, rules : Array[LRule]) -> LSystem {
  { axiom, rules, }
}

///|
/// Look up the replacement for a single character. / 查找单个字符的替换。
fn lookup_rule(rules : Array[LRule], ch : String) -> String? {
  for r in rules {
    if r.symbol == ch {
      return Some(r.replacement)
    }
  }
  None
}

///|
/// Apply one derivation step to a string. / 对字符串执行一步推导。
pub fn lsystem_step(system : LSystem, current : String) -> String {
  let mut result = ""
  for ch in current {
    let ch_str = ch.to_string()
    match lookup_rule(system.rules, ch_str) {
      Some(rep) => result += rep
      None => result += ch_str
    }
  }
  result
}

///|
/// Iterate the L-system n times from the axiom. / 从公理迭代 L 系统 n 次。
pub fn lsystem_iterate(system : LSystem, n : Int) -> String {
  let mut current = system.axiom
  for _ in 0..<n {
    current = lsystem_step(system, current)
  }
  current
}

///|
/// Turtle state: position and heading angle. / 海龟状态：位置与朝向角。
pub struct TurtleState {
  x : Double
  y : Double
  angle : Double
}

///|
/// Turtle graphics interpretation of an L-system string.
/// F = forward (draw), f = forward (no draw), + = turn left, - = turn right,
/// [ = push state, ] = pop state. Other symbols are ignored.
/// 海龟图形解释 L 系统字符串。
pub fn turtle_interpret(
  s : String,
  angle : Double,
  step : Double,
) -> Array[@core.Point2D] {
  let points : Array[@core.Point2D] = []
  let stack : Array[TurtleState] = []
  let mut x = 0.0
  let mut y = 0.0
  let mut ang = 0.0
  points.push(@core.Point2D::new(x, y))
  for ch in s {
    let ch_str = ch.to_string()
    match ch_str {
      "F" => {
        x += step * @math.cos(ang)
        y += step * @math.sin(ang)
        points.push(@core.Point2D::new(x, y))
      }
      "f" => {
        x += step * @math.cos(ang)
        y += step * @math.sin(ang)
        points.push(@core.Point2D::new(x, y))
      }
      "+" => ang += angle
      "-" => ang -= angle
      "[" => stack.push({ x, y, angle: ang })
      "]" => {
        if stack.length() > 0 {
          let saved = stack[stack.length() - 1]
          x = saved.x
          y = saved.y
          ang = saved.angle
          ignore(stack.pop())
          points.push(@core.Point2D::new(x, y))
        }
      }
      _ => ()
    }
  }
  points
}

///|
/// Generate the Koch snowflake as a point array. / 生成科赫雪花点数组。
pub fn koch_snowflake(n_iter : Int, side : Double) -> Array[@core.Point2D] {
  let axiom = "F++F++F"
  let rules = [LRule::new("F", "F-F++F-F")]
  let system = LSystem::new(axiom, rules)
  let s = lsystem_iterate(system, n_iter)
  turtle_interpret(s, @math.PI / 3.0, side)
}

///|
/// Generate the Sierpinski arrowhead curve. / 生成 Sierpinski 箭头曲线。
pub fn sierpinski_arrowhead(n_iter : Int, step : Double) -> Array[@core.Point2D] {
  let axiom = "A"
  let rules = [
    LRule::new("A", "B-A-B"),
    LRule::new("B", "A+B+A"),
  ]
  let system = LSystem::new(axiom, rules)
  let s = lsystem_iterate(system, n_iter)
  let mut result = ""
  for ch in s {
    let ch_str = ch.to_string()
    if ch_str == "A" || ch_str == "B" {
      result += "F"
    } else {
      result += ch_str
    }
  }
  turtle_interpret(result, @math.PI / 3.0, step)
}

///|
/// Generate a fractal plant (Barnsley fern style). / 生成分形植物。
pub fn fractal_plant(n_iter : Int, step : Double) -> Array[@core.Point2D] {
  let axiom = "X"
  let rules = [
    LRule::new("X", "F+[[X]-X]-F[-FX]+X"),
    LRule::new("F", "FF"),
  ]
  let system = LSystem::new(axiom, rules)
  let s = lsystem_iterate(system, n_iter)
  turtle_interpret(s, 25.0 * @math.PI / 180.0, step)
}

///|
/// Generate the Dragon curve. / 生成龙曲线。
pub fn dragon_curve(n_iter : Int, step : Double) -> Array[@core.Point2D] {
  let axiom = "FX"
  let rules = [
    LRule::new("X", "X+YF+"),
    LRule::new("Y", "-FX-Y"),
  ]
  let system = LSystem::new(axiom, rules)
  let s = lsystem_iterate(system, n_iter)
  turtle_interpret(s, @math.PI / 2.0, step)
}

///|
/// Count the number of drawing segments (F symbols) in a derived string.
/// 统计推导字符串中绘图段（F 符号）数量。
pub fn count_segments(s : String) -> Int {
  let mut count = 0
  for ch in s {
    let ch_str = ch.to_string()
    if ch_str == "F" {
      count += 1
    }
  }
  count
}