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

        
    /// pub def getValueType(x: JsonValue): ValueType =
    ///     import javax.json.JsonValue.getValueType(): ##javax.json.JsonValue$ValueType & Pure;
    ///     let JsonValue(x1) = x;
    ///     getValueType(x1) |> unmarshal

    /// pub def jsonFalse(): JsonValue = 
    ///     import static get javax.json.JsonValue.FALSE: ##javax.json.JsonValue & Pure as get_FALSE;
    ///     JsonValue(get_FALSE())

    /// pub def jsonTrue(): JsonValue = 
    ///     import static get javax.json.JsonValue.TRUE: ##javax.json.JsonValue & Pure as get_TRUE;
    ///     JsonValue(get_TRUE())
    
    /// pub def jsonNull(): JsonValue = 
    ///     import static get javax.json.JsonValue.NULL: ##javax.json.JsonValue & Pure as get_NULL;
    ///     JsonValue(get_NULL())

}
