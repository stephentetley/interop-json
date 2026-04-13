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
    use InteropJson.JsonNumber
    use InteropJson.BuildJsonArray.BuildJsonArray
    use InteropJson.BuildJsonObject.BuildJsonObject
    

    import java.lang.{Exception => JException}
    import jakarta.json.Json
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonValue$ValueType => JValueType}
    import jakarta.json.{JsonString => JJsonString}
    import jakarta.json.{JsonNumber => JJsonNumber}
    import jakarta.json.{JsonObject => JJsonObject}
    import jakarta.json.{JsonArray => JJsonArray}
    import java.util.{Iterator => JIterator}
    import java.util.{Set => JSet}
    import java.util.{Map$Entry => JMapEntry}
    import java.util.{Collection => JCollection}


    pub def equals(x: JsonValue, y: JsonValue): Bool =
        let JsonValue.JsonValue(x1) = x;
        let JsonValue.JsonValue(y1) = y;
        unsafe IO { x1.equals(y1) }

    pub def getValueType(x: JsonValue): ValueType =
        let JsonValue.JsonValue(x1) = x;
        InteropJson.JsonValue.ValueType.unmarshalValueType(unsafe IO { x1.getValueType() })

    pub def jsonFalse(): JsonValue = 
        JsonValue.JsonValue(unsafe IO { JJsonValue.FALSE })


    pub def jsonTrue(): JsonValue = 
        JsonValue.JsonValue(unsafe IO { JJsonValue.TRUE })
    
    pub def jsonNull(): JsonValue = 
        JsonValue.JsonValue(unsafe IO { JJsonValue.NULL })

    pub def jsonEmptyArray(): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { JJsonValue.EMPTY_JSON_ARRAY });
        JsonValue.JsonValue(value)
        
    pub def jsonEmptyObject(): JsonValue = 
        let value: JJsonValue = checked_cast(unsafe IO { JJsonValue.EMPTY_JSON_OBJECT });
        JsonValue.JsonValue(value)

    pub def jsonBool(b: Bool): JsonValue = if(b) jsonTrue() else jsonFalse()

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


    // Null or empty Array or empty Object
    pub def isEmpty(x: JsonValue): Bool = 
        isNull(x) or existsJsonArray(InteropJson.JsonArray.isEmpty, x) or existsJsonObject(InteropJson.JsonObject.isEmpty, x)

    pub def nonEmpty(x: JsonValue): Bool = not isEmpty(x)

    pub def getJsonArray(x: JsonValue): Option[JsonArray] =
        if (isArray(x)) {
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


    pub def getJsonNumber(x: JsonValue): Option[JsonNumber] =
        if (isNumber(x)) {
            let JsonValue.JsonValue(x1) = x;
            let jsonnumber = unchecked_cast(x1 as JJsonNumber);
            Some(JsonNumber.JsonNumber(jsonnumber))
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
        getJsonNumber(x) |> Option.map(InteropJson.JsonNumber.getInt32)

    pub def getInt32WithDefault(d: Int32, x: JsonValue): Int32 = match getJsonNumber(x) {
        case Some(n) => InteropJson.JsonNumber.getInt32(n)
        case None    => d
    }

    pub def getInt64WithDefault(d: Int64, x: JsonValue): Int64 = match getJsonNumber(x) {
        case Some(n) => InteropJson.JsonNumber.getInt64(n)
        case None    => d
    }

    pub def getFloat64WithDefault(d: Float64, x: JsonValue): Float64 = match getJsonNumber(x) {
        case Some(n) => InteropJson.JsonNumber.getFloat64(n)
        case None    => d
    }

    pub def getBigIntWithDefault(d: BigInt, x: JsonValue): BigInt = match getJsonNumber(x) {
        case Some(n) => InteropJson.JsonNumber.getBigInt(n)
        case None    => d
    }

    pub def getBigDecimalWithDefault(d: BigDecimal, x: JsonValue): BigDecimal = match getJsonNumber(x) {
        case Some(n) => InteropJson.JsonNumber.getBigDecimal(n)
        case None    => d
    }


    pub def existsBool(f: Bool -> Bool \ ef, x: JsonValue): Bool \ ef = match getBool(x) {
        case Some(b) => f(b)
        case None    => false
    } 

    pub def existsString(f: String -> Bool \ ef, x: JsonValue): Bool \ ef = match getString(x) {
        case Some(s) => f(s)
        case None    => false
    } 


    pub def existsJsonNumber(f: JsonNumber -> Bool \ ef, x: JsonValue): Bool \ ef = match getJsonNumber(x) {
        case Some(d) => f(d)
        case None    => false
    }


    pub def existsJsonArray(f: JsonArray -> Bool \ ef, x: JsonValue): Bool \ ef = match getJsonArray(x) {
        case Some(arr) => f(arr)
        case None      => false
    }

    pub def existsJsonObject(f: JsonObject -> Bool \ ef, x: JsonValue): Bool \ ef = match getJsonObject(x) {
        case Some(obj) => f(obj)
        case None      => false
    }

    pub def filterJsonNumber(f: JsonNumber -> Bool \ ef, x: JsonValue): JsonValue \ ef = match getJsonNumber(x) {
        case Some(d) => if (f(d)) InteropJson.JsonNumber.toJsonValue(d) else jsonNull()
        case None    => jsonNull()
    }

    pub def filterJsonArray(f: JsonArray -> Bool \ ef, x: JsonValue): JsonValue \ ef = match getJsonArray(x) {
        case Some(arr) => if (f(arr)) InteropJson.JsonArray.toJsonValue(arr) else jsonNull()
        case None      => jsonNull()
    }

    pub def filterJsonObject(f: JsonObject -> Bool \ ef, x: JsonValue): JsonValue \ ef = match getJsonObject(x) {
        case Some(obj) => if (f(obj)) InteropJson.JsonObject.toJsonValue(obj) else jsonNull()
        case None      => jsonNull()
    }


    pub def mapBool(f: Bool -> Bool \ ef, x: JsonValue): JsonValue \ ef = match getBool(x) {
        case Some(b) => jsonBool(f(b))
        case None    => x
    } 

    pub def mapString(f: String -> String \ ef, x: JsonValue): JsonValue \ ef = match getString(x) {
        case Some(s) => jsonString(f(s))
        case None    => x
    }


    pub def mapJsonNumber(f: JsonNumber ->JsonNumber \ ef, x: JsonValue): JsonValue \ ef = match getJsonNumber(x) {
        case Some(d) => f(d) |> InteropJson.JsonNumber.toJsonValue
        case None    => x
    }

    pub def mapJsonArray(f: JsonArray -> JsonArray \ ef, x: JsonValue): JsonValue \ ef = match getJsonArray(x) {
        case Some(arr) => f(arr) |> InteropJson.JsonArray.toJsonValue
        case None      => x
    }

    pub def mapJsonObject(f: JsonObject -> JsonObject \ ef, x: JsonValue): JsonValue \ ef = match getJsonObject(x) {
        case Some(arr) => f(arr) |> InteropJson.JsonObject.toJsonValue
        case None      => x
    }


    pub def readJsonString(s: String): Result[String, JsonValue] = 
        use InteropJson.ReadJsonFromString;
        run {
            ReadJsonFromString.readJson(s) 
        } with InteropJson.ReadJsonFromString.runReadJsonFromString

    pub def readJsonFile(path: String): Result[IoError, JsonValue] \ IO = 
        use InteropJson.ReadJson;
        run {
            ReadJson.readJson(path) 
        } with InteropJson.ReadJson.runWithIO

    pub def writeJsonFile(path: String, value: JsonValue): Result[IoError, Unit] \ IO = 
        use InteropJson.WriteJson;
        run {
            WriteJson.writeJson(path, value) 
        } with InteropJson.WriteJson.runWithIO


}

