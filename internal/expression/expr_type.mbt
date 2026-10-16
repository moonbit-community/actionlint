///|
pub(all) enum ExprType {
  AnyTy
  NullTy
  BoolTy
  NumberTy
  StringTy
  ObjectTy(Map[String, ExprType], ExprType?)
  ArrayTy(ExprType, Bool)
} derive(Debug, Eq)

///|
pub fn object_type(
  props~ : Map[String, ExprType] = {},
  mapped? : ExprType,
) -> ExprType {
  ObjectTy(props, mapped)
}

///|
pub fn ExprType::name(self : ExprType) -> String {
  match self {
    AnyTy => "any"
    NullTy => "null"
    BoolTy => "bool"
    NumberTy => "number"
    StringTy => "string"
    ArrayTy(elem, _) => "array<\{elem.name()}>"
    ObjectTy(props, mapped) =>
      match mapped {
        Some(AnyTy) => "object"
        Some(ty) => "{string => \{ty.name()}}"
        None => {
          let keys = props.keys().to_array()
          keys.sort_by(String::lexical_compare)
          "{" + keys.map(k => k + ": " + props[k].name()).join("; ") + "}"
        }
      }
  }
}

///|
pub fn ExprType::assignable(self : ExprType, other : ExprType) -> Bool {
  match (self, other) {
    (AnyTy, _) | (_, AnyTy) | (BoolTy, _) => true
    (StringTy, StringTy | NumberTy) | (NumberTy, NumberTy) | (NullTy, NullTy) =>
      true
    (ArrayTy(a, _), ArrayTy(b, _)) => a.assignable(b)
    (ObjectTy(a, mapped), ObjectTy(b, _)) => {
      for k, ty in a {
        if b.get(k) is Some(other) {
          if !ty.assignable(other) {
            return false
          }
        } else {
          return false
        }
      }
      if mapped is Some(ty) {
        for _, other in b {
          if !ty.assignable(other) {
            return false
          }
        }
      }
      true
    }
    _ => false
  }
}

///|
pub fn ExprType::merge(self : ExprType, other : ExprType) -> ExprType {
  match (self, other) {
    (AnyTy, _) | (_, AnyTy) => AnyTy
    (StringTy, StringTy | NumberTy | BoolTy) | (NumberTy | BoolTy, StringTy) =>
      StringTy
    (BoolTy, BoolTy) => BoolTy
    (NumberTy, NumberTy) => NumberTy
    (NullTy, NullTy) => NullTy
    (ArrayTy(AnyTy, _), ArrayTy(_, _)) => self
    (ArrayTy(_, _), ArrayTy(AnyTy, _)) => other
    (ArrayTy(a, _), ArrayTy(b, _)) => ArrayTy(a.merge(b), false)
    (ObjectTy(a, am), ObjectTy(b, bm)) => {
      let result = a.copy()
      for key, ty in b {
        result[key] = match result.get(key) {
          Some(old) => old.merge(ty)
          None => ty
        }
      }
      let mapped = match (am, bm) {
        (Some(a), Some(b)) => Some(a.merge(b))
        (Some(a), _) | (_, Some(a)) => Some(a)
        _ => None
      }
      ObjectTy(result, mapped)
    }
    _ => AnyTy
  }
}

///|
fn type_from_data(data : Json) -> ExprType {
  match data {
    String("any") => AnyTy
    String("null") => NullTy
    String("bool") => BoolTy
    String("number") => NumberTy
    String("string") => StringTy
    Object(_) => {
      let props : Map[String, ExprType] = Map([])
      if @jsonutil.data_get(data, "props") is Object(values) {
        for key, value in values {
          props[key] = type_from_data(value)
        }
      }
      let mapped = match @jsonutil.data_get(data, "mapped") {
        Null => None
        value => Some(type_from_data(value))
      }
      ObjectTy(props, mapped)
    }
    _ => AnyTy
  }
}

///|
fn type_from_json(data : Json) -> ExprType {
  match data {
    Null => NullTy
    True | False => BoolTy
    String(_) => StringTy
    Number(_, ..) => NumberTy
    Array(values) => {
      let elem = if values.is_empty() {
        AnyTy
      } else {
        let mut ty = type_from_json(values[0])
        for value in values[1:] {
          ty = ty.merge(type_from_json(value))
        }
        ty
      }
      ArrayTy(elem, false)
    }
    Object(values) => {
      let props : Map[String, ExprType] = Map([])
      for key, value in values {
        props[key] = type_from_json(value)
      }
      ObjectTy(props, None)
    }
  }
}

///|
pub fn initial_contexts() -> Map[String, ExprType] {
  let contexts : Map[String, ExprType] = Map([])
  if @jsonutil.data_get(@data.builtin_data, "context_types") is Object(types) {
    for name, ty in types {
      contexts[name] = type_from_data(ty)
    }
  }
  contexts
}
