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

    pub enum JsonValue(##javax.json.JsonValue)

    instance ToString[JsonValue] {
        pub def toString(x: JsonValue): String = JsonProcessing/JsonValue.toString(x)
    }

}

namespace JsonProcessing/JsonValue {

    use JsonProcessing.JsonValue;
    use JsonProcessing.JsonValue.{JsonValue};

    pub enum ValueType with Eq, Order, ToString, Hash, Boxable {
        case JsArray
        case JsFalse
        case JsNull
        case JsNumber
        case JsObject
        case JsString
        case JsTrue
    }

    pub def marshal(x: ValueType): ##javax.json.JsonValue$ValueType =
        import static get javax.json.JsonValue$ValueType.ARRAY: ##javax.json.JsonValue$ValueType & Pure as get_ARRAY;
        import static get javax.json.JsonValue$ValueType.FALSE: ##javax.json.JsonValue$ValueType & Pure as get_FALSE;
        import static get javax.json.JsonValue$ValueType.NULL: ##javax.json.JsonValue$ValueType & Pure as get_NULL;
        import static get javax.json.JsonValue$ValueType.NUMBER: ##javax.json.JsonValue$ValueType & Pure as get_NUMBER;
        import static get javax.json.JsonValue$ValueType.OBJECT: ##javax.json.JsonValue$ValueType & Pure as get_OBJECT;
        import static get javax.json.JsonValue$ValueType.STRING: ##javax.json.JsonValue$ValueType& Pure as get_STRING;
        import static get javax.json.JsonValue$ValueType.TRUE: ##javax.json.JsonValue$ValueType & Pure as get_TRUE;
        match x {
            case JsArray    => get_ARRAY()
            case JsFalse    => get_FALSE()
            case JsNull     => get_NULL()
            case JsNumber   => get_NUMBER()
            case JsObject   => get_OBJECT()
            case JsString   => get_STRING()
            case JsTrue     => get_TRUE() 
        }

    def primEquals(x: ##javax.json.JsonValue$ValueType, y: ##javax.json.JsonValue$ValueType): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)


    pub def unmarshal(x: ##javax.json.JsonValue$ValueType): ValueType = 
        import static get javax.json.JsonValue$ValueType.ARRAY: ##javax.json.JsonValue$ValueType & Pure as get_ARRAY;
        import static get javax.json.JsonValue$ValueType.FALSE: ##javax.json.JsonValue$ValueType & Pure as get_FALSE;
        import static get javax.json.JsonValue$ValueType.NULL: ##javax.json.JsonValue$ValueType & Pure as get_NULL;
        import static get javax.json.JsonValue$ValueType.NUMBER: ##javax.json.JsonValue$ValueType & Pure as get_NUMBER;
        import static get javax.json.JsonValue$ValueType.OBJECT: ##javax.json.JsonValue$ValueType & Pure as get_OBJECT;
        import static get javax.json.JsonValue$ValueType.STRING: ##javax.json.JsonValue$ValueType& Pure as get_STRING;
        import static get javax.json.JsonValue$ValueType.TRUE: ##javax.json.JsonValue$ValueType & Pure as get_TRUE;
        match x {
            case x1 if primEquals(x1, get_ARRAY())      => JsArray
            case x1 if primEquals(x1, get_FALSE())      => JsFalse
            case x1 if primEquals(x1, get_NULL())       => JsNull
            case x1 if primEquals(x1, get_NUMBER())     => JsNumber
            case x1 if primEquals(x1, get_OBJECT())     => JsObject
            case x1 if primEquals(x1, get_STRING())     => JsString
            case x1 if primEquals(x1, get_TRUE())       => JsTrue
        }



    pub def toString(x: JsonValue): String =
        import javax.json.JsonValue.toString(): String & Pure;
        let JsonValue(x1) = x;
        toString(x1)

        
    pub def getValueType(x: JsonValue): ValueType =
        import javax.json.JsonValue.getValueType(): ##javax.json.JsonValue$ValueType & Pure;
        let JsonValue(x1) = x;
        getValueType(x1) |> unmarshal

    pub def jsonFalse(): JsonValue = 
        import static get javax.json.JsonValue.FALSE: ##javax.json.JsonValue & Pure as get_FALSE;
        JsonValue(get_FALSE())

    pub def jsonTrue(): JsonValue = 
        import static get javax.json.JsonValue.TRUE: ##javax.json.JsonValue & Pure as get_TRUE;
        JsonValue(get_TRUE())
    
    pub def jsonNull(): JsonValue = 
        import static get javax.json.JsonValue.NULL: ##javax.json.JsonValue & Pure as get_NULL;
        JsonValue(get_NULL())

    pub def readValue(src: String): Result[JsonValue, String] = region r {
        import new java.io.StringReader(String): ##java.io.StringReader & r as newStringReader;
        import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader & r;
        import javax.json.JsonReader.readValue(): ##javax.json.JsonValue & r;
        import javax.json.JsonReader.close(): Unit & r;
        try {
            let _ = [] @ r;
            let strReader = newStringReader(src);
            let jsonReader = createReader(strReader as ##java.io.Reader);
            let ans = readValue(jsonReader);
            close(jsonReader);
            Ok(JsonValue(ans))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }
    }

    pub def readFile(path: String): Result[JsonValue, String] & Impure = 
        File.read(path) |> Result.flatMap(readValue)
}
