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




pub mod InteropJson.JsonArrayBuilder {


    use InteropJson.JsonArray
    use InteropJson.JsonValue
    use InteropJson.JsonObjectBuilder.JsonObjectBuilderHandle
    

    import jakarta.json.Json
    import jakarta.json.{JsonArrayBuilder => JJsonArrayBuilder}
    import java.lang.{Exception}

    ///
    /// A handle to reify a JsonArrayBuilder.
    ///
    pub enum JsonArrayBuilderHandle(JJsonArrayBuilder)

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
        def addAll(b: JsonArrayBuilderHandle): Unit
        def addJsonArrayBuilder(b: JsonArrayBuilderHandle): Unit
        def addJsonArrayBuilderAt(index: {index = Int32}, b: JsonArrayBuilderHandle): Unit
        def addJsonObjectBuilder(b: JsonObjectBuilderHandle): Unit
        def addJsonObjectBuilderAt(index: {index = Int32}, b: JsonObjectBuilderHandle): Unit
        def remove(index: {index = Int32}): Unit
        def setNull(index: {index = Int32}): Unit
        def setBool(index: {index = Int32}, b: Bool): Unit
        def setInt32(index: {index = Int32}, i: Int32): Unit
        def setBigInt(index: {index = Int32}, i: BigInt): Unit
        def setFloat64(index: {index = Int32}, d: Float64): Unit
        def setBigDecimal(index: {index = Int32}, d: BigDecimal): Unit
        def setString(index: {index = Int32}, s: String): Unit
        def setJsonValue(index: {index = Int32}, v: JsonValue): Unit
        def setJsonArrayBuilder(index: {index = Int32}, b: JsonArrayBuilderHandle): Unit
        def setJsonObjectBuilder(index: {index = Int32}, b: JsonObjectBuilderHandle): Unit
    }

    // Can't have a default handler because we have extra input and output requirements

    pub def handle(_: Region[r], builder: JsonArrayBuilderHandle, f: a -> b \ ef): a -> Result[String, b] \ (ef - BuildJsonArray + r) = x -> {
        let JsonArrayBuilderHandle.JsonArrayBuilderHandle(builder1) = builder;
        run {
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

            def addAll(value, k) = {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.addAll(value1) as _ \ r);
                k()
            }

            def addJsonArrayBuilder(value, k) = {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.add(value1) as _ \ r);
                k()
            }

            def addJsonArrayBuilderAt(ix, value, k) = try {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.add(ix#index, value1) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addJsonObjectBuilder(value, k) = {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.add(value1) as _ \ r);
                k()
            }

            def addJsonObjectBuilderAt(ix, value, k) = try {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.add(ix#index, value1) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
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

            def setJsonArrayBuilder(ix, value, k) = try {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.set(ix#index, value1) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setJsonObjectBuilder(ix, value, k) = try {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.set(ix#index, value1) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

        }
    }


    pub def reifyBuilderHandle(_: Region[r], bld: JsonArrayBuilderHandle): JsonArray \ r =
        let JsonArrayBuilderHandle.JsonArrayBuilderHandle(bld1) = bld;
        JsonArray.JsonArray(unchecked_cast(bld1.build() as _ \ r))

    pub def createJsonArrayBuilderHandle(_: Region[r]): JsonArrayBuilderHandle \ r =
        JsonArrayBuilderHandle.JsonArrayBuilderHandle(unchecked_cast(Json.createArrayBuilder() as _ \ r))


    pub def reifyBuildJsonArray(rc: Region[r], f: Unit -> a \ ef): Result[String, JsonArrayBuilderHandle] \ (ef - BuildJsonArray + r) =
        let builder = createJsonArrayBuilderHandle(rc);
        handle(rc, builder, f)() |> Result.map(_ -> builder)

    pub def runBuildJsonArray(rc: Region[r], f: Unit -> a \ ef): Result[String, (JsonArray, a)] \ (ef - BuildJsonArray + r) =
        let builder = createJsonArrayBuilderHandle(rc);
        handle(rc, builder, f)() |> Result.map(x -> (reifyBuilderHandle(rc, builder), x))
        
    pub def evalBuildJsonArray(rc: Region[r], f: Unit -> a \ ef): Result[String, JsonArray] \ (ef - BuildJsonArray + r) =
        runBuildJsonArray(rc, f) |> Result.map(fst)

}
