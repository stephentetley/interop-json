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
    use InteropJson.JsonValue

    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonObject => JJsonObject}
    import jakarta.json.{JsonObjectBuilder => JJsonObjectBuilder}

    // Use a threaded region if we will be discarding operations
    // otherwise use unsafe IO { ... }


    pub def empty(): JsonObject = 
        JsonObject.JsonObject(unsafe IO { JJsonValue.EMPTY_JSON_OBJECT })

    pub def singleton(k: String, v: JsonValue): JsonObject = region rc {
        singletonHelper(rc, k, v)
    }


    pub def singletonHelper(_: Region[r], k: String, v: JsonValue): JsonObject \ r=
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
    
    pub def merge(x: JsonObject, y: JsonObject): JsonObject = region rc {
        mergeHelper(rc, x, y)
    }


    def mergeHelper(_: Region[r], x: JsonObject, y: JsonObject): JsonObject \ r =
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



}

