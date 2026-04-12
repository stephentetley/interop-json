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


pub mod InteropJson.JsonValue.ValueView {
    

    use InteropJson.{JsonValue, JsonArray, JsonObject}
    use InteropJson.JsonValue.ValueType.ValueType
    
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{JsonString => JJsonString}
    import jakarta.json.{JsonNumber => JJsonNumber}
    import jakarta.json.{JsonObject => JJsonObject}
    import jakarta.json.{JsonArray => JJsonArray}

    pub enum JsonValueView with ToString {
        case JsNull
        case JsFalse
        case JsTrue
        case JsString(String)
        case JsNumber(BigDecimal)
        case JsArray(JsonArray)
        case JsObject(JsonObject)
    }

    pub def viewJsonValue(x: JsonValue): JsonValueView = 
        match InteropJson.JsonValue.getValueType(x) {
            
            case ValueType.ARRAY    => { 
                let JsonValue.JsonValue(x1) = x;
                let jsonarray = unchecked_cast(x1 as JJsonArray);
                JsonValueView.JsArray(JsonArray.JsonArray(jsonarray))
            }

            case ValueType.FALSE    => JsonValueView.JsFalse

            case ValueType.NULL     => JsonValueView.JsNull
            
            case ValueType.NUMBER   => { 
                let JsonValue.JsonValue(x1) = x;
                let jsonnumber = unchecked_cast(x1 as JJsonNumber);
                JsonValueView.JsNumber(unsafe IO { jsonnumber.bigDecimalValue() })
            }

            case ValueType.OBJECT   => { 
                let JsonValue.JsonValue(x1) = x;
                let jsonobject = unchecked_cast(x1 as JJsonObject);
                JsonValueView.JsObject(JsonObject.JsonObject(jsonobject))
            }

            case ValueType.STRING   => { 
                let JsonValue.JsonValue(x1) = x;
                let jsonstring = unchecked_cast(x1 as JJsonString);
                JsonValueView.JsString(unsafe IO { jsonstring.getString() })
            }
            case ValueType.TRUE     => JsonValueView.JsTrue
        }


}
