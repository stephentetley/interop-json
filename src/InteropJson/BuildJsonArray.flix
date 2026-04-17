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


    // `addAll` has different type to Java version but is equally
    // expressve

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
        def addAll(v: JsonArray): Unit
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

    pub def handle(o: Option[JsonArray], f: a -> b \ ef): a -> Result[String, (JsonArray, b)] \ (ef - BuildJsonArray) = x -> 
        region rc { 
            let jbuilder: JJsonArrayBuilder = match  o {
                case Some(a) => {
                    let JsonArray.JsonArray(jarr)= a;
                    unsafe IO { JJson.createArrayBuilder(jarr) }
                }
                case None => unsafe IO { JJson.createArrayBuilder() }
            };
            handleHelper(rc, jbuilder, f, x) 
        }

    def handleHelper(_: Region[r], jbuilder: JJsonArrayBuilder, f: a -> b \ ef): a -> Result[String, (JsonArray, b)] \ (ef - BuildJsonArray + r) = x -> {        
        let ans = run {
            Ok(f(x))
        } with handler BuildJsonArray {

            def addNull(k) = {
                unsafe IO as r { discard jbuilder.addNull() };
                k()
            }

            def addNullAt(ix, k) =  try {
                unsafe IO as r { discard jbuilder.addNull(ix#index) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBool(value, k) = {
                unsafe IO as r { discard jbuilder.add(value) };
                k()
            }

            def addBoolAt(ix, value, k) =  try {
                unsafe IO as r { discard jbuilder.add(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addInt32(value, k) = {
                unsafe IO as r { discard jbuilder.add(value) };
                k()
            }

            def addInt32At(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.add(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBigInt(value, k) = {
                unsafe IO as r { discard jbuilder.add(value) };
                k()
            }

            def addBigIntAt(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.add(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addFloat64(value, k) = {
                unsafe IO as r { discard jbuilder.add(value) };
                k()
            }

            def addFloat64At(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.add(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBigDecimal(value, k) = {
                unsafe IO as r { discard jbuilder.add(value) };
                k()
            }

            def addBigDecimalAt(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.add(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addString(value, k) = {
                unsafe IO as r { discard jbuilder.add(value) };
                k()
            }

            def addStringAt(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.add(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addJsonValue(value, k) = {
                let JsonValue.JsonValue(value1) = value;
                unsafe IO as r { discard jbuilder.add(value1) };
                k()
            }

            def addJsonValueAt(ix, value, k) = try {
                let JsonValue.JsonValue(value1) = value;
                unsafe IO as r { discard jbuilder.add(ix#index, value1) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }


            def addNestedJsonValue(rvalue, k) = match rvalue {
                case Err(msg)   => Err(msg)
                case Ok(value)  => {
                    let JsonValue.JsonValue(value1) = value;
                    unsafe IO as r { discard jbuilder.add(value1) };
                    k()
                } 
            }

            def addNestedJsonValueAt(ix, rvalue, k) = match rvalue {
                case Err(msg)   => Err(msg)
                case Ok(value)  => try {
                    let JsonValue.JsonValue(value1) = value;
                    unsafe IO as r { discard jbuilder.add(ix#index, value1) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }
            }
                        
            def addAll(arr, k) = try {
                let JsonArray.JsonArray(arr1) = arr;
                let b1: JJsonArrayBuilder = unsafe IO as r { JJson.createArrayBuilder(arr1) };
                unsafe IO as r { discard jbuilder.addAll(b1) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def remove(ix, k) = try {
                unsafe IO as r { discard jbuilder.remove(ix#index) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setNull(ix, k) = try {
                unsafe IO as r { discard jbuilder.setNull(ix#index) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBool(ix, value, k) =  try {
                unsafe IO as r { discard jbuilder.set(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setInt32(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.set(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBigInt(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.set(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setFloat64(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.set(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBigDecimal(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.set(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setString(ix, value, k) = try {
                unsafe IO as r { discard jbuilder.set(ix#index, value) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setJsonValue(ix, value, k) = try {
                let JsonValue.JsonValue(value1) = value;
                unsafe IO as r { discard jbuilder.set(ix#index, value1) };
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }
        };
        match ans { 
            case Err(msg) => Err(msg)
            case Ok(ans1) => {
                let jsarr: JJsonArray = unsafe IO as r { jbuilder.build() };
                Ok((JsonArray.JsonArray(jsarr), ans1))
            }
        }
    }




    pub def runBuildJsonArray(o: Option[JsonArray], f: Unit -> a \ ef): Result[String, (JsonArray, a)] \ (ef - BuildJsonArray) =
        handle(o, f)()
        
    pub def evalBuildJsonArray(o: Option[JsonArray], f: Unit -> a \ ef): Result[String, JsonArray] \ (ef - BuildJsonArray) =
        runBuildJsonArray(o, f) |> Result.map(fst)

    pub def evalBuildJsonValue(o: Option[JsonArray], f: Unit -> a \ ef): Result[String, JsonValue] \ (ef - BuildJsonArray) =
        evalBuildJsonArray(o, f) |> Result.map(ToJsonValue.toJsonValue)

    // On failure generates a Json object with a single field "error" : msg
    pub def evalToJsonValue(o: Option[JsonArray], f: Unit -> a \ ef): JsonValue \ (ef - BuildJsonArray) =
        match evalBuildJsonValue(o, f) {
            case Ok(v)    => v
            case Err(msg) => InteropJson.JsonObject.singleton("error", msg) |> ToJsonValue.toJsonValue
        }

}

