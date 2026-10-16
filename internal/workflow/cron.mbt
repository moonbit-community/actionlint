///|
fn cron_number(
  value : StringView,
  names : Array[String],
) -> Int64 raise @model.CliError {
  let lower = value.to_owned().to_lower()
  for i in 0..<names.length() {
    if names[i] != "" && names[i] == lower {
      return i.to_int64()
    }
  }
  if !@matching.regex_match("^[+-]?[0-9]+$", value.to_owned()) {
    raise CliError(
      "failed to parse int from \{value}: strconv.Atoi: parsing \{@model.quote(value.to_owned())}: invalid syntax",
    )
  }
  let number = @string.parse_int64(value, base=10) catch {
    _ =>
      raise CliError(
        "failed to parse int from \{value}: strconv.Atoi: parsing \{@model.quote(value.to_owned())}: value out of range",
      )
  }
  if number < 0L {
    raise CliError("negative number (\{number}) not allowed: \{value}")
  }
  number
}

///|
priv struct CronField {
  values : Array[Int32]
  star : Bool
}

///|
fn cron_field(
  source : String,
  minimum : Int32,
  maximum : Int32,
  names : Array[String],
) -> CronField raise @model.CliError {
  let values : Array[Int32] = []
  let mut wildcard = false
  for part in source.split(",") {
    let steps = part.split("/").to_array()
    let range = steps[0].split("-").to_array()
    let star = range[0] == "*" || range[0] == "?"
    let start = if star {
      minimum.to_int64()
    } else {
      cron_number(range[0], names)
    }
    let mut end = if star {
      maximum.to_int64()
    } else if range.length() == 2 {
      cron_number(range[1], names)
    } else if range.length() == 1 {
      start
    } else {
      raise CliError("too many hyphens: \{part}")
    }
    let step = if steps.length() == 1 {
      1L
    } else if steps.length() == 2 {
      let step = cron_number(steps[1], [])
      if range.length() == 1 {
        end = maximum.to_int64()
      }
      step
    } else {
      raise CliError("too many slashes: \{part}")
    }
    wildcard = wildcard || (star && step <= 1L)
    if start < minimum.to_int64() {
      raise CliError(
        "beginning of range (\{start}) below minimum (\{minimum}): \{part}",
      )
    }
    if end > maximum.to_int64() {
      raise CliError(
        "end of range (\{end}) above maximum (\{maximum}): \{part}",
      )
    }
    if start > end {
      raise CliError(
        "beginning of range (\{start}) beyond end of range (\{end}): \{part}",
      )
    }
    if step == 0L {
      raise CliError("step of range should be a positive number: \{part}")
    }
    for value = start; value <= end; {
      if !values.contains(value.to_int()) {
        values.push(value.to_int())
      }
      if step > end - value {
        break
      }
      continue value + step
    }
  }
  values.sort()
  { values, star: wildcard, }
}

///|
fn cron_interval(spec : String) -> Int32 raise @model.CliError {
  let fields = spec
    .iter()
    .map(c => {
      if c
        is ('\t'..<='\r'
        | ' '
        | '\u0085'
        | '\u00a0'
        | '\u1680'
        | '\u2000'..<='\u200a'
        | '\u2028'
        | '\u2029'
        | '\u202f'
        | '\u205f'
        | '\u3000') {
        " "
      } else {
        c.to_string()
      }
    })
    .to_array()
    .join("")
    .split(" ")
    .filter(s => s != "")
    .map(s => s.to_owned())
    .to_array()
  if fields.length() > 0 &&
    (fields[0].has_prefix("TZ=") || fields[0].has_prefix("CRON_TZ=")) {
    let prefix = fields.remove(0)
    let zone = prefix.split("=").last().unwrap_or("").to_owned()
    if zone != "" &&
      zone != "Local" &&
      zone != "UTC" &&
      !@jsonutil.json_strings(
        @jsonutil.data_get(@data.builtin_data, "timezones"),
      ).contains(zone) {
      let reason = if zone.has_prefix("/") || zone.contains("..") {
        "time: invalid location name"
      } else {
        "unknown time zone " + zone
      }
      raise CliError("provided bad location \{zone}: \{reason}")
    }
  }
  if fields.get(0).map(s => s.has_prefix("@")).unwrap_or(false) {
    raise CliError("parser does not accept descriptors: " + fields.join(" "))
  }
  if fields.length() != 5 {
    raise CliError(
      "expected exactly 5 fields, found \{fields.length()}: [\{fields.join(" ")}]",
    )
  }
  let minutes = cron_field(fields[0], 0, 59, [])
  let hours = cron_field(fields[1], 0, 23, [])
  let days = cron_field(fields[2], 1, 31, [])
  let months = cron_field(fields[3], 1, 12, [
    "", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov",
    "dec",
  ])
  let weekdays = cron_field(fields[4], 0, 6, [
    "sun", "mon", "tue", "wed", "thu", "fri", "sat",
  ])
  let day_star = days.star
  let week_star = weekdays.star
  let mut year = 1970
  let mut month = 1
  let mut day = 1
  let mut first : Int32? = None
  let mut elapsed = 0
  let mut limit = 366 * 5
  while elapsed < limit {
    let dom = days.values.contains(day)
    let dow = weekdays.values.contains((elapsed + 4) % 7)
    if months.values.contains(month) &&
      (if day_star || week_star { dom && dow } else { dom || dow }) {
      for hour in hours.values {
        for minute in minutes.values {
          let timestamp = elapsed * 1440 + hour * 60 + minute
          if timestamp == 0 {
            continue
          }
          if first is Some(start) {
            return (timestamp - start) * 60
          }
          first = Some(timestamp)
          limit = elapsed + 366 * 5
        }
      }
    }
    let leap = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
    let length = if month == 2 {
      if leap {
        29
      } else {
        28
      }
    } else if [4, 6, 9, 11].contains(month) {
      30
    } else {
      31
    }
    elapsed += 1
    day += 1
    if day > length {
      day = 1
      month += 1
    }
    if month > 12 {
      month = 1
      year += 1
    }
  }
  0
}

///|
fn @model.Check::check_cron(self : @model.Check, n : @model.Node) -> Unit {
  let seconds = cron_interval(n.value) catch {
    CliError(message) => {
      self.report(
        n,
        "events",
        "invalid CRON format \{@model.quote(n.value)} in schedule event: \{message}",
      )
      return
    }
  }
  if seconds < 300 {
    self.report(
      n,
      "events",
      "scheduled job runs too frequently. it runs once per \{seconds} seconds. the shortest interval is once every 5 minutes",
    )
  }
}
