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


pub mod InteropJson.JsonObjectBuilder {

    use InteropJson.JsonValue.JsonObject
    use InteropJson.JsonArrayBuilder.JsonArrayBuilderHandle
    use InteropJson.JsonValue.JsonValue

    import jakarta.json.Json
    import jakarta.json.{JsonObjectBuilder => JJsonObjectBuilder}
    import java.lang.{Exception}

    ///
    /// A handle to reify a JsonObjectBuilder.
    ///
    pub enum JsonObjectBuilderHandle(JJsonObjectBuilder)


    ///
    /// Represents a JsonObjectBuilder
    ///
    pub eff BuildJsonObject {
        def addNull(name: {name = String}): Unit
        def addBool(name: {name = String}, b: Bool): Unit
        def addInt32(name: {name = String}, i: Int32): Unit
        def addInt64(name: {name = String}, i: Int64): Unit
        def addBigInt(name: {name = String}, i: BigInt): Unit
        def addFloat64(name: {name = String}, d: Float64): Unit
        def addBigDecimal(name: {name = String}, i: BigDecimal): Unit
        def addString(name: {name = String}, s: String): Unit
        def addJsonValue(name: {name = String}, v: JsonValue): Unit
        def addJsonArrayBuilder(name: {name = String}, b: JsonArrayBuilderHandle): Unit
        def addJsonObjectBuilder(name: {name = String}, b: JsonObjectBuilderHandle): Unit
        def addAll(b: JsonObjectBuilderHandle): Unit
        def remove(name: {name = String}): Unit
    }

    // Can't have a default handler because we have extra input and output requirements
    // Use a region to stop the Flix compiler eliminating Java calls that are called for their side effect


    pub def handle(_: Region[r], builder: JsonObjectBuilderHandle, f: a -> b \ ef): a -> Result[String, b] \ (ef - BuildJsonObject + r) = x -> {
        let JsonObjectBuilderHandle.JsonObjectBuilderHandle(builder1) = builder;
        run {
            Ok(f(x))
        } with handler BuildJsonObject {

            def addNull(name, k) = {
                unchecked_cast(discard builder1.addNull(name#name) as _ \ r);
                k()
            }

            def addBool(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addInt32(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addInt64(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addBigInt(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addFloat64(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addInt64(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addBigDecimal(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addString(name, value, k) = {
                unchecked_cast(discard builder1.add(name#name, value) as _ \ r);
                k()
            }

            def addJsonValue(name, value, k) = {
                let JsonValue.JsonValue(value1) = value;
                unchecked_cast(discard builder1.add(name#name, value1) as _ \ r);
                k()
            }

            def addJsonArrayBuilder(name, value, k) = {
                let JsonArrayBuilderHandle.JsonArrayBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.add(name#name, value1) as _ \ r);
                k()
            }

            def addJsonObjectBuilder(name, value, k) = {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.add(name#name, value1) as _ \ r);
                k()
            }

            def addAll(value, k) = {
                let JsonObjectBuilderHandle.JsonObjectBuilderHandle(value1) = value;
                unchecked_cast(discard builder1.addAll(value1) as _ \ r);
                k()
            }

            def remove(name, k) = try {
                unchecked_cast(discard builder1.remove(name#name) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }
        }
    }


    pub def reifyBuilderHandle(_: Region[r], bld: JsonObjectBuilderHandle): JsonObject \ r =
        let JsonObjectBuilderHandle.JsonObjectBuilderHandle(bld1) = bld;
        JsonObject.JsonObject(unchecked_cast(bld1.build() as _ \ r))

    pub def createJsonObjectBuilderHandle(_: Region[r]): JsonObjectBuilderHandle \ r =
        JsonObjectBuilderHandle.JsonObjectBuilderHandle(unchecked_cast(Json.createObjectBuilder() as _ \ r))


    pub def reifyBuildJsonObject(rc: Region[r], f: Unit -> a \ ef): Result[String, JsonObjectBuilderHandle] \ (ef - BuildJsonObject + r) =
        let builder = createJsonObjectBuilderHandle(rc);
        handle(rc, builder, f)() |> Result.map(_ -> builder)

    pub def runBuildJsonObject(rc: Region[r], f: Unit -> a \ ef): Result[String, (JsonObject, a)] \ (ef - BuildJsonObject + r) =
        let builder = createJsonObjectBuilderHandle(rc);
        handle(rc, builder, f)() |> Result.map(x -> (reifyBuilderHandle(rc, builder), x))

        
    pub def evalBuildJsonObject(rc: Region[r], f: Unit -> a \ ef): Result[String, JsonObject] \ (ef - BuildJsonObject + r) =
        runBuildJsonObject(rc, f) |> Result.map(fst)



}
