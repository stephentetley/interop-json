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


pub mod InteropJson.JsonObject {

    use InteropJson.JsonArray.JsonArray
    use InteropJson.JsonNumber.JsonNumber
    use InteropJson.JsonString.JsonString

    import jakarta.json.{JsonObject => JJsonObject}

    pub enum JsonObject(JJsonObject)

    instance ToString[JsonObject] {
        pub def toString(x: JsonObject): String =
            let JsonObject.JsonObject(x1) = x;
            unsafe IO { x1.toString() }
    }

    // instance Interop/Json.ImpJsonValue[JsonObject] {
    //     pub def toJsonValue(x: JsonObject): JsonValue = 
    //         let JsonObject(x1) = x;
    //         JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

    //     pub def fromJsonValue(x: JsonValue): JsonObject = 
    //         let JsonValue(x1) = x;
    //         JsonObject(unsafe_cast x1 as ##javax.json.JsonObject)
    // }

    // instance Interop/Json.ImpJsonStructure[JsonObject] {
    //     pub def toJsonStructure(x: JsonObject): JsonStructure = 
    //         let JsonObject(x1) = x;
    //         JsonStructure(unsafe_cast x1 as ##javax.json.JsonStructure)

    //     pub def fromJsonStructure(x: JsonStructure): JsonObject = 
    //         let JsonStructure(x1) = x;
    //         JsonObject(unsafe_cast x1 as ##javax.json.JsonObject) 
    // }


    pub def getJsonArray(name: String, o: JsonObject): Result[String, JsonArray] =
        Result.tryCatch(_ -> {
            let JsonObject.JsonObject(o1) = o;
            JsonArray.JsonArray(unsafe IO { o1.getJsonArray(name) })
        })

    pub def getJsonObject(name: String, o: JsonObject): Result[String, JsonObject] =
        Result.tryCatch(_ -> {
            let JsonObject.JsonObject(o1) = o;
            JsonObject.JsonObject(unsafe IO { o1.getJsonObject(name) })
        })


    pub def getJsonNumber(name: String, o: JsonObject): Result[String, JsonNumber] =
        Result.tryCatch(_ -> {
            let JsonObject.JsonObject(o1) = o;
            JsonNumber.JsonNumber(unsafe IO { o1.getJsonNumber(name) })
        })

    pub def getJsonString(name: String, o: JsonObject): Result[String, JsonString] =
        Result.tryCatch(_ -> {
            let JsonObject.JsonObject(o1) = o;
            JsonString.JsonString(unsafe IO { o1.getJsonString(name) })
        })

    pub def getString(name: String, o: JsonObject): Result[String, String] =
        Result.tryCatch(_ -> {
            let JsonObject.JsonObject(o1) = o;
            unsafe IO { o1.getString(name) }
        })


    pub def getStringWithDefault(name: String, d: String, o: JsonObject): String =
        let JsonObject.JsonObject(o1) = o;
        unsafe IO { o1.getString(name, d) }


    pub def getInt(name: String, o: JsonObject): Result[String, Int32] =
        Result.tryCatch(_ -> {
            let JsonObject.JsonObject(o1) = o;
            unsafe IO { o1.getInt(name) }
        })

    pub def getIntWithDefault(name: String, d: Int32, o: JsonObject): Int32 =
        let JsonObject.JsonObject(o1) = o;
        unsafe IO { o1.getInt(name, d) }


    pub def getBoolean(name: String, o: JsonObject): Result[String, Bool] =
        Result.tryCatch(_ -> {
            let JsonObject.JsonObject(o1) = o;
            unsafe IO { o1.getBoolean(name) }
        })


    pub def getBooleanWithDefault(name: String, d: Bool, o: JsonObject): Bool =
        let JsonObject.JsonObject(o1) = o;
        unsafe IO { o1.getBoolean(name, d) }


    pub def isNull(name: String, o: JsonObject): Bool =
        let JsonObject.JsonObject(o1) = o;
        unsafe IO { o1.isNull(name) }
    
    // /// Use Interop/Util.MapZ functionality...

    // enum JsonObject3[_k: Type, _v: Type, _r: Region] {
    //     case JsonObject3(JsonObject)
    // }

    // instance Interop/Util.ImpMapZ[JsonObject3] {
    //     pub def toMapZ(t: JsonObject3[k, v, r]): MapZ[k, v, r] = 
    //         let JsonObject3(JsonObject(t1)) = t;
    //         MapZ(unsafe_cast t1 as ##java.util.Map)

    //     pub def fromMapZ(t: MapZ[k, v, r]): JsonObject3[k, v, r] = 
    //         let MapZ(t1) = t;
    //         JsonObject3(JsonObject(unsafe_cast t1 as ##javax.json.JsonObject))
    // }

    // def wrapWithRegion(_: Region[r], o: JsonObject): JsonObject3[k, v, r] = JsonObject3(o)


    // pub def size(o: JsonObject): Int32 = region r {
    //     wrapWithRegion(r, o) |> Interop/Util/ImpMapZ.toMapZ |> Interop/Util/MapZ.size
    // }
    
    // pub def isEmpty(o: JsonObject): Bool = region r {
    //     wrapWithRegion(r, o) |> Interop/Util/ImpMapZ.toMapZ|> Interop/Util/MapZ.isEmpty
    // }

    // pub def readObject(src: String): Result[JsonObject, String] = region r {
    //     import new java.io.StringReader(String): ##java.io.StringReader \ r as newStringReader;
    //     import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader \ r;
    //     import javax.json.JsonReader.readObject(): ##javax.json.JsonObject \ r;
    //     import javax.json.JsonReader.close(): Unit \ r;
    //     try {
    //         let _ = [] @ r;
    //         let strReader = newStringReader(src);
    //         let jsonReader = createReader(unsafe_cast strReader as ##java.io.Reader);
    //         let ans = readObject(jsonReader);
    //         close(jsonReader);
    //         Ok(JsonObject(ans))
    //     } catch {
    //         case ex: ##java.lang.Exception => {
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             Err(getMessage(ex))
    //         }
    //     }
    // }

    // pub def readFile(path: String): Result[JsonObject, String] \ IO = 
    //     File.read(path) |> Result.flatMap(readObject)
        
}
