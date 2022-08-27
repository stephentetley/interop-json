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

    pub def toString(x: JsonObject): String =
        import javax.json.JsonValue.toString(): String \ {};
        let JsonObject(x1) = x;
        toString(x1 as ##javax.json.JsonValue)


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
