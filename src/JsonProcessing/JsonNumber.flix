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

    pub enum JsonNumber(##javax.json.JsonNumber)

    instance ToString[JsonNumber] {
        pub def toString(x: JsonNumber): String = JsonProcessing/JsonNumber.toString(x)
    }

}

namespace JsonProcessing/JsonNumber {

    use JsonProcessing.JsonNumber;
    use JsonProcessing.JsonNumber.{JsonNumber};

    pub def toString(x: JsonNumber): String =
        import javax.json.JsonValue.toString(): String & Pure;
        let JsonNumber(x1) = x;
        toString(x1 as ##javax.json.JsonValue)



}
