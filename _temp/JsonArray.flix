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


namespace Interop/Json {

    pub enum JsonArray(##javax.json.JsonArray)

    instance ToString[JsonArray] {
        pub def toString(x: JsonArray): String = Interop/Json/JsonArray.toString(x)
    }

    instance Interop/Json.ImpJsonValue[JsonArray] {
        pub def toJsonValue(x: JsonArray): JsonValue = 
            let JsonArray(x1) = x;
            JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

        pub def fromJsonValue(x: JsonValue): JsonArray = 
            let JsonValue(x1) = x;
            JsonArray(unsafe_cast x1 as ##javax.json.JsonArray)
    }

    instance Interop/Json.ImpJsonStructure[JsonArray] {
        pub def toJsonStructure(x: JsonArray): JsonStructure = 
            let JsonArray(x1) = x;
            JsonStructure(unsafe_cast x1 as ##javax.json.JsonStructure)

        pub def fromJsonStructure(x: JsonStructure): JsonArray = 
            let JsonStructure(x1) = x;
            JsonArray(unsafe_cast x1 as ##javax.json.JsonArray) 
    }

}

namespace Interop/Json/JsonArray {

    use Interop/Util.Collection;
    use Interop/Util.Collection.{Collection};
    
    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonNumber;
    use Interop/Json.JsonNumber.{JsonNumber};
    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};
    use Interop/Json.JsonString;
    use Interop/Json.JsonString.{JsonString};
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};

    pub def getHH(arr: JsonArray): ##javax.json.JsonArray = 
        let JsonArray(arr1) = arr;
        arr1

    pub def toString(x: JsonArray): String =
        Interop/Json/ImpJsonValue.toJsonValue(x) |> Interop/Json/JsonValue.toString


    pub def getJsonObject(ix: Int32, arr: JsonArray): Result[JsonObject, String] =
        try {
            import javax.json.JsonArray.getJsonObject(Int32): ##javax.json.JsonObject \ {};
            let JsonArray(arr1) = arr;
            getJsonObject(arr1, ix) |> JsonObject |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def getJsonArray(ix: Int32, arr: JsonArray): Result[JsonArray, String] =
        try {
            import javax.json.JsonArray.getJsonArray(Int32): ##javax.json.JsonArray \ {};
            let JsonArray(arr1) = arr;
            getJsonArray(arr1, ix) |> JsonArray |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def getJsonNumber(ix: Int32, arr: JsonArray): Result[JsonNumber, String] =
        try {
            import javax.json.JsonArray.getJsonNumber(Int32): ##javax.json.JsonNumber \ {};
            let JsonArray(arr1) = arr;
            getJsonNumber(arr1, ix) |> JsonNumber |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def getJsonString(ix: Int32, arr: JsonArray): Result[JsonString, String] =
        try {
            import javax.json.JsonArray.getJsonString(Int32): ##javax.json.JsonString \ {};
            let JsonArray(arr1) = arr;
            getJsonString(arr1, ix) |> JsonString |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def getBoolean(ix: Int32, arr: JsonArray): Result[Bool, String] =
        try {
            import javax.json.JsonArray.getBoolean(Int32): Bool \ {};
            let JsonArray(arr1) = arr;
            getBoolean(arr1, ix) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def getBooleanWithDefault(ix: Int32, d: Bool, arr: JsonArray): Bool =
        import javax.json.JsonArray.getBoolean(Int32, Bool): Bool \ {};
        let JsonArray(arr1) = arr;
        getBoolean(arr1, ix, d)

    pub def getInt(ix: Int32, arr: JsonArray): Result[Int32, String] =
        try {
            import javax.json.JsonArray.getInt(Int32): Int32 \ {};
            let JsonArray(arr1) = arr;
            getInt(arr1, ix) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def getIntWithDefault(ix: Int32, d: Int32, arr: JsonArray): Int32 =
        import javax.json.JsonArray.getInt(Int32, Int32): Int32 \ {};
        let JsonArray(arr1) = arr;
        getInt(arr1, ix, d)

    pub def getString(ix: Int32, arr: JsonArray): Result[String, String] =
        try {
            import javax.json.JsonArray.getString(Int32): String \ {};
            let JsonArray(arr1) = arr;
            getString(arr1, ix) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def getStringWithDefault(ix: Int32, d: String, arr: JsonArray): String =
        import javax.json.JsonArray.getString(Int32, String): String \ {};
        let JsonArray(arr1) = arr;
        getString(arr1, ix, d)


    /// Use Interop/Util.Collection functionality...

    enum JsonArray2[_: Type, _: Region] {
        case JsonArray2(JsonArray)
    }

    instance Interop/Util.ImpCollection[JsonArray2] {
        pub def toCollection(t: JsonArray2[a, r]): Collection[a, r] = 
            let JsonArray2(JsonArray(t1)) = t;
            Collection(unsafe_cast t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): JsonArray2[a, r] = 
            let Collection(t1) = t;
            JsonArray2(JsonArray(unsafe_cast t1 as ##javax.json.JsonArray))
    }

    def wrapWithRegion(_: Region[r], arr: JsonArray): JsonArray2[a, r] = JsonArray2(arr)

    pub def size(arr: JsonArray): Int32 = region r {
        wrapWithRegion(r, arr) |> Interop/Util/ImpCollection.toCollection |> Interop/Util/Collection.size
    }

    pub def isEmpty(arr: JsonArray): Bool = region r {
        wrapWithRegion(r, arr) |> Interop/Util/ImpCollection.toCollection |> Interop/Util/Collection.isEmpty
    }




    pub def isNull(ix: Int32, arr: JsonArray): Bool =
        import javax.json.JsonArray.isNull(Int32): Bool \ {};
        let JsonArray(arr1) = arr;
        isNull(arr1, ix)


    pub def readArray(src: String): Result[JsonArray, String] = region r {
        import new java.io.StringReader(String): ##java.io.StringReader & r as newStringReader;
        import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader & r;
        import javax.json.JsonReader.readArray(): ##javax.json.JsonArray & r;
        import javax.json.JsonReader.close(): Unit & r;
        try {
            let _ = [] @ r;
            let strReader = newStringReader(src);
            let jsonReader = createReader(unsafe_cast strReader as ##java.io.Reader);
            let ans = readArray(jsonReader);
            close(jsonReader);
            Ok(JsonArray(ans))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }
    }

    pub def readFile(path: String): Result[JsonArray, String] \ IO = 
        File.read(path) |> Result.flatMap(readArray)
}
