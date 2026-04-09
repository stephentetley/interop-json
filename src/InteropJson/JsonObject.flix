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


pub mod InteropJson.JsonObject {

    use InteropJson.JsonObject
    use InteropJson.ToJsonValue
    use InteropJson.JsonArray
    use InteropJson.JsonValue

    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonArray => JJsonArray}
    import jakarta.json.{JsonObject => JJsonObject}
    import jakarta.json.{JsonNumber => JJsonNumber}
    import jakarta.json.{JsonObjectBuilder => JJsonObjectBuilder}
    import java.lang.{Exception => JException}
    import java.lang.{Object => JObject}
    import java.util.{Iterator => JIterator}
    import java.util.{Set => JSet}
    import java.util.{Map$Entry => JMapEntry}
    import java.util.{Collection => JCollection}
    import java.util.function.{BiConsumer => JBiConsumer}

    // Use a threaded region if we will be discarding operations
    // otherwise use unsafe IO { ... }

    pub def equals(x: JsonObject, y: JsonObject): Bool =
        let JsonObject.JsonObject(x1) = x;
        let JsonObject.JsonObject(y1) = y;
        unsafe IO { x1.equals(y1) }

    pub def toJsonValue(x: JsonObject): JsonValue =
        let JsonObject.JsonObject(x1) = x;
        let jsonvalue: JJsonValue = checked_cast(x1);
        JsonValue.JsonValue(jsonvalue)

    pub def empty(): JsonObject = 
        JsonObject.JsonObject(unsafe IO { JJsonValue.EMPTY_JSON_OBJECT })

    pub def isEmpty(obj: JsonObject): Bool = 
        let JsonObject.JsonObject(obj1) = obj;
        unsafe IO { obj1.isEmpty() }

    pub def nonEmpty(x: JsonObject): Bool = not isEmpty(x)

    pub def singleton(k: String, v: t): JsonObject with ToJsonValue[t] = region rc {
        singletonHelper(rc, k, ToJsonValue.toJsonValue(v))
    }


    def singletonHelper(_: Region[r], k: String, v: JsonValue): JsonObject \ r=
        let JsonValue.JsonValue(v1) = v;
        let b1: JJsonObjectBuilder = unchecked_cast(JJson.createObjectBuilder() as _ \ r);
        unchecked_cast(discard b1.add(k, v1) as _ \ r);
        let ans: JJsonObject = unchecked_cast(b1.build() as _ \ r);
        JsonObject.JsonObject(ans)


    pub def add(k: String, v: JsonValue, o: JsonObject): JsonObject = region rc {
        addHelper(rc, k, v, o)
    }


    def addHelper(_: Region[r], k: String, v: JsonValue, o: JsonObject): JsonObject \ r =
        let JsonValue.JsonValue(v1) = v;
        let JsonObject.JsonObject(o1) = o;
        let b1: JJsonObjectBuilder = unchecked_cast(JJson.createObjectBuilder(o1) as _ \ r);
        unchecked_cast(discard b1.add(k, v1) as _ \ r);
        let ans: JJsonObject = unchecked_cast(b1.build() as _ \ r);
        JsonObject.JsonObject(ans)
    
    pub def append(x: JsonObject, y: JsonObject): JsonObject = region rc {
        appendHelper(rc, x, y)
    }


    def appendHelper(_: Region[r], x: JsonObject, y: JsonObject): JsonObject \ r =
        let JsonObject.JsonObject(x1) = x;
        let JsonObject.JsonObject(y1) = y;
        let b1: JJsonObjectBuilder = unchecked_cast(JJson.createObjectBuilder(x1) as _ \ r);
        let b2: JJsonObjectBuilder = unchecked_cast(JJson.createObjectBuilder(y1) as _ \ r);
        unchecked_cast(discard b1.addAll(b2) as _ \ r);
        let ans: JJsonObject = unchecked_cast(b1.build() as _ \ r);
        JsonObject.JsonObject(ans)
    


    pub def size(o: JsonObject): Int32 = 
        let JsonObject.JsonObject(o1) = o;
        unsafe IO {o1.size()}

    def mapEntryKey(x: JMapEntry[k, v]): k = x.getKey()
    def mapEntryValue(x: JMapEntry[k, v]): v = x.getValue()

    pub def toList(obj: JsonObject): List[(String, JsonValue)] =  region rc {
        let JsonObject.JsonObject(obj1) = obj;
        let javaValues: JSet[JMapEntry[String, JJsonValue]] = unsafe IO { obj1.entrySet() };
        let flixIter = Adaptor.fromSetToIterator(rc, javaValues);
        let ans = Iterator.toList(flixIter);
        List.map(mx -> (mapEntryKey(mx), JsonValue.JsonValue(mapEntryValue(mx))), ans)
    } 


    def makeBiConsumer(f: (t1, t2) -> Unit \ ef): JBiConsumer[t1, t2] = 
        unsafe IO { 
            new JBiConsumer[t1, t2] {
                def accept(_this: JBiConsumer[t1, t2], u: t1, v: t2): Unit \ ef = 
                    f(u, v)
            }
        }

    pub def forEach(f: (String, JsonValue) -> Unit \ ef, obj: JsonObject): Unit \ ef =
        let JsonObject.JsonObject(obj1) = obj;
        unchecked_cast(obj1.forEach(makeBiConsumer(f)) as _ \ ef)
    

    
        
    

    // pub def map(f: JsonValue -> JsonValue \ ef, obj: JsonObject): JsonObject \ ef = region rc {
    //     mapHelper(rc, f, obj)
    // }


    // pub def mapHelper(_: Region[r], f: JsonObject -> JsonObject \ ef, obj: JsonObject): JsonObject \ ef + r = 
    //     let JsonObject.JsonObject(obj1) = obj;
    //     let javaValues: JSet[JMapEntry[String, JJsonValue]] = unsafe IO { obj1.entrySet() };
    //     let flixIter = Adaptor.fromSetToIterator(rc, javaValues);
    //     Iterator.forEach(flixIter);
    //     List.map(mx -> (mapEntryKey(mx), JsonValue.JsonValue(mapEntryValue(mx))), ans)


    pub def fromMap(m: Map[String, v]): JsonObject with ToJsonValue[v] = region rc {
        fromMapHelper(rc, m)
    }

    def fromMapHelper(_: Region[r], m: Map[String, v]): JsonObject \ r with ToJsonValue[v] =
        def unwrap(v) = { 
            let JsonValue.JsonValue(v1) = ToJsonValue.toJsonValue(v); 
            v1 
        }; 
        let b1: JJsonObjectBuilder = unchecked_cast(JJson.createObjectBuilder() as _ \ r);
        Map.forEach((k, v) -> { let v1 = unwrap(v); unchecked_cast(discard b1.add(k, v1) as _ \ r) }, m);
        let ans: JJsonObject = unchecked_cast(b1.build() as _ \ r);
        JsonObject.JsonObject(ans)


    pub def getKeys(obj: JsonObject): List[String] = region rc {
        let JsonObject.JsonObject(obj1) = obj;
        let javaKeys: JSet[String] = unsafe IO { obj1.keySet() };
        let flixIter = Adaptor.fromSetToIterator(rc, javaKeys);
        Iterator.toList(flixIter)
    }
    
    pub def getValues(obj: JsonObject): List[JsonValue] = region rc {
        let JsonObject.JsonObject(obj1) = obj;
        let javaValues: JCollection[JJsonValue] = unsafe IO { obj1.values() };
        let flixIter = Adaptor.fromCollectionToIterator(rc, javaValues);
        let ans = Iterator.toList(flixIter);
        List.map(JsonValue.JsonValue, ans)
    }


    pub def isNull(name: {name = String}, obj: JsonObject): Option[Bool] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let ans = unsafe IO { obj1.isNull(name#name) };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBool(name: {name = String}, obj: JsonObject): Option[Bool] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let ans = unsafe IO { obj1.getBoolean(name#name) };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBoolWithDefault(name: {name = String}, d: Bool, obj: JsonObject): Bool = {
        let JsonObject.JsonObject(obj1) = obj;
        unsafe IO { obj1.getBoolean(name#name, d) }
    }

    pub def getInt32(name: {name = String}, obj: JsonObject): Option[Int32] = try {
        let JsonObject.JsonObject(obj1) = obj;        
        let ans = unsafe IO { obj1.getInt(name#name) };
        Some(ans)
    } catch {
        case _: JException => None
    }


    pub def getInt32WithDefault(name: {name = String}, d: Int32, obj: JsonObject): Int32 = {
        let JsonObject.JsonObject(obj1) = obj;
        unsafe IO { obj1.getInt(name#name, d) }
    } 
    
    pub def getInt64(name: {name = String}, obj: JsonObject): Option[Int64] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        let ans = unsafe IO { num.longValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getInt64WithDefault(name: {name = String}, d: Int64, obj: JsonObject): Int64 = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        unsafe IO { num.longValue() }
    } catch {
        case _: JException => d
    }

    pub def getBigInt(name: {name = String}, obj: JsonObject): Option[BigInt] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        let ans = unsafe IO {num.bigIntegerValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBigIntWithDefault(name: {name = String}, d: BigInt, obj: JsonObject): BigInt = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        unsafe IO { num.bigIntegerValue() }
    } catch {
        case _: JException => d
    }

    pub def getFloat64(name: {name = String}, obj: JsonObject): Option[Float64] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        let ans = unsafe IO { num.doubleValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getFloat64WithDefault(name: {name = String}, d: Float64, obj: JsonObject): Float64 = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        unsafe IO {num.doubleValue() }
    } catch {
        case _: JException => d
    }

    pub def getBigDecimal(name: {name = String}, obj: JsonObject): Option[BigDecimal] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        let ans = unsafe IO { num.bigDecimalValue() };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getBigDecimalWithDefault(name: {name = String}, d: BigDecimal, obj: JsonObject): BigDecimal = try {
        let JsonObject.JsonObject(obj1) = obj;
        let num: JJsonNumber = unsafe IO { obj1.getJsonNumber(name#name) };
        unsafe IO {num.bigDecimalValue() }
    } catch {
        case _: JException => d
    }


    pub def getString(name: {name = String}, obj: JsonObject): Option[String] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let ans = unsafe IO { obj1.getString(name#name) };
        Some(ans)
    } catch {
        case _: JException => None
    }

    pub def getStringWithDefault(name: {name = String}, d: String, obj: JsonObject): String = {
        let JsonObject.JsonObject(obj1) = obj;
        unsafe IO { obj1.getString(name#name, d) }
    } 

    pub def getJsonArray(name: {name = String}, obj: JsonObject): Option[JsonArray] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let arr: JJsonArray = unsafe IO { obj1.getJsonArray(name#name) };
        Some(JsonArray.JsonArray(arr))
    } catch {
        case _: JException => None
    }

    pub def getJsonObject(name: {name = String}, obj: JsonObject): Option[JsonObject] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let ans: JJsonObject = unsafe IO { obj1.getJsonObject(name#name) };
        Some(JsonObject.JsonObject(ans))
    } catch {
        case _: JException => None
    }

    pub def getJsonValue(name: {name = String}, obj: JsonObject): Option[JsonValue] = try {
        let JsonObject.JsonObject(obj1) = obj;
        let ans: JJsonValue = unsafe IO { obj1.get(name#name) };
        Some(JsonValue.JsonValue(ans))
    } catch {
        case _: JException => None
    }

}

