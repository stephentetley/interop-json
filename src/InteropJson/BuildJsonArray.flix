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




pub mod InteropJson.BuildJsonArray {


    use InteropJson.JsonArray
    use InteropJson.JsonObject
    use InteropJson.JsonValue
    use InteropJson.ToJsonValue
    

    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonArrayBuilder => JJsonArrayBuilder}
    import jakarta.json.{JsonArray => JJsonArray}
    import java.lang.{Exception}



    pub eff BuildJsonArray {
        def addNull(): Unit
        def addNullAt(index: {index = Int32}): Unit
        def addBool(b: Bool): Unit
        def addBoolAt(index: {index = Int32}, b: Bool): Unit
        def addInt32(i: Int32): Unit
        def addInt32At(index: {index = Int32}, i: Int32): Unit
        def addBigInt(i: BigInt): Unit
        def addBigIntAt(index: {index = Int32}, i: BigInt): Unit
        def addFloat64(d: Float64): Unit
        def addFloat64At(index: {index = Int32}, d: Float64): Unit
        def addBigDecimal(d: BigDecimal): Unit
        def addBigDecimalAt(index: {index = Int32}, d: BigDecimal): Unit
        def addString(s: String): Unit
        def addStringAt(index: {index = Int32}, s: String): Unit
        def addJsonValue(v: JsonValue): Unit
        def addJsonValueAt(index: {index = Int32}, v: JsonValue): Unit
        def addNestedJsonValue(v: Result[String, JsonValue]): Unit
        def addNestedJsonValueAt(index: {index = Int32}, v: Result[String, JsonValue]): Unit
        def remove(index: {index = Int32}): Unit
        def setNull(index: {index = Int32}): Unit
        def setBool(index: {index = Int32}, b: Bool): Unit
        def setInt32(index: {index = Int32}, i: Int32): Unit
        def setBigInt(index: {index = Int32}, i: BigInt): Unit
        def setFloat64(index: {index = Int32}, d: Float64): Unit
        def setBigDecimal(index: {index = Int32}, d: BigDecimal): Unit
        def setString(index: {index = Int32}, s: String): Unit
        def setJsonValue(index: {index = Int32}, v: JsonValue): Unit
    }


    // polymorphic type - cannot go in effect (??)
    pub def add(value: t): Unit \ BuildJsonArray with ToJsonValue[t] = 
        BuildJsonArray.addJsonValue(ToJsonValue.toJsonValue(value))

    // polymorphic type - cannot go in effect (??)
    pub def addAt(index: {index = Int32}, value: t): Unit \ BuildJsonArray with ToJsonValue[t] = 
        BuildJsonArray.addJsonValueAt(index, ToJsonValue.toJsonValue(value))


    // Can't have a default handler because we have extra input and output requirements

    pub def handle(f: a -> b \ ef): a -> Result[String, (JsonArray, b)] \ (ef - BuildJsonArray) = x -> 
        region rc { handleHelper(rc, f, x) }

    def handleHelper(_: Region[r], f: a -> b \ ef): a -> Result[String, (JsonArray, b)] \ (ef - BuildJsonArray + r) = x -> {
        let builder1: JJsonArrayBuilder = unchecked_cast(JJson.createArrayBuilder() as _ \ r);
        let ans = run {
            Ok(f(x))
        } with handler BuildJsonArray {

            def addNull(k) = {
                unchecked_cast(discard builder1.addNull() as _ \ r);
                k()
            }

            def addNullAt(ix, k) =  try {
                unchecked_cast(discard builder1.addNull(ix#index) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBool(value, k) = {
                unchecked_cast(discard builder1.add(value) as _ \ r);
                k()
            }

            def addBoolAt(ix, value, k) =  try {
                unchecked_cast(discard builder1.add(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addInt32(value, k) = {
                unchecked_cast(discard builder1.add(value) as _ \ r);
                k()
            }

            def addInt32At(ix, value, k) = try {
                unchecked_cast(discard builder1.add(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBigInt(value, k) = {
                unchecked_cast(discard builder1.add(value) as _ \ r);
                k()
            }

            def addBigIntAt(ix, value, k) = try {
                unchecked_cast(discard builder1.add(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addFloat64(value, k) = {
                unchecked_cast(discard builder1.add(value) as _ \ r);
                k()
            }

            def addFloat64At(ix, value, k) = try {
                unchecked_cast(discard builder1.add(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBigDecimal(value, k) = {
                unchecked_cast(discard builder1.add(value) as _ \ r);
                k()
            }

            def addBigDecimalAt(ix, value, k) = try {
                unchecked_cast(discard builder1.add(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addString(value, k) = {
                unchecked_cast(discard builder1.add(value) as _ \ r);
                k()
            }

            def addStringAt(ix, value, k) = try {
                unchecked_cast(discard builder1.add(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addJsonValue(value, k) = {
                let JsonValue.JsonValue(value1) = value;
                unchecked_cast(discard builder1.add(value1) as _ \ r);
                k()
            }

            def addJsonValueAt(ix, value, k) = try {
                let JsonValue.JsonValue(value1) = value;
                unchecked_cast(discard builder1.add(ix#index, value1) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }


            def addNestedJsonValue(rvalue, k) = match rvalue {
                case Err(msg)   => Err(msg)
                case Ok(value)  => {
                    let JsonValue.JsonValue(value1) = value;
                    unchecked_cast(discard builder1.add(value1) as _ \ r);
                    k()
                } 
            }

            def addNestedJsonValueAt(ix, rvalue, k) = match rvalue {
                case Err(msg)   => Err(msg)
                case Ok(value)  => try {
                    let JsonValue.JsonValue(value1) = value;
                    unchecked_cast(discard builder1.add(ix#index, value1) as _ \ r);
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }
            }
            def remove(ix, k) = try {
                unchecked_cast(discard builder1.remove(ix#index) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setNull(ix, k) = try {
                unchecked_cast(discard builder1.setNull(ix#index) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBool(ix, value, k) =  try {
                unchecked_cast(discard builder1.set(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setInt32(ix, value, k) = try {
                unchecked_cast(discard builder1.set(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBigInt(ix, value, k) = try {
                unchecked_cast(discard builder1.set(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setFloat64(ix, value, k) = try {
                unchecked_cast(discard builder1.set(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBigDecimal(ix, value, k) = try {
                unchecked_cast(discard builder1.set(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setString(ix, value, k) = try {
                unchecked_cast(discard builder1.set(ix#index, value) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setJsonValue(ix, value, k) = try {
                let JsonValue.JsonValue(value1) = value;
                unchecked_cast(discard builder1.set(ix#index, value1) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }
        };
        match ans { 
            case Err(msg) => Err(msg)
            case Ok(ans1) => {
                let jsarr: JJsonArray = unchecked_cast(builder1.build() as _ \ r);
                Ok((JsonArray.JsonArray(jsarr), ans1))
            }
        }
    }




    pub def runBuildJsonArray(f: Unit -> a \ ef): Result[String, (JsonArray, a)] \ (ef - BuildJsonArray) =
        handle(f)()
        
    pub def evalBuildJsonArray(f: Unit -> a \ ef): Result[String, JsonArray] \ (ef - BuildJsonArray) =
        runBuildJsonArray(f) |> Result.map(fst)

    pub def evalBuildJsonValue(f: Unit -> a \ ef): Result[String, JsonValue] \ (ef - BuildJsonArray) =
        evalBuildJsonArray(f) |> Result.map(ToJsonValue.toJsonValue)

    // On failure generates a Json object with a single field "error" : msg
    pub def evalToJsonValueA(f: Unit -> a \ ef): JsonValue \ (ef - BuildJsonArray) =
        match evalBuildJsonValue(f) {
            case Ok(v)    => v
            case Err(msg) => InteropJson.JsonValue.jsonObjectSingleton("error", InteropJson.JsonValue.jsonString(msg))
        }
}
