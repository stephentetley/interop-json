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

    pub enum JsonArray(##javax.json.JsonArray)

    instance ToString[JsonArray] {
        pub def toString(x: JsonArray): String = JsonProcessing/JsonArray.toString(x)
    }

}

namespace JsonProcessing/JsonArray {

    use JsonProcessing.JsonArray;
    use JsonProcessing.JsonArray.{JsonArray};

    pub def toString(x: JsonArray): String =
        import javax.json.JsonValue.toString(): String & Pure;
        let JsonArray(x1) = x;
        toString(x1 as ##javax.json.JsonValue)


    pub def readArray(src: String): Result[JsonArray, String] = region r {
        import new java.io.StringReader(String): ##java.io.StringReader & r as newStringReader;
        import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader & r;
        import javax.json.JsonReader.readArray(): ##javax.json.JsonArray & r;
        import javax.json.JsonReader.close(): Unit & r;
        try {
            let _ = [] @ r;
            let strReader = newStringReader(src);
            let jsonReader = createReader(strReader as ##java.io.Reader);
            let ans = readArray(jsonReader);
            close(jsonReader);
            Ok(JsonArray(ans))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }
    }

    pub def readFile(path: String): Result[JsonArray, String] & Impure = 
        File.read(path) |> Result.flatMap(readArray)
}
