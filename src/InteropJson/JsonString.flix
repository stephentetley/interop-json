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


pub mod InteropJson.JsonString {

    // use InteropJson.JsonString.JsonString.{JsonString}

    import jakarta.json.{JsonString => JJsonString}

    ///
    /// Represents a JsonValue.
    /// Interface
    ///
    pub enum JsonString(JJsonString)

    /// use getString not toString...
    instance ToString[JsonString] {
        pub def toString(x: JsonString): String = 
            let JsonString.JsonString(x1) = x;
            unsafe IO { x1.getString() }
    }

    instance Eq[JsonString] {
        pub def eq(x: JsonString, y: JsonString): Bool = 
            let JsonString.JsonString(x1) = x;
            let JsonString.JsonString(y1) = y;
            unsafe IO { x1.equals(y1) }
    }

    instance Hash[JsonString] {
        pub def hash(x: JsonString): Int32 = 
            let JsonString.JsonString(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    // instance Interop/Json.ImpJsonValue[JsonString] {
    //     pub def toJsonValue(x: JsonString): JsonValue = 
    //         let JsonString(x1) = x;
    //         JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

    //     pub def fromJsonValue(x: JsonValue): JsonString = 
    //         let JsonValue(x1) = x;
    //         JsonString(unsafe_cast x1 as ##javax.json.JsonString)
    // }



    pub def getString(x: JsonString): String = 
        let JsonString.JsonString(x1) = x;
        unsafe IO { x1.getString() }


}
