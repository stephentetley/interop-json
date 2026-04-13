/*
 * Copyright 2026 Stephen Tetley
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


pub mod InteropJson.JsonNumber {
    

    use InteropJson.JsonNumber
    use InteropJson.JsonValue
    
    import jakarta.json.{JsonValue => JJsonValue}
    import jakarta.json.{Json => JJson}
    import java.lang.{Exception => JException}


    pub def equals(x: JsonNumber, y: JsonNumber): Bool =
        let JsonNumber.JsonNumber(x1) = x;
        let JsonNumber.JsonNumber(y1) = y;
        unsafe IO { x1.equals(y1) }
    


    pub def fromInt32(x: Int32): JsonNumber = 
        let x1 = unsafe IO { JJson.createValue(x) };
        JsonNumber.JsonNumber(x1)


    pub def fromInt64(x: Int64): JsonNumber = 
        let x1 = unsafe IO { JJson.createValue(x) };
        JsonNumber.JsonNumber(x1)


    pub def fromFloat64(x: Float64): JsonNumber = 
        let x1 = unsafe IO { JJson.createValue(x) };
        JsonNumber.JsonNumber(x1)


    pub def fromBigInt(x: BigInt): JsonNumber = 
        let x1 = unsafe IO { JJson.createValue(x) };
        JsonNumber.JsonNumber(x1)

    pub def fromBigDecimal(x: BigDecimal): JsonNumber = 
        let x1 = unsafe IO { JJson.createValue(x) };
        JsonNumber.JsonNumber(x1)

    pub def toJsonValue(x: JsonNumber): JsonValue =
        let JsonNumber.JsonNumber(x1) = x;
        let jsonvalue: JJsonValue = checked_cast(x1);
        JsonValue.JsonValue(jsonvalue)

    pub def isIntegral(x: JsonNumber): Bool = 
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.isIntegral() }

    pub def getInt32(x: JsonNumber): Int32 = 
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.intValue() }

    pub def getInt32Exact(x: JsonNumber): Option[Int32] = try {
        let JsonNumber.JsonNumber(x1) = x;
        Some(unsafe IO { x1.intValueExact() })
    } catch {
        case _: JException => None
    }

    pub def getInt64(x: JsonNumber): Int64 = 
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.longValue() }

    pub def getInt64Exact(x: JsonNumber): Option[Int64] = try {
        let JsonNumber.JsonNumber(x1) = x;
        Some(unsafe IO { x1.longValueExact() })
    } catch {
        case _: JException => None
    }

    pub def getFloat64(x: JsonNumber): Float64 = 
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.doubleValue() }

    pub def getBigInt(x: JsonNumber): BigInt = 
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.bigIntegerValue() }

    pub def getBigIntExact(x: JsonNumber): Option[BigInt] = try {
        let JsonNumber.JsonNumber(x1) = x;
        Some(unsafe IO { x1.bigIntegerValueExact() })
    } catch {
        case _: JException => None
    }

    pub def getBigDecimal(x: JsonNumber): BigDecimal = 
        let JsonNumber.JsonNumber(x1) = x;
        unsafe IO { x1.bigDecimalValue() }

}
