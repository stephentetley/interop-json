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
    /// Represents a JsonValue.
    /// Interface
    ///
    pub enum JsonValue(##javax.json.JsonValue)

    instance ToString[JsonValue] {
        pub def toString(x: JsonValue): String = Interop/Json/JsonValue.toString(x)
    }


    pub class ImpJsonValue[t: Type] {
        pub def toJsonValue(x: t): JsonValue
        pub def fromJsonValue(x: JsonValue): t
    }


    instance ImpJsonValue[JsonValue] {
        pub def toJsonValue(x: JsonValue): JsonValue = x
        pub def fromJsonValue(x: JsonValue): JsonValue = x
    }
}

namespace Interop/Json/JsonValue {

    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};
    use Interop/Json/JsonValue.ValueType;
    use Interop/Json/JsonValue.ValueType.{ValueType};
    use Interop/Json.ImpJsonValue;

    pub def getHH(v: JsonValue): ##javax.json.JsonValue = 
        let JsonValue(v1) = v;
        v1

    pub def toJsonValueHH[t: Type](v: t): ##javax.json.JsonValue with ImpJsonValue[t] = 
        Interop/Json/ImpJsonValue.toJsonValue(v) |> getHH



    pub def toString(x: JsonValue): String =
        import javax.json.JsonValue.toString(): String \ {};
        let JsonValue(x1) = x;
        toString(x1)

        
    pub def getValueType(x: JsonValue): ValueType =
        import javax.json.JsonValue.getValueType(): ##javax.json.JsonValue$ValueType \ {};
        let JsonValue(x1) = x;
        getValueType(x1) |> ValueType

    pub def jsonFalse(): JsonValue = 
        import static get javax.json.JsonValue.FALSE: ##javax.json.JsonValue \ {} as get_FALSE;
        JsonValue(get_FALSE())

    pub def jsonTrue(): JsonValue = 
        import static get javax.json.JsonValue.TRUE: ##javax.json.JsonValue \ {} as get_TRUE;
        JsonValue(get_TRUE())
    
    pub def jsonNull(): JsonValue = 
        import static get javax.json.JsonValue.NULL: ##javax.json.JsonValue \ {} as get_NULL;
        JsonValue(get_NULL())

    pub def readValue(src: String): Result[JsonValue, String] = region r {
        import new java.io.StringReader(String): ##java.io.StringReader \ r as newStringReader;
        import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader \ r;
        import javax.json.JsonReader.readValue(): ##javax.json.JsonValue \ r;
        import javax.json.JsonReader.close(): Unit \ r;
        try {
            let _ = [] @ r;
            let strReader = newStringReader(src);
            let jsonReader = createReader(unsafe_cast strReader as ##java.io.Reader);
            let ans = readValue(jsonReader);
            close(jsonReader);
            Ok(JsonValue(ans))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(unsafe_cast ex as ##java.lang.Throwable))
            }
        }
    }

    pub def readFile(path: String): Result[JsonValue, String] \ IO = 
        File.read(path) |> Result.flatMap(readValue)

}
