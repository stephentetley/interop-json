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


pub mod InteropJson.JsonValue {

    use InteropJson.JsonValue.ValueType.ValueType
    use InteropJson.JsonValue
    use InteropJson.JsonArray
    use InteropJson.JsonObject

    import java.lang.{Exception => JException}
    import jakarta.json.Json
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonValue$ValueType => JValueType}
    import jakarta.json.{JsonString => JJsonString}
    import jakarta.json.{JsonNumber => JJsonNumber}
    import jakarta.json.{JsonObject => JJsonObject}
    import jakarta.json.{JsonArray => JJsonArray}


        
    pub def getValueType(x: JsonValue): ValueType =
        let JsonValue.JsonValue(x1) = x;
        InteropJson.JsonValue.ValueType.unmarshalValueType(unsafe IO { x1.getValueType() })

    pub def jsonFalse(): JsonValue = 
        JsonValue.JsonValue(unsafe IO { JJsonValue.FALSE })


    pub def jsonTrue(): JsonValue = 
        JsonValue.JsonValue(unsafe IO { JJsonValue.TRUE })
    
    pub def jsonNull(): JsonValue = 
        JsonValue.JsonValue(unsafe IO { JJsonValue.NULL })


    pub def jsonString(s: String): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { Json.createValue(s) });
        JsonValue.JsonValue(value)

    pub def jsonNumberFromInt32(i: Int32): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { Json.createValue(i) });
        JsonValue.JsonValue(value)

    pub def jsonNumberFromInt64(i: Int64): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { Json.createValue(i) });
        JsonValue.JsonValue(value)

    pub def jsonNumberFromFloat64(d: Float64): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { Json.createValue(d) });
        JsonValue.JsonValue(value)

    pub def jsonNumberFromBigInt(i: BigInt): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { Json.createValue(i) });
        JsonValue.JsonValue(value)

    pub def jsonNumberFromBigDecimal(d: BigDecimal): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { Json.createValue(d) });
        JsonValue.JsonValue(value)

    pub def jsonArrayToJsonValue(x: JsonArray): JsonValue =
        let JsonArray.JsonArray(x1) = x;
        let jsonvalue: JJsonValue = checked_cast(x1);
        JsonValue.JsonValue(jsonvalue)


    pub def jsonObjectToJsonValue(x: JsonObject): JsonValue =
        let JsonObject.JsonObject(x1) = x;
        let jsonvalue: JJsonValue = checked_cast(x1);
        JsonValue.JsonValue(jsonvalue)


    pub def isNull(x: JsonValue): Bool = 
        let JsonValue.JsonValue(x1) = x;
        let valueType = unsafe IO { x1.getValueType() };
        unsafe IO { valueType.equals(JValueType.NULL) }

    pub def isTrue(x: JsonValue): Bool = 
        let JsonValue.JsonValue(x1) = x;
        let valueType = unsafe IO { x1.getValueType() };
        unsafe IO { valueType.equals(JValueType.TRUE) }
    
    pub def isFalse(x: JsonValue): Bool = 
        let JsonValue.JsonValue(x1) = x;
        let valueType = unsafe IO { x1.getValueType() };
        unsafe IO { valueType.equals(JValueType.FALSE) }
    
    pub def isNumber(x: JsonValue): Bool = 
        let JsonValue.JsonValue(x1) = x;
        let valueType = unsafe IO { x1.getValueType() };
        unsafe IO { valueType.equals(JValueType.NUMBER) }
    
    pub def isIntegral(x: JsonValue): Bool = 
        if (isNumber(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonnumber = unchecked_cast(x1 as JJsonNumber);
            unsafe IO { jsonnumber.isIntegral() }
        } else false


    pub def isString(x: JsonValue): Bool = 
        let JsonValue.JsonValue(x1) = x;
        let valueType = unsafe IO { x1.getValueType() };
        unsafe IO { valueType.equals(JValueType.STRING) }
    
    pub def isArray(x: JsonValue): Bool = 
        let JsonValue.JsonValue(x1) = x;
        let valueType = unsafe IO { x1.getValueType() };
        unsafe IO { valueType.equals(JValueType.ARRAY) }
    
    pub def isObject(x: JsonValue): Bool = 
        let JsonValue.JsonValue(x1) = x;
        let valueType = unsafe IO { x1.getValueType() };
        unsafe IO { valueType.equals(JValueType.OBJECT) }


    pub def getJsonArray(x: JsonValue): Option[JsonArray] =
        if (isObject(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonarray = unchecked_cast(x1 as JJsonArray);
            Some(JsonArray.JsonArray(jsonarray))
        } else None

    pub def getJsonObject(x: JsonValue): Option[JsonObject] =
        if (isObject(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonobject = unchecked_cast(x1 as JJsonObject);
            Some(JsonObject.JsonObject(jsonobject))
        } else None


    pub def getNull(x: JsonValue): Option[Unit] = 
        if (isNull(x)) Some(()) else None

    pub def getBool(x: JsonValue): Option[Bool] = match x {
        case x1 if InteropJson.JsonValue.isTrue(x1)     => Some(true)
        case x1 if InteropJson.JsonValue.isFalse(x1)    => Some(false)
        case _                                          => None
    }

    pub def getBoolWithDefault(d: Bool, x: JsonValue): Bool = 
        InteropJson.JsonValue.getBool(x) |> Option.getWithDefault(d)

    pub def getString(x: JsonValue): Option[String] = 
        if (isString(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonstring = unchecked_cast(x1 as JJsonString);
            Some(unsafe IO { jsonstring.getString() })     
        } else None


    pub def getStringWithDefault(d: String, x: JsonValue): String = 
        InteropJson.JsonValue.getString(x) |> Option.getWithDefault(d)

    pub def getInt32(x: JsonValue): Option[Int32] = 
        if (isNumber(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonnumber = unchecked_cast(x1 as JJsonNumber);
            Some(unsafe IO { jsonnumber.intValue() })
        } else None

    pub def getInt32WithDefault(d: Int32, x: JsonValue): Int32 = 
        InteropJson.JsonValue.getInt32(x) |> Option.getWithDefault(d)

    pub def getInt32Exact(x: JsonValue): Option[Int32] = 
        if (isNumber(x)) {
            try {
                let JsonValue.JsonValue(x1) = x;
                let jsonnumber = unchecked_cast(x1 as JJsonNumber);
                Some(unsafe IO { jsonnumber.intValueExact() })
            } catch {
                case _: JException => None
            }
        } else None

    pub def getInt64(x: JsonValue): Option[Int64] =
        if (isNumber(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonnumber = unchecked_cast(x1 as JJsonNumber);
            Some(unsafe IO { jsonnumber.longValue() })
        } else None

    pub def getInt64WithDefault(d: Int64, x: JsonValue): Int64 = 
        InteropJson.JsonValue.getInt64(x) |> Option.getWithDefault(d)

    pub def getInt64Exact(x: JsonValue): Option[Int64] =
        if (isNumber(x)) {
            try {
                let JsonValue.JsonValue(x1) = x;
                let jsonnumber = unchecked_cast(x1 as JJsonNumber);
                Some(unsafe IO { jsonnumber.longValueExact() })
            } catch {
                case _: JException => None
            }
        } else None

    pub def getBigInt(x: JsonValue): Option[BigInt] =
        if (isNumber(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonnumber = unchecked_cast(x1 as JJsonNumber);
            Some(unsafe IO { jsonnumber.bigIntegerValue() })
        } else None

    pub def getBigIntWithDefault(d: BigInt, x: JsonValue): BigInt = 
        InteropJson.JsonValue.getBigInt(x) |> Option.getWithDefault(d)


    pub def getBigIntExact(x: JsonValue): Option[BigInt] =
        if (isNumber(x)) {
            try {
                let JsonValue.JsonValue(x1) = x;
                let jsonnumber = unchecked_cast(x1 as JJsonNumber);
                Some(unsafe IO { jsonnumber.bigIntegerValueExact() })
            } catch {
                case _: JException => None
            }
        } else None


    pub def getFloat64(x: JsonValue): Option[Float64] =
        if (isNumber(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonnumber = unchecked_cast(x1 as JJsonNumber);
            Some(unsafe IO { jsonnumber.doubleValue() })
        } else None

    pub def getFloat64WithDefault(d: Float64, x: JsonValue): Float64 = 
        InteropJson.JsonValue.getFloat64(x) |> Option.getWithDefault(d)

    pub def getBigDecimal(x: JsonValue): Option[BigDecimal] =
        if (isNumber(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonnumber = unchecked_cast(x1 as JJsonNumber);
            Some(unsafe IO { jsonnumber.bigDecimalValue() })
        } else None

    pub def getBigDecimalWithDefault(d: BigDecimal, x: JsonValue): BigDecimal = 
        InteropJson.JsonValue.getBigDecimal(x) |> Option.getWithDefault(d)


    // pub def readValue(src: String): Result[JsonValue, String] = region r {
    //     import new java.io.StringReader(String): ##java.io.StringReader \ r as newStringReader;
    //     import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader \ r;
    //     import javax.json.JsonReader.readValue(): ##javax.json.JsonValue \ r;
    //     import javax.json.JsonReader.close(): Unit \ r;
    //     try {
    //         let _ = [] @ r;
    //         let strReader = newStringReader(src);
    //         let jsonReader = createReader(unsafe_cast strReader as ##java.io.Reader);
    //         let ans = readValue(jsonReader);
    //         close(jsonReader);
    //         Ok(JsonValue(ans))
    //     } catch {
    //         case ex: ##java.lang.Exception => {
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             Err(getMessage(unsafe_cast ex as ##java.lang.Throwable))
    //         }
    //     }
    // }

    // pub def readFile(path: String): Result[JsonValue, String] \ IO = 
    //     File.read(path) |> Result.flatMap(readValue)

}
