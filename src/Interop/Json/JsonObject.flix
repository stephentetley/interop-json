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

    pub enum JsonObject(##javax.json.JsonObject)

    instance ToString[JsonObject] {
        pub def toString(x: JsonObject): String = Interop/Json/JsonObject.toString(x)
    }

    instance Interop/Json.ImpJsonValue[JsonObject] {
        pub def toJsonValue(x: JsonObject): JsonValue = 
            let JsonObject(x1) = x;
            JsonValue(x1 as ##javax.json.JsonValue)

        pub def fromJsonValue(x: JsonValue): JsonObject = 
            let JsonValue(x1) = x;
            JsonObject(x1 as ##javax.json.JsonObject)
    }

    instance Interop/Json.ImpJsonStructure[JsonObject] {
        pub def toJsonStructure(x: JsonObject): JsonStructure = 
            let JsonObject(x1) = x;
            JsonStructure(x1 as ##javax.json.JsonStructure)

        pub def fromJsonStructure(x: JsonStructure): JsonObject = 
            let JsonStructure(x1) = x;
            JsonObject(x1 as ##javax.json.JsonObject) 
    }
}

namespace Interop/Json/JsonObject {

    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};
    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonNumber;
    use Interop/Json.JsonNumber.{JsonNumber};
    use Interop/Json.JsonString;
    use Interop/Json.JsonString.{JsonString};

    pub def getHH(o: JsonObject): ##javax.json.JsonObject = 
        let JsonObject(o1) = o;
        o1

    pub def toString(x: JsonObject): String =
        import javax.json.JsonValue.toString(): String \ {};
        let JsonObject(x1) = x;
        toString(x1 as ##javax.json.JsonValue)


    pub def getJsonArray(name: String, o: JsonObject): Result[JsonArray, String] =
        try {
            import javax.json.JsonObject.getJsonArray(String): ##javax.json.JsonArray \ {};
            let JsonObject(o1) = o;
            getJsonArray(o1, name) |> JsonArray |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def getJsonObject(name: String, o: JsonObject): Result[JsonObject, String] =
        try {
            import javax.json.JsonObject.getJsonObject(String): ##javax.json.JsonObject \ {};
            let JsonObject(o1) = o;
            getJsonObject(o1, name) |> JsonObject |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }


    pub def getJsonNumber(name: String, o: JsonObject): Result[JsonNumber, String] =
        try {
            import javax.json.JsonObject.getJsonNumber(String): ##javax.json.JsonNumber \ {};
            let JsonObject(o1) = o;
            getJsonNumber(o1, name) |> JsonNumber |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def getJsonString(name: String, o: JsonObject): Result[JsonString, String] =
        try {
            import javax.json.JsonObject.getJsonString(String): ##javax.json.JsonString \ {};
            let JsonObject(o1) = o;
            getJsonString(o1, name) |> JsonString |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def getString(name: String, o: JsonObject): Result[String, String] =
        try {
            import javax.json.JsonObject.getString(String): String \ {};
            let JsonObject(o1) = o;
            getString(o1, name) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def getStringWithDefault(name: String, d: String, o: JsonObject): String =
        import javax.json.JsonObject.getString(String, String): String \ {};
        let JsonObject(o1) = o;
        getString(o1, name, d)


    pub def getInt(name: String, o: JsonObject): Result[Int32, String] =
        try {
            import javax.json.JsonObject.getInt(String): Int32 \ {};
            let JsonObject(o1) = o;
            getInt(o1, name) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def getIntWithDefault(name: String, d: Int32, o: JsonObject): Int32 =
        import javax.json.JsonObject.getInt(String, Int32): Int32 \ {};
        let JsonObject(o1) = o;
        getInt(o1, name, d)


    pub def getBoolean(name: String, o: JsonObject): Result[Bool, String] =
        try {
            import javax.json.JsonObject.getBoolean(String): Bool \ {};
            let JsonObject(o1) = o;
            getBoolean(o1, name) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def getBooleanWithDefault(name: String, d: Bool, o: JsonObject): Bool =
        import javax.json.JsonObject.getBoolean(String, Bool): Bool \ {};
        let JsonObject(o1) = o;
        getBoolean(o1, name, d)

    pub def isNull(name: String, o: JsonObject): Bool =
        import javax.json.JsonObject.isNull(String): Bool \ {};
        let JsonObject(o1) = o;
        isNull(o1, name)


    pub def readObject(src: String): Result[JsonObject, String] = region r {
        import new java.io.StringReader(String): ##java.io.StringReader & r as newStringReader;
        import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader & r;
        import javax.json.JsonReader.readObject(): ##javax.json.JsonObject & r;
        import javax.json.JsonReader.close(): Unit & r;
        try {
            let _ = [] @ r;
            let strReader = newStringReader(src);
            let jsonReader = createReader(strReader as ##java.io.Reader);
            let ans = readObject(jsonReader);
            close(jsonReader);
            Ok(JsonObject(ans))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }
    }

    pub def readFile(path: String): Result[JsonObject, String] \ IO = 
        File.read(path) |> Result.flatMap(readObject)
        
}
