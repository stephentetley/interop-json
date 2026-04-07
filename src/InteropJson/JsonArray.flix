/*
 * Copyright 2026 Stephen Tetley
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


pub mod InteropJson.JsonArray {
    
    use InteropJson.JsonArray
    use InteropJson.JsonObject
    use InteropJson.JsonValue

    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonArray => JJsonArray}
    import jakarta.json.{JsonObject => JJsonObject}
    import jakarta.json.{JsonNumber => JJsonNumber}
    import jakarta.json.{JsonArrayBuilder => JJsonArrayBuilder}
    import java.lang.{Exception => JException}

    // Use a threaded region if we will be discarding operations
    // otherwise use unsafe IO { ... }


    pub def empty(): JsonArray = 
        JsonArray.JsonArray(unsafe IO { JJsonValue.EMPTY_JSON_ARRAY })

    pub def singleton(v: JsonValue): JsonArray = region rc {
        singletonHelper(rc, v)
    }


    pub def singletonHelper(_: Region[r], v: JsonValue): JsonArray \ r=
        let JsonValue.JsonValue(v1) = v;
        let b1: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder() as _ \ r);
        unchecked_cast(discard b1.add(v1) as _ \ r);
        let ans: JJsonArray = unchecked_cast(b1.build() as _ \ r);
        JsonArray.JsonArray(ans)


    pub def add(v: JsonValue, o: JsonArray): JsonArray = region rc {
        addHelper(rc, v, o)
    }


    def addHelper(_: Region[r], v: JsonValue, arr: JsonArray): JsonArray \ r =
        let JsonValue.JsonValue(v1) = v;
        let JsonArray.JsonArray(arr1) = arr;
        let b1: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder(arr1) as _ \ r);
        unchecked_cast(discard b1.add(v1) as _ \ r);
        let ans: JJsonArray = unchecked_cast(b1.build() as _ \ r);
        JsonArray.JsonArray(ans)
    
    pub def merge(x: JsonArray, y: JsonArray): JsonArray = region rc {
        mergeHelper(rc, x, y)
    }


    def mergeHelper(_: Region[r], x: JsonArray, y: JsonArray): JsonArray \ r =
        let JsonArray.JsonArray(x1) = x;
        let JsonArray.JsonArray(y1) = y;
        let b1: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder(x1) as _ \ r);
        let b2: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder(y1) as _ \ r);
        unchecked_cast(discard b1.addAll(b2) as _ \ r);
        let ans: JJsonArray = unchecked_cast(b1.build() as _ \ r);
        JsonArray.JsonArray(ans)
    


    pub def size(o: JsonArray): Int32 = 
        let JsonArray.JsonArray(o1) = o;
        unsafe IO {o1.size()}

    pub def isNull(ix: {index = Int32}, arr: JsonArray): Option[Bool] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let ans = unsafe IO {arr1.isNull(ix#index) };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBool(ix: {index = Int32}, arr: JsonArray): Option[Bool] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let ans = unsafe IO { arr1.getBoolean(ix#index) };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBoolWithDefault(ix: {index = Int32}, d: Bool, arr: JsonArray): Bool = {
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO {arr1.getBoolean(ix#index, d) }
    } 

    pub def getInt32(ix: {index = Int32}, arr: JsonArray): Option[Int32] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let ans = unsafe IO {arr1.getInt(ix#index) };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getInt32WithDefault(ix: {index = Int32}, d: Int32, arr: JsonArray): Int32 = {
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO {arr1.getInt(ix#index, d) }
    } 
    
    pub def getInt64(ix: {index = Int32}, arr: JsonArray): Option[Int64] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        let ans = unsafe IO { num.longValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getInt64WithDefault(ix: {index = Int32}, d: Int64, arr: JsonArray): Int64 = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        unsafe IO { num.longValue() }
    } catch {
        case _: JException => d
    }

    pub def getBigInt(ix: {index = Int32}, arr: JsonArray): Option[BigInt] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        let ans = unsafe IO { num.bigIntegerValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBigIntWithDefault(ix: {index = Int32}, d: BigInt, arr: JsonArray): BigInt = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        unsafe IO { num.bigIntegerValue() }
    } catch {
        case _: JException => d
    }

    pub def getFloat64(ix: {index = Int32}, arr: JsonArray): Option[Float64] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        let ans = unsafe IO { num.doubleValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getFloat64WithDefault(ix: {index = Int32}, d: Float64, arr: JsonArray): Float64 = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        unsafe IO { num.doubleValue() }
    } catch {
        case _: JException => d
    }

    pub def getBigDecimal(ix: {index = Int32}, arr: JsonArray): Option[BigDecimal] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        let ans = unsafe IO { num.bigDecimalValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBigDecimalWithDefault(ix: {index = Int32}, d: BigDecimal, arr: JsonArray): BigDecimal = try {
        let JsonArray.JsonArray(arr1) = arr;
        let num: JJsonNumber = unsafe IO {arr1.getJsonNumber(ix#index) };
        unsafe IO { num.bigDecimalValue() }
    } catch {
        case _: JException => d
    }

    pub def getString(ix: {index = Int32}, arr: JsonArray): Option[String] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let ans = unsafe IO {arr1.getString(ix#index) };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getStringWithDefault(ix: {index = Int32}, d: String, arr: JsonArray): String = {
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO {arr1.getString(ix#index, d) }
    } 

    pub def getJsonArray(ix: {index = Int32}, arr: JsonArray): Option[JsonArray] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let ans: JJsonArray = unsafe IO {arr1.getJsonArray(ix#index) };
        Some(JsonArray.JsonArray(ans))
    } catch {
        case _: JException => None
    }

    pub def getJsonObject(ix: {index = Int32}, arr: JsonArray): Option[JsonObject] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let obj: JJsonObject = unsafe IO { arr1.getJsonObject(ix#index) };
        Some(JsonObject.JsonObject(obj))
    } catch {
        case _: JException => None
    }

    pub def getJsonValue(ix: {index = Int32}, arr: JsonArray): Option[JsonValue] = try {
        let JsonArray.JsonArray(arr1) = arr;
        let obj: JJsonValue = unsafe IO { arr1.get(ix#index) };
        Some(JsonValue.JsonValue(obj))
    } catch {
        case _: JException => None
    }


}

