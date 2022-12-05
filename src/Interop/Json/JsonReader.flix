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

    ///
    /// Represents a JsonReader.
    /// Interface / Mutable
    ///
    pub enum JsonReader[_: Region](##javax.json.JsonReader)

    instance Scoped[JsonReader] {
        pub def regionOf(_: JsonReader[r]): Region[r] = unsafe_cast () as Region[r]
    }

}

namespace Interop/Json/JsonReader {

    use Interop/Json.JsonReader;
    use Interop/Json.JsonReader.{JsonReader};
    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};
    use Interop/Json.JsonStructure;
    use Interop/Json.JsonStructure.{JsonStructure};
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};


    pub def getHH(wr: JsonReader[r]): ##javax.json.JsonReader = 
        let JsonReader(wr1) = wr;
        wr1


    pub def close(rd: JsonReader[r]): Result[Unit, String] \ Write(r) = 
        try {
            import javax.json.JsonReader.close(): Unit \ r;
            let JsonReader(rd1) = rd;
            close(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
         }

    pub def read(rd: JsonReader[r]): Result[JsonStructure, String] \ Write(r) = 
        try {
            import javax.json.JsonReader.read(): ##javax.json.JsonStructure \ r;
            let JsonReader(rd1) = rd;
            read(rd1) |> JsonStructure |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
         }

    pub def readArray(rd: JsonReader[r]): Result[JsonArray, String] \ Write(r) = 
        try {
            import javax.json.JsonReader.readArray(): ##javax.json.JsonArray \ r;
            let JsonReader(rd1) = rd;
            readArray(rd1) |> JsonArray |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
         }

    pub def readObject(rd: JsonReader[r]): Result[JsonObject, String] \ Write(r) = 
        try {
            import javax.json.JsonReader.readObject(): ##javax.json.JsonObject \ r;
            let JsonReader(rd1) = rd;
            readObject(rd1) |> JsonObject |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
         }

    pub def readValue(rd: JsonReader[r]): Result[JsonValue, String] \ Write(r) = 
        try {
            import javax.json.JsonReader.readValue(): ##javax.json.JsonValue \ r;
            let JsonReader(rd1) = rd;
            readValue(rd1) |> JsonValue |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
         }

}
