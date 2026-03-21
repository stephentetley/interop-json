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


pub mod InteropJson.JsonArray {

    use InteropJson.JsonObject.JsonObject
    use InteropJson.JsonNumber.JsonNumber
    use InteropJson.JsonString.JsonString

    import jakarta.json.{JsonArray => JJsonArray}
    
    pub enum JsonArray(JJsonArray)

    instance ToString[JsonArray] {
        pub def toString(x: JsonArray): String =
            let JsonArray.JsonArray(x1) = x;
            unsafe IO { x1.toString() }
    }

    // instance Interop/Json.ImpJsonValue[JsonArray] {
    //     pub def toJsonValue(x: JsonArray): JsonValue = 
    //         let JsonArray(x1) = x;
    //         JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

    //     pub def fromJsonValue(x: JsonValue): JsonArray = 
    //         let JsonValue(x1) = x;
    //         JsonArray(unsafe_cast x1 as ##javax.json.JsonArray)
    // }

    // instance Interop/Json.ImpJsonStructure[JsonArray] {
    //     pub def toJsonStructure(x: JsonArray): JsonStructure = 
    //         let JsonArray(x1) = x;
    //         JsonStructure(unsafe_cast x1 as ##javax.json.JsonStructure)

    //     pub def fromJsonStructure(x: JsonStructure): JsonArray = 
    //         let JsonStructure(x1) = x;
    //         JsonArray(unsafe_cast x1 as ##javax.json.JsonArray) 
    // }



    pub def getJsonObject(ix: Int32, arr: JsonArray): Result[String, JsonObject] =
        Result.tryCatch(_ -> {
            let JsonArray.JsonArray(arr1) = arr;
            JsonObject.JsonObject(unsafe IO { arr1.getJsonObject(ix) })
        })


    pub def getJsonArray(ix: Int32, arr: JsonArray): Result[String, JsonArray] =
        Result.tryCatch(_ -> {
            let JsonArray.JsonArray(arr1) = arr;
            JsonArray.JsonArray(unsafe IO { arr1.getJsonArray(ix) })
        })

    pub def getJsonNumber(ix: Int32, arr: JsonArray): Result[String, JsonNumber] =
        Result.tryCatch(_ -> {
            let JsonArray.JsonArray(arr1) = arr;
            JsonNumber.JsonNumber(unsafe IO { arr1.getJsonNumber(ix) })
        })

    pub def getJsonString(ix: Int32, arr: JsonArray): Result[String, JsonString] =
        Result.tryCatch(_ -> {
            let JsonArray.JsonArray(arr1) = arr;
            JsonString.JsonString(unsafe IO { arr1.getJsonString(ix) })
        })



    pub def getBoolean(ix: Int32, arr: JsonArray): Result[String, Bool] =
        Result.tryCatch(_ -> {
            let JsonArray.JsonArray(arr1) = arr;
            unsafe IO { arr1.getBoolean(ix) }
        })


    pub def getBooleanWithDefault(ix: Int32, d: Bool, arr: JsonArray): Bool =
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO { arr1.getBoolean(ix, d) }

    pub def getInt(ix: Int32, arr: JsonArray): Result[String, Int32] =
        Result.tryCatch(_ -> {
            let JsonArray.JsonArray(arr1) = arr;
            unsafe IO { arr1.getInt(ix) }
        })

    pub def getIntWithDefault(ix: Int32, d: Int32, arr: JsonArray): Int32 =
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO { arr1.getInt(ix, d) }

    pub def getString(ix: Int32, arr: JsonArray): Result[String, String] =
        Result.tryCatch(_ -> {
            let JsonArray.JsonArray(arr1) = arr;
            unsafe IO { arr1.getString(ix) }
        })

    pub def getStringWithDefault(ix: Int32, d: String, arr: JsonArray): String =
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO { arr1.getString(ix, d) }


    // /// Use Interop/Util.Collection functionality...

    // enum JsonArray2[_: Type, _: Region] {
    //     case JsonArray2(JsonArray)
    // }

    // instance Interop/Util.ImpCollection[JsonArray2] {
    //     pub def toCollection(t: JsonArray2[a, r]): Collection[a, r] = 
    //         let JsonArray2(JsonArray(t1)) = t;
    //         Collection(unsafe_cast t1 as ##java.util.Collection)

    //     pub def fromCollection(t: Collection[a, r]): JsonArray2[a, r] = 
    //         let Collection(t1) = t;
    //         JsonArray2(JsonArray(unsafe_cast t1 as ##javax.json.JsonArray))
    // }

    // def wrapWithRegion(_: Region[r], arr: JsonArray): JsonArray2[a, r] = JsonArray2(arr)

    // pub def size(arr: JsonArray): Int32 = region r {
    //     wrapWithRegion(r, arr) |> Interop/Util/ImpCollection.toCollection |> Interop/Util/Collection.size
    // }

    // pub def isEmpty(arr: JsonArray): Bool = region r {
    //     wrapWithRegion(r, arr) |> Interop/Util/ImpCollection.toCollection |> Interop/Util/Collection.isEmpty
    // }




    pub def isNull(ix: Int32, arr: JsonArray): Bool =
        let JsonArray.JsonArray(arr1) = arr;
        unsafe IO { arr1.isNull(ix) }


    // pub def readArray(src: String): Result[JsonArray, String] = region r {
    //     import new java.io.StringReader(String): ##java.io.StringReader & r as newStringReader;
    //     import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader & r;
    //     import javax.json.JsonReader.readArray(): ##javax.json.JsonArray & r;
    //     import javax.json.JsonReader.close(): Unit & r;
    //     try {
    //         let _ = [] @ r;
    //         let strReader = newStringReader(src);
    //         let jsonReader = createReader(unsafe_cast strReader as ##java.io.Reader);
    //         let ans = readArray(jsonReader);
    //         close(jsonReader);
    //         Ok(JsonArray(ans))
    //     } catch {
    //         case ex: ##java.lang.Exception => {
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             Err(getMessage(ex))
    //         }
    //     }
    // }

    // pub def readFile(path: String): Result[JsonArray, String] \ IO = 
    //     File.read(path) |> Result.flatMap(readArray)

}
