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


    use InteropJson.JsonArray.JsonArray
    use InteropJson.JsonObjectBuilder.JsonObjectBuilderHandle
    use InteropJson.JsonValue.JsonValue

    import jakarta.json.Json
    import jakarta.json.{JsonArrayBuilder => JJsonArrayBuilder}
    import java.lang.{Exception}

    ///
    /// A handle to reify a JsonArrayBuilder.
    ///
    pub enum JsonArrayBuilderHandle(JJsonArrayBuilder)

    pub eff JsonArrayBuilder {
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

    pub def handleWithInstantiatedBuilder(builder: JsonArrayBuilderHandle, f: a -> b \ ef): a -> Result[String, b] \ (ef - JsonArrayBuilder + IO) = x -> {
        let JsonArrayBuilderHandle.JsonArrayBuilderHandle(builder1) = builder;
        run {
            Ok(f(x))
        } with handler JsonArrayBuilder {

            def addNull(k) = {
                discard builder1.addNull();
                k()
            }

            def addNullAt(ix, k) =  try {
                discard builder1.addNull(ix#index);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBool(value, k) = {
                discard builder1.add(value);
                k()
            }

            def addBoolAt(ix, value, k) =  try {
                discard builder1.add(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addInt32(value, k) = {
                discard builder1.add(value);
                k()
            }

            def addInt32At(ix, value, k) = try {
                discard builder1.add(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBigInt(value, k) = {
                discard builder1.add(value);
                k()
            }

            def addBigIntAt(ix, value, k) = try {
                discard builder1.add(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addFloat64(value, k) = {
                discard builder1.add(value);
                k()
            }

            def addFloat64At(ix, value, k) = try {
                discard builder1.add(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addBigDecimal(value, k) = {
                discard builder1.add(value);
                k()
            }

            def addBigDecimalAt(ix, value, k) = try {
                discard builder1.add(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addString(value, k) = {
                discard builder1.add(value);
                k()
            }

            def addStringAt(ix, value, k) = try {
                discard builder1.add(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addJsonValue(value, k) = {
                let JsonValue.JsonValue(value1) = value;
                discard builder1.add(value1);
                k()
            }

            def addJsonValueAt(ix, value, k) = try {
                let JsonValue.JsonValue(value1) = value;
                discard builder1.add(ix#index, value1);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addAll(value, k) = {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                discard builder1.addAll(value1);
                k()
            }

            def addJsonArrayBuilder(value, k) = {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                discard builder1.add(value1);
                k()
            }

            def addJsonArrayBuilderAt(ix, value, k) = try {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                discard builder1.add(ix#index, value1);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addJsonObjectBuilder(value, k) = {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                discard builder1.add(value1);
                k()
            }

            def addJsonObjectBuilderAt(ix, value, k) = try {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                discard builder1.add(ix#index, value1);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def remove(ix, k) = try {
                discard builder1.remove(ix#index);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setNull(ix, k) = try {
                discard builder1.setNull(ix#index);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBool(ix, value, k) =  try {
                discard builder1.set(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setInt32(ix, value, k) = try {
                discard builder1.set(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBigInt(ix, value, k) = try {
                discard builder1.set(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setFloat64(ix, value, k) = try {
                discard builder1.set(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setBigDecimal(ix, value, k) = try {
                discard builder1.set(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setString(ix, value, k) = try {
                discard builder1.set(ix#index, value);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setJsonValue(ix, value, k) = try {
                let JsonValue.JsonValue(value1) = value;
                discard builder1.set(ix#index, value1);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setJsonArrayBuilder(ix, value, k) = try {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                discard builder1.set(ix#index, value1);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def setJsonObjectBuilder(ix, value, k) = try {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                discard builder1.set(ix#index, value1);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

        }
    }


    pub def reifyBuilderHandle(bld: JsonArrayBuilderHandle): JsonArray \ IO =
        let JsonArrayBuilderHandle.JsonArrayBuilderHandle(bld1) = bld;
        JsonArray.JsonArray(bld1.build())

    pub def createJsonArrayBuilderHandle(): JsonArrayBuilderHandle \ IO =
        JsonArrayBuilderHandle.JsonArrayBuilderHandle(Json.createArrayBuilder())


    pub def reifyJsonArrayBuilder(f: Unit -> a \ ef): Result[String, JsonArrayBuilderHandle] \ (ef - JsonArrayBuilder + IO) =
        let builder = createJsonArrayBuilderHandle();
        handleWithInstantiatedBuilder(builder, f)() |> Result.map(_ -> builder)

    pub def runJsonArrayBuilder(f: Unit -> a \ ef): Result[String, (JsonArray, a)] \ (ef - JsonArrayBuilder + IO) = 
        let builder = createJsonArrayBuilderHandle();
        handleWithInstantiatedBuilder(builder, f)() |> Result.map(x -> (reifyBuilderHandle(builder), x))
        
    pub def evalJsonArrayBuilder(f: Unit -> a \ ef): Result[String, JsonArray] \ (ef - JsonArrayBuilder + IO) = 
        runJsonArrayBuilder(f) |> Result.map(fst)

}
