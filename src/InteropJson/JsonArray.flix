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
    use InteropJson.JsonValue

    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonArray => JJsonArray}
    import jakarta.json.{JsonArrayBuilder => JJsonArrayBuilder}

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



}

