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

    pub enum JsonNumber(##javax.json.JsonNumber)

    instance ToString[JsonNumber] {
        pub def toString(x: JsonNumber): String = Interop/Json/JsonNumber.toString(x)
    }

    instance Eq[JsonNumber] {
        pub def eq(x: JsonNumber, y: JsonNumber): Bool = Interop/Json/JsonNumber.equals(x, y)
    }
    
    instance Hash[JsonNumber] {
        pub def hash(x: JsonNumber): Int32 = Interop/Json/JsonNumber.hashCode(x)
    }

    instance Interop/Json.ImpJsonValue[JsonNumber] {
        pub def toJsonValue(x: JsonNumber): JsonValue = 
            let JsonNumber(x1) = x;
            JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

        pub def fromJsonValue(x: JsonValue): JsonNumber = 
            let JsonValue(x1) = x;
            JsonNumber(unsafe_cast x1 as ##javax.json.JsonNumber)
    }

}

namespace Interop/Json/JsonNumber {

    use Interop/Json.JsonNumber;
    use Interop/Json.JsonNumber.{JsonNumber};

    pub def toString(x: JsonNumber): String =
        import javax.json.JsonValue.toString(): String \ {};
        let JsonNumber(x1) = x;
        toString(unsafe_cast x1 as ##javax.json.JsonValue)

    pub def equals(x: JsonNumber, y: JsonNumber): Bool =
        import javax.json.JsonNumber.equals(##java.lang.Object): Bool \ {};
        let JsonNumber(x1) = x;
        let JsonNumber(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def hashCode(x: JsonNumber): Int32 =
        import javax.json.JsonNumber.hashCode(): Int32 \ {};
        let JsonNumber(x1) = x;
        hashCode(x1)


    pub def isIntegral(x: JsonNumber): Bool =
        import javax.json.JsonNumber.isIntegral(): Bool \ {};
        let JsonNumber(x1) = x;
        isIntegral(x1)

    pub def intValue(x: JsonNumber): Int32 =
        import javax.json.JsonNumber.intValue(): Int32 \ {};
        let JsonNumber(x1) = x;
        intValue(x1)

    pub def intValueExact(x: JsonNumber): Result[Int32, String] =
        import javax.json.JsonNumber.intValueExact(): Int32 \ {};
        try {
            let JsonNumber(x1) = x;
            Ok(intValueExact(x1))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def longValue(x: JsonNumber): Int64 =
        import javax.json.JsonNumber.longValue(): Int64 \ {};
        let JsonNumber(x1) = x;
        longValue(x1)

    pub def longValueExact(x: JsonNumber): Result[Int64, String] =
        import javax.json.JsonNumber.longValueExact(): Int64 \ {};
        try {
            let JsonNumber(x1) = x;
            Ok(longValueExact(x1))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }

    pub def bigIntegerValue(x: JsonNumber): BigInt =
        import javax.json.JsonNumber.bigIntegerValue(): BigInt \ {};
        let JsonNumber(x1) = x;
        bigIntegerValue(x1)

    pub def bigIntegerValueExact(x: JsonNumber): Result[BigInt, String] =
        import javax.json.JsonNumber.bigIntegerValueExact(): BigInt \ {};
        try {
            let JsonNumber(x1) = x;
            Ok(bigIntegerValueExact(x1))
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
            }
        }


    pub def doubleValue(x: JsonNumber): Float64 =
        import javax.json.JsonNumber.doubleValue(): Float64 \ {};
        let JsonNumber(x1) = x;
        doubleValue(x1)


}
