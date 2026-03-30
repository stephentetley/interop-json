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
    
    use InteropJson.JsonValue.JsonValue

    import jakarta.json.Json



    ///
    /// A trait for types that can be converted to Json.
    ///
    pub trait ToJson[t] {
        ///
        /// Return a Json value representing `x`.
        ///
        pub def toJson(x: t): JsonValue
    }

    instance ToJson[Bool] {
        pub def toJson(x: Bool): JsonValue = match x {
            case true => InteropJson.JsonValue.jsonTrue()
            case false => InteropJson.JsonValue.jsonFalse()
        }
    }

    instance ToJson[Char] {
        pub def toJson(x: Char): JsonValue =
            InteropJson.JsonValue.jsonString(Char.toString(x))
    }

    instance ToJson[String] {
        pub def toJson(x: String): JsonValue =
            InteropJson.JsonValue.jsonString(x)
    }

    instance ToJson[Int8] {
        pub def toJson(x: Int8): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt32(Int8.toInt32(x))
    }

    instance ToJson[Int16] {
        pub def toJson(x: Int16): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt32(Int16.toInt32(x))
    }

    instance ToJson[Int32] {
        pub def toJson(x: Int32): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt32(x)
    }

    instance ToJson[Int64] {
        pub def toJson(x: Int64): JsonValue =
            InteropJson.JsonValue.jsonNumberFromInt64(x)
    }

    instance ToJson[Float32] {
        pub def toJson(x: Float32): JsonValue =
            InteropJson.JsonValue.jsonNumberFromFloat64(Float32.toFloat64(x))
    }

    instance ToJson[Float64] {
        pub def toJson(x: Float64): JsonValue =
            InteropJson.JsonValue.jsonNumberFromFloat64(x)
    }

    instance ToJson[BigInt] {
        pub def toJson(x: BigInt): JsonValue =
            InteropJson.JsonValue.jsonNumberFromBigInt(x)
    }

    instance ToJson[BigDecimal] {
        pub def toJson(x: BigDecimal): JsonValue =
            InteropJson.JsonValue.jsonNumberFromBigDecimal(x)
    }

    ///
    /// A trait for types that can be parsed from Json.
    ///
    pub trait FromJson[t] {
        ///
        /// Return a value of `t` from a Json document if it can be parsed.
        ///
        pub def fromJson(x: JsonValue): Option[t]
    }

    instance FromJson[Bool] {
        pub def fromJson(x: JsonValue): Option[Bool] = InteropJson.JsonValue.getBool(x)
    }

    instance FromJson[String] {
        pub def fromJson(x: JsonValue): Option[String] = InteropJson.JsonValue.getString(x)
    }

}
