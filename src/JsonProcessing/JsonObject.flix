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


namespace JsonProcessing {

    pub enum JsonObject(##javax.json.JsonObject)

    instance ToString[JsonObject] {
        pub def toString(x: JsonObject): String = JsonProcessing/JsonObject.toString(x)
    }

}

namespace JsonProcessing/JsonObject {

    use JsonProcessing.JsonObject;
    use JsonProcessing.JsonObject.{JsonObject};

    pub def toString(x: JsonObject): String =
        import javax.json.JsonValue.toString(): String & Pure;
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
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }
    }

    pub def readFile(path: String): Result[JsonObject, String] & Impure = 
        File.read(path) |> Result.flatMap(readObject)
        
}
