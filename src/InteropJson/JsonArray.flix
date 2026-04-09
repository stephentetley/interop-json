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
    use InteropJson.JsonArray.mapHelper
    
    use InteropJson.ToJsonValue
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
    import java.util.{Iterator => JIterator}

    // Use a threaded region if we will be discarding operations
    // otherwise use unsafe IO { ... }

    pub def equals(x: JsonArray, y: JsonArray): Bool =
        let JsonArray.JsonArray(x1) = x;
        let JsonArray.JsonArray(y1) = y;
        unsafe IO { x1.equals(y1) }


    pub def toJsonValue(x: JsonArray): JsonValue = 
        let JsonArray.JsonArray(x1) = x;
        let jsonvalue: JJsonValue = checked_cast(x1);
        JsonValue.JsonValue(jsonvalue)

    pub def empty(): JsonArray = 
        JsonArray.JsonArray(unsafe IO { JJsonValue.EMPTY_JSON_ARRAY })


    pub def isEmpty(arr: JsonArray): Bool = 
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO { arr1.isEmpty() }

    pub def nonEmpty(x: JsonArray): Bool = not isEmpty(x)

    pub def singleton(v: t): JsonArray with ToJsonValue[t] = region rc {
        singletonHelper(rc, ToJsonValue.toJsonValue(v))
    }


    pub def singletonHelper(_: Region[r], v: JsonValue): JsonArray \ r=
        let JsonValue.JsonValue(v1) = v;
        let b1: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder() as _ \ r);
        unchecked_cast(discard b1.add(v1) as _ \ r);
        let ans: JJsonArray = unchecked_cast(b1.build() as _ \ r);
        JsonArray.JsonArray(ans)


    pub def add(v: t, o: JsonArray): JsonArray with ToJsonValue[t] = region rc {
        addHelper(rc, ToJsonValue.toJsonValue(v), o)
    }


    def addHelper(_: Region[r], v: JsonValue, arr: JsonArray): JsonArray \ r =
        let JsonValue.JsonValue(v1) = v;
        let JsonArray.JsonArray(arr1) = arr;
        let b1: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder(arr1) as _ \ r);
        unchecked_cast(discard b1.add(v1) as _ \ r);
        let ans: JJsonArray = unchecked_cast(b1.build() as _ \ r);
        JsonArray.JsonArray(ans)
    
    pub def append(x: JsonArray, y: JsonArray): JsonArray = region rc {
        appendHelper(rc, x, y)
    }


    def appendHelper(_: Region[r], x: JsonArray, y: JsonArray): JsonArray \ r =
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


    pub def toList(arr: JsonArray): List[JsonValue] = region rc {
        let JsonArray.JsonArray(arr1) = arr;
        let proxy: Proxy[JJsonValue] = Proxy.Proxy; 
        let javaIter: JIterator[JJsonValue] = unsafe IO { arr1.iterator() };
        let flixIter = Adaptor.fromIterator(rc, proxy, javaIter);
        let ans = Iterator.toList(flixIter);
        List.map(JsonValue.JsonValue, ans)
    }

    pub def map(f: JsonValue -> JsonValue \ ef, arr: JsonArray): JsonArray \ ef = region rc {
        mapHelper(rc, f, arr)
    }


    pub def mapHelper(_: Region[r], f: JsonValue -> JsonValue \ ef, arr: JsonArray): JsonArray \ ef + r = 
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        let builder: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder() as _ \ r);
        @Tailrec
        def loop(ix) = 
            if (ix < len) {
                let jv: JJsonValue = unchecked_cast(arr1.get(ix) as _ \ r);
                let JsonValue.JsonValue(jv1) = f(JsonValue.JsonValue(jv));
                unchecked_cast(discard builder.add(jv1) as _ \ r);
                loop(ix + 1)
            } else ();
        loop(0);
        let ans: JJsonArray = unchecked_cast(builder.build() as _ \ r);
        JsonArray.JsonArray(ans)
    
    pub def filter(f: JsonValue -> Bool \ ef, arr: JsonArray): JsonArray \ ef = region rc {
        filterHelper(rc, f, arr)
    }


    pub def filterHelper(_: Region[r], f: JsonValue -> Bool \ ef, arr: JsonArray): JsonArray \ ef + r = 
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        let builder: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder() as _ \ r);
        @Tailrec
        def loop(ix) = 
            if (ix < len) {
                let jv: JJsonValue = unchecked_cast(arr1.get(ix) as _ \ r);
                if (f(JsonValue.JsonValue(jv)))
                    unchecked_cast(discard builder.add(jv) as _ \ r)
                else ();
                loop(ix + 1)
            } else ();
        loop(0);
        let ans: JJsonArray = unchecked_cast(builder.build() as _ \ r);
        JsonArray.JsonArray(ans)


    pub def foldLeft(f: (b, JsonValue) -> b \ ef, s: b, arr: JsonArray): b \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix, acc) = 
            if (ix < len) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                let acc1 = f(acc, v1);
                loop(ix + 1, acc1)
            } else acc;
        loop(0, s)

    pub def foldRight(f: (JsonValue, b) -> b \ ef, s: b, arr: JsonArray): b \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix, acc) = 
            if (ix >= 0) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                let acc1 = f(v1, acc);
                loop(ix - 1, acc1)
            } else acc;
        loop(len-1, s)

    pub def forEach(f: JsonValue -> Unit \ ef, arr: JsonArray): Unit \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix) = 
            if (ix < len) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                f(v1);
                loop(ix + 1)
            } else ();
        loop(0)

    pub def forEachWithIndex(f: (Int32, JsonValue) -> Unit \ ef, arr: JsonArray): Unit \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix) = 
            if (ix < len) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                f(ix, v1);
                loop(ix + 1)
            } else ();
        loop(0)


    pub def exists(f: JsonValue -> Bool \ ef, arr: JsonArray): Bool \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix, k) = 
            if (ix < len) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                if (f(v1)) 
                    k(true) 
                else loop(ix + 1, k)
            } else false;
        loop(0, identity)

    pub def find(f: JsonValue -> Bool \ ef, arr: JsonArray): Option[JsonValue] \ ef = findLeft(f, arr)

    pub def findLeft(f: JsonValue -> Bool \ ef, arr: JsonArray): Option[JsonValue] \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix, k) = 
            if (ix < len) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                if (f(v1)) 
                    k(Some(v1) )
                else loop(ix + 1, k)
            } else None;
        loop(0, identity)

    pub def findRight(f: JsonValue -> Bool \ ef, arr: JsonArray): Option[JsonValue] \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix, k) = 
            if (ix >= 0) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                if (f(v1)) 
                    k(Some(v1) )
                else loop(ix - 1, k)
            } else None;
        loop(len - 1, identity)


    pub def findMap(f: JsonValue -> Option[b] \ ef, arr: JsonArray): Option[b] \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix, k) = 
            if (ix < len) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                match (f(v1)) {
                    case Some(ans)  => k(Some(ans))
                    case None       => loop(ix + 1, k)
                }
            } else None;
        loop(0, identity)

    pub def forAll(f: JsonValue -> Bool \ ef, arr: JsonArray): Bool \ ef =
        let len = size(arr); 
        let JsonArray.JsonArray(arr1) = arr;
        @Tailrec
        def loop(ix, acc) = 
            if (ix < len) {
                let jv: JJsonValue = unsafe IO { arr1.get(ix) };
                let v1 = JsonValue.JsonValue(jv);
                let acc1 = f(v1) and acc;
                loop(ix + 1, acc1)
            } else acc;
        loop(0, true)


    pub def fromList(t: List[v]): JsonArray with ToJsonValue[v] = region rc {
        fromFoldableHelper(rc, t)
    }
    
    pub def fromFoldable(t: t[v]): JsonArray \ Foldable.Aef[t] with Foldable[t], ToJsonValue[v]  = region rc {
        fromFoldableHelper(rc, t)
    }

    def fromFoldableHelper(_: Region[r], xs: t[v]): JsonArray \ r + Foldable.Aef[t] with Foldable[t], ToJsonValue[v]=
        def unwrap(v) = { 
            let JsonValue.JsonValue(v1) = ToJsonValue.toJsonValue(v); 
            v1 
        }; 
        let b1: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder() as _ \ r);
        Foldable.forEach(v -> { let v1 = unwrap(v); unchecked_cast(discard b1.add(v1) as _ \ r) }, xs);
        let ans: JJsonArray = unchecked_cast(b1.build() as _ \ r);
        JsonArray.JsonArray(ans)



    // // This should be implmented as per `jsonArrayFromList` with the effect step:
    // // Foldable.forEach(v -> BuildJsonArray.addJsonValue(v), t)
    // // However it currently doesn't type check so we have to traverse twice
    // pub def jsonArrayFromFoldable(t: t[JsonValue]): JsonValue \ Foldable.Aef[t] with Foldable[t] =
    //     Foldable.toList(t) |> jsonArrayFromList

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

