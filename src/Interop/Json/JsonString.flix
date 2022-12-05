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
    pub enum JsonString(##javax.json.JsonString)

    /// use getString not toString...
    instance ToString[JsonString] {
        pub def toString(x: JsonString): String = Interop/Json/JsonString.getString(x)
    }


    instance Interop/Json.ImpJsonValue[JsonString] {
        pub def toJsonValue(x: JsonString): JsonValue = 
            let JsonString(x1) = x;
            JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

        pub def fromJsonValue(x: JsonValue): JsonString = 
            let JsonValue(x1) = x;
            JsonString(unsafe_cast x1 as ##javax.json.JsonString)
    }


}

namespace Interop/Json/JsonString {

    use Interop/Json.JsonString;
    use Interop/Json.JsonString.{JsonString};


    pub def getHH(v: JsonString): ##javax.json.JsonString = 
        let JsonString(v1) = v;
        v1



    // pub def toString(x: JsonString): String =
    //     import javax.json.JsonString.toString(): String \ {};
    //     let JsonString(x1) = x;
    //     toString(x1)


    pub def equals(x: JsonString, y: JsonString): Bool =
        import javax.json.JsonString.equals(##java.lang.Object): Bool \ {};
        let JsonString(x1) = x;
        let JsonString(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def getString(x: JsonString): String =
        import javax.json.JsonString.getString(): String \ {};
        let JsonString(x1) = x;
        getString(x1)


}
