/*
 * Copyright 2022 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


pub mod InteropJson { 

    
    
    import jakarta.json.Json
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonArray => JJsonArray}
    import jakarta.json.{JsonObject => JJsonObject}

    ///
    /// Represents a JsonValue.
    /// Interface
    ///
    pub enum JsonValue(JJsonValue)


    pub enum JsonObject(JJsonObject)

    instance ToString[JsonObject] {
        pub def toString(x: JsonObject): String =
            let JsonObject.JsonObject(x1) = x;
            unsafe IO { x1.toString() }
    }


    pub enum JsonArray(JJsonArray)

    instance ToString[JsonArray] {
        pub def toString(x: JsonArray): String =
            let JsonArray.JsonArray(x1) = x;
            unsafe IO { x1.toString() }
    }


    instance ToString[JsonValue] {
        pub def toString(x: JsonValue): String =
            let JsonValue.JsonValue(x1) = x;
            unsafe IO { x1.toString() }
    }
    

    ///
    /// A trait for types that can be converted to Json.
    ///
    pub trait ToJsonValue[t] {
        ///
        /// Return a Json value representing `x`.
        ///
        pub def toJsonValue(x: t): JsonValue
    }

    instance ToJsonValue[Bool] {
        pub def toJsonValue(x: Bool): JsonValue = match x {
            case true => InteropJson.JsonValue.jsonTrue()
            case false => InteropJson.JsonValue.jsonFalse()
        }
    }

    instance ToJsonValue[Char] {
        pub def toJsonValue(x: Char): JsonValue =
            InteropJson.JsonValue.jsonString(Char.toString(x))
    }

    instance ToJsonValue[String] {
        pub def toJsonValue(x: String): JsonValue =
            InteropJson.JsonValue.jsonString(x)
    }

    instance ToJsonValue[Int8] {
        pub def toJsonValue(x: Int8): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt32(Int8.toInt32(x))
    }

    instance ToJsonValue[Int16] {
        pub def toJsonValue(x: Int16): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt32(Int16.toInt32(x))
    }

    instance ToJsonValue[Int32] {
        pub def toJsonValue(x: Int32): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt32(x)
    }

    instance ToJsonValue[Int64] {
        pub def toJsonValue(x: Int64): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt64(x)
    }

    instance ToJsonValue[Float32] {
        pub def toJsonValue(x: Float32): JsonValue =
            InteropJson.JsonValue.jsonNumberFromFloat64(Float32.toFloat64(x))
    }

    instance ToJsonValue[Float64] {
        pub def toJsonValue(x: Float64): JsonValue =
            InteropJson.JsonValue.jsonNumberFromFloat64(x)
    }

    instance ToJsonValue[BigInt] {
        pub def toJsonValue(x: BigInt): JsonValue =
            InteropJson.JsonValue.jsonNumberFromBigInt(x)
    }

    instance ToJsonValue[BigDecimal] {
        pub def toJsonValue(x: BigDecimal): JsonValue =
            InteropJson.JsonValue.jsonNumberFromBigDecimal(x)
    }

    instance ToJsonValue[Option[t]] with ToJsonValue[t] {
        pub def toJsonValue(x: Option[t]): JsonValue = match x {
            case None => InteropJson.JsonValue.jsonNull()
            case Some(x1) => ToJsonValue.toJsonValue(x1)
        }
    }

    instance ToJsonValue[List[t]] with ToJsonValue[t] {
        pub def toJsonValue(x: List[t]): JsonValue = 
            let xs = List.map(ToJsonValue.toJsonValue, x);
            InteropJson.JsonValue.jsonArrayFromList(xs)
    }

    instance ToJsonValue[Chain[t]] with ToJsonValue[t] {
        pub def toJsonValue(x: Chain[t]): JsonValue = 
            let xs = Chain.map(ToJsonValue.toJsonValue, x);
            InteropJson.JsonValue.jsonArrayFromFoldable(xs)
    }

    instance ToJsonValue[Nel[t]] with ToJsonValue[t] {
        pub def toJsonValue(x: Nel[t]): JsonValue = 
            let xs = Nel.map(ToJsonValue.toJsonValue, x);
            InteropJson.JsonValue.jsonArrayFromFoldable(xs)
    }

    instance ToJsonValue[Nec[t]] with ToJsonValue[t] {
        pub def toJsonValue(x: Nec[t]): JsonValue = 
            let xs = Nec.map(ToJsonValue.toJsonValue, x);
            InteropJson.JsonValue.jsonArrayFromFoldable(xs)
    }


    instance ToJsonValue[JsonValue] {
        pub def toJsonValue(x: JsonValue): JsonValue = x
    }


    instance ToJsonValue[JsonArray] {
        pub def toJsonValue(x: JsonArray): JsonValue =
            InteropJson.JsonValue.jsonArrayToJsonValue(x)
    }

    instance ToJsonValue[JsonObject] {
        pub def toJsonValue(x: JsonObject): JsonValue =
            InteropJson.JsonValue.jsonObjectToJsonValue(x)
    }

    ///
    /// A trait for types that can be parsed from Json.
    ///
    pub trait FromJsonValue[t] {
        ///
        /// Return a value of `t` from a Json document if it can be parsed.
        ///
        pub def fromJsonValue(x: JsonValue): Option[t]
    }

    instance FromJsonValue[Bool] {
        pub def fromJsonValue(x: JsonValue): Option[Bool] = InteropJson.JsonValue.getBool(x)
    }

    instance FromJsonValue[String] {
        pub def fromJsonValue(x: JsonValue): Option[String] = InteropJson.JsonValue.getString(x)
    }

    instance FromJsonValue[Int32] {
        pub def fromJsonValue(x: JsonValue): Option[Int32] = InteropJson.JsonValue.getInt32Exact(x)
    }

    instance FromJsonValue[Int64] {
        pub def fromJsonValue(x: JsonValue): Option[Int64] = InteropJson.JsonValue.getInt64Exact(x)
    }

    instance FromJsonValue[BigInt] {
        pub def fromJsonValue(x: JsonValue): Option[BigInt] = InteropJson.JsonValue.getBigIntExact(x)
    }

    // Not exact
    instance FromJsonValue[Float64] {
        pub def fromJsonValue(x: JsonValue): Option[Float64] = InteropJson.JsonValue.getFloat64(x)
    }

    instance FromJsonValue[BigDecimal] {
        pub def fromJsonValue(x: JsonValue): Option[BigDecimal] = InteropJson.JsonValue.getBigDecimal(x)
    }

    instance FromJsonValue[JsonValue] {
        pub def fromJsonValue(x: JsonValue): Option[JsonValue] = Some(x)
    }

    instance FromJsonValue[JsonArray] {
        pub def fromJsonValue(x: JsonValue): Option[JsonArray] = 
            InteropJson.JsonValue.getJsonArray(x)
    }

    instance FromJsonValue[JsonObject] {
        pub def fromJsonValue(x: JsonValue): Option[JsonObject] = 
            InteropJson.JsonValue.getJsonObject(x)
    }

    pub eff ReadJson {
        def readJson(path: String): Result[IoError, JsonValue]
    }

    pub eff WriteJson {
        def writeJson(path: String, value: JsonValue): Result[IoError, Unit]
    }

    pub eff ReadJsonFromString {
        def readJson(s: String): Result[String, JsonValue]
    }

}
