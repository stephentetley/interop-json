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
    /// Represents a JsonStructure.
    /// Interface
    ///
    pub enum JsonStructure(##javax.json.JsonStructure)


    pub class ImpJsonStructure[t: Type] {
        pub def toJsonStructure(x: t): JsonStructure
        pub def fromJsonStructure(x: JsonStructure): t
    }

    instance Interop/Json.ImpJsonValue[JsonStructure] {
        pub def toJsonValue(x: JsonStructure): JsonValue = 
            let JsonStructure(x1) = x;
            JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

        pub def fromJsonValue(x: JsonValue): JsonStructure = 
            let JsonValue(x1) = x;
            JsonStructure(unsafe_cast x1 as ##javax.json.JsonStructure)
    }


}

namespace Interop/Json/JsonStructure {

    use Interop/Json.JsonStructure;
    use Interop/Json.JsonStructure.{JsonStructure};
    use Interop/Json.ImpJsonStructure;
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};

    pub def getHH(js: JsonStructure): ##javax.json.JsonStructure = 
        let JsonStructure(js1) = js;
        js1

    pub def toJsonStructureHH[t: Type](v: t): ##javax.json.JsonStructure with ImpJsonStructure[t] = 
        Interop/Json/ImpJsonStructure.toJsonStructure(v) |> getHH

    pub def getValue(pointer: String, js: JsonStructure): Result[JsonValue, String] = 
        try { 
            import javax.json.JsonStructure.getValue(String): ##javax.json.JsonValue \ {};
            let JsonStructure(js1) = js;
            getValue(js1, pointer) |> JsonValue |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
