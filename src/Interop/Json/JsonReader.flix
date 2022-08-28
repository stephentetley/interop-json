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


}

namespace Interop/Json/JsonReader {

    use Interop/Json.JsonReader;
    use Interop/Json.JsonReader.{JsonReader};
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};
    use Interop/Json.ImpJsonStructure;


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
                Err(getMessage(ex as ##java.lang.Throwable))
         }


}
