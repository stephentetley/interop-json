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

// Probably not useful...

pub mod InteropJson.JsonNumber {
    
    import jakarta.json.{JsonNumber => JJsonNumber}

    pub enum JsonNumber(JJsonNumber)

    instance ToString[JsonNumber] {
        pub def toString(x: JsonNumber): String = 
            let JsonNumber.JsonNumber(x1) = x;
            unsafe IO { x1.toString() }
    }
    
    instance Eq[JsonNumber] {
        pub def eq(x: JsonNumber, y: JsonNumber): Bool = 
            let JsonNumber.JsonNumber(x1) = x;
            let JsonNumber.JsonNumber(y1) = y;
            unsafe IO { x1.equals(y1) }
    }
    
    instance Hash[JsonNumber] {
        pub def hash(x: JsonNumber): Int32 = 
            let JsonNumber.JsonNumber(x1) = x;
            unsafe IO { x1.hashCode() }
    }

    // instance Interop/Json.ImpJsonValue[JsonNumber] {
    //     pub def toJsonValue(x: JsonNumber): JsonValue = 
    //         let JsonNumber(x1) = x;
    //         JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

    //     pub def fromJsonValue(x: JsonValue): JsonNumber = 
    //         let JsonValue(x1) = x;
    //         JsonNumber(unsafe_cast x1 as ##javax.json.JsonNumber)
    // }

    pub def isIntegral(x: JsonNumber): Bool =
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.isIntegral() }

    pub def intValue(x: JsonNumber): Int32 =
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.intValue() }

    pub def intValueExact(x: JsonNumber): Result[String, Int32] =
        Result.tryCatch(_ -> {
            let JsonNumber.JsonNumber(x1) = x;
            unsafe IO { x1.intValueExact() }
        })

    pub def longValue(x: JsonNumber): Int64 =
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.longValue() }

    pub def longValueExact(x: JsonNumber): Result[String, Int64] =
        Result.tryCatch(_ -> {
            let JsonNumber.JsonNumber(x1) = x;
            unsafe IO { x1.longValueExact() }
        })

    pub def bigIntegerValue(x: JsonNumber): BigInt =
            let JsonNumber.JsonNumber(x1) = x;
            unsafe IO { x1.bigIntegerValue() }

    pub def bigIntegerValueExact(x: JsonNumber): Result[String, BigInt] =
        Result.tryCatch(_ -> {
            let JsonNumber.JsonNumber(x1) = x;
            unsafe IO { x1.bigIntegerValueExact() }
        })


    pub def doubleValue(x: JsonNumber): Float64 =
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.doubleValue() }


}
