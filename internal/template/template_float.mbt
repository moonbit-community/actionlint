// Decimal conversion and ties-to-even rounding follow Go's strconv/decimal.go
// and strconv/ftoa.go. Copyright 2009 The Go Authors. All rights reserved.
// BSD-3-Clause license: see THIRD_PARTY_NOTICES.

///|
priv struct TemplateDecimal {
  mut digits : String
  mut point : Int32
}

///|
fn template_decimal(number : Double) -> TemplateDecimal {
  let bits = number.reinterpret_as_int64()
  let exponent = ((bits >> 52) & 2047L).to_int()
  let mantissa = (bits & 0xfffffffffffffL) |
    (if exponent == 0 { 0L } else { 0x10000000000000L })
  if mantissa == 0L {
    return { digits: "0", point: 1, }
  }
  let shift = (if exponent == 0 { 1 } else { exponent }) - 1023 - 52
  let integer = @bigint.BigInt::from_int64(mantissa)
  let digits = if shift >= 0 {
    (integer << shift).to_string()
  } else {
    (integer * @bigint.BigInt::from_int(5).pow(@bigint.BigInt::from_int(-shift))).to_string()
  }
  { digits, point: digits.length() + shift.min(0), }
}

///|
fn TemplateDecimal::round(self : TemplateDecimal, count : Int32) -> Unit {
  if count < 0 || count >= self.digits.length() {
    return
  }
  let next = self.digits[count]
  let halfway = next == '5' && self.digits[count + 1:].iter().all(c => c == '0')
  let up = if halfway {
    count > 0 && (self.digits[count - 1].to_int() - 48) % 2 == 1
  } else {
    next >= '5'
  }
  if up {
    let digits = self.digits[:count].to_array()
    for i = digits.length() - 1; i >= 0; i = i - 1 {
      if digits[i] != '9' {
        digits[i] = (digits[i].to_int() + 1).unsafe_to_char()
        self.digits = String::from_array(digits[:i + 1])
        return
      }
    }
    self.digits = "1"
    self.point += 1
  } else {
    self.digits = self.digits[:count].to_owned()
    if self.digits.iter().all(c => c == '0') {
      self.digits = "0"
      self.point = 1
    }
  }
}

///|
fn TemplateDecimal::digit(self : TemplateDecimal, at : Int32) -> String {
  if at >= 0 && at < self.digits.length() {
    self.digits[at:at + 1].to_owned()
  } else {
    "0"
  }
}

///|
fn TemplateDecimal::fixed(self : TemplateDecimal, precision : Int32) -> String {
  let out = StringBuilder()
  if self.point <= 0 {
    out.write_char('0')
  } else {
    for i in 0..<self.point {
      out.write_string(self.digit(i))
    }
  }
  if precision > 0 {
    out.write_char('.')
    for i in 0..<precision {
      out.write_string(self.digit(self.point + i))
    }
  }
  out.to_string()
}

///|
fn TemplateDecimal::scientific(
  self : TemplateDecimal,
  precision : Int32,
  upper : Bool,
) -> String {
  let out = StringBuilder()
  out.write_string(self.digit(0))
  if precision > 0 {
    out.write_char('.')
    for i in 1..<(precision + 1) {
      out.write_string(self.digit(i))
    }
  }
  let exponent = if self.digits == "0" { 0 } else { self.point - 1 }
  let magnitude = exponent.abs().to_string()
  out.write_string(if upper { "E" } else { "e" })
  out.write_string(if exponent < 0 { "-" } else { "+" })
  out.write_string("0".repeat((2 - magnitude.length()).max(0)) + magnitude)
  out.to_string()
}

///|
fn template_float(
  number : Double,
  verb : UInt16,
  precision : Int32?,
  alternate : Bool,
) -> String {
  if number.is_nan() {
    return "NaN"
  }
  if number.is_inf() {
    return if number < 0.0 { "-Inf" } else { "+Inf" }
  }
  let d = template_decimal(number)
  let negative = number.reinterpret_as_int64() < 0L
  let mut significant = precision.unwrap_or(6)
  let general = verb is ('g' | 'G' | 'v')
  if general && precision is None {
    // The core uses Ryu for shortest, round-tripping decimal digits. Reuse
    // those digits, then apply Go's exponent threshold and exponent spelling.
    let shortest = number.abs().to_string().to_lower().split("e").to_array()
    let parts = shortest[0].split(".").to_array()
    let digits = parts.map(s => s.to_owned()).join("")
    let leading = digits.iter().take_while(c => c == '0').count()
    d.digits = if leading == digits.length() {
      "0"
    } else {
      digits[leading:].to_owned()
    }
    d.point = if d.digits == "0" {
      1
    } else {
      parts[0].length() -
      leading +
      (if shortest.length() > 1 {
        @string.parse_int(shortest[1]) catch {
          _ => 0
        }
      } else {
        0
      })
    }
    while d.digits.length() > 1 && d.digits.has_suffix("0") {
      d.digits = d.digits[:d.digits.length() - 1].to_owned()
    }
    significant = if alternate {
      d.digits.length().max(6)
    } else {
      d.digits.length()
    }
  } else {
    if general {
      significant = significant.max(1)
    }
    d.round(
      if general {
        significant
      } else if verb is ('e' | 'E') {
        significant + 1
      } else {
        d.point + significant
      },
    )
  }
  let mut result = if general {
    if !alternate {
      while d.digits.length() > 1 && d.digits.has_suffix("0") {
        d.digits = d.digits[:d.digits.length() - 1].to_owned()
      }
    }
    let digits = if alternate { significant } else { d.digits.length() }
    let exponent = if d.digits == "0" { 0 } else { d.point - 1 }
    if exponent < -4 ||
      exponent >= (if precision is None { 6 } else { significant }) {
      d.scientific((digits - 1).max(0), verb == 'G')
    } else {
      d.fixed((digits - d.point).max(0))
    }
  } else if verb is ('e' | 'E') {
    d.scientific(significant, verb == 'E')
  } else {
    d.fixed(significant)
  }
  if alternate && !result.contains(".") {
    if result.to_lower().find("e") is Some(at) {
      result = result[:at].to_owned() + "." + result[at:].to_owned()
    } else {
      result += "."
    }
  }
  (if negative { "-" } else { "" }) + result
}
