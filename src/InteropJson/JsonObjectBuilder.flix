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

    use InteropJson.JsonValue.JsonValue
    use InteropJson.JsonObject.JsonObject

    import jakarta.json.Json
    import jakarta.json.{JsonObjectBuilder => JJsonObjectBuilder}
    import java.lang.{Exception}

    ///
    /// Represents a JsonObjectBuilder.
    /// Interface / Mutable
    ///
    pub eff JsonObjectBuilder {
        def addNull(name: {name = String}): Unit
        def addBool(name: {name = String}, b: Bool): Unit
        def addInt32(name: {name = String}, i: Int32): Unit
        def addInt64(name: {name = String}, i: Int64): Unit
        def addBigInt(name: {name = String}, i: BigInt): Unit
        def addFloat64(name: {name = String}, d: Float64): Unit
        def addBigDecimal(name: {name = String}, i: BigDecimal): Unit
        def addString(name: {name = String}, s: String): Unit
        def addJsonValue(name: {name = String}, v: JsonValue): Unit
    }

    // TODO - Flix compiler is optimizing away unsafe IO calls without them being run...

    def handle(builder: JJsonObjectBuilder, f: a -> b \ ef): a -> Result[String, b] \ (ef - JsonObjectBuilder + IO) =
        x -> {
            run {
                Ok(f(x))
            } with handler JsonObjectBuilder {
                
                def addNull(name, k) = {
                    let _ = builder.addNull(name#name);
                    k()
                }
                
                def addBool(name, value, k) = {
                    let _ = unsafe IO { builder.add(name#name, value) };
                    k()
                }

                def addInt32(name, value, k) = {
                    let _ = builder.add(name#name, value);
                    k()
                }

                def addInt64(name, value, k) = {
                    let _ = unsafe IO { builder.add(name#name, value) };
                    k()
                }

                def addBigInt(name, value, k) = {
                    discard unsafe IO { builder.add(name#name, value) };
                    k()
                }

                def addFloat64(name, value, k) = {
                    discard unsafe IO { builder.add(name#name, value) };
                    k()
                }

                def addInt64(name, value, k) = {
                    let _ = unsafe IO { builder.add(name#name, value) };
                    k()
                }

                def addBigDecimal(name, value, k) = {
                    let _ = unsafe IO { builder.add(name#name, value) };
                    k()
                }

                def addString(name, value, k) = {
                    let _ = builder.add(name#name, value);
                    k()
                }

                def addJsonValue(name, value, k) = {
                    let JsonValue.JsonValue(value1) = value;
                    let _ = unsafe IO { builder.add(name#name, value1) };
                    k()
                }

            }
        }

    // pub def build(bld: JsonObjectBuilder[r]): JsonObject \ Read(r) =
    //     import javax.json.JsonObjectBuilder.build(): ##javax.json.JsonObject \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     build(bld1) |> JsonObject



        
    // pub def addJsonValue!(name: String, value: t, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) with ImpJsonValue[t] =
    //     import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonValue): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
    //     add(bld1, name, value1) |> JsonObjectBuilder 
        





    // pub def addJsonArrayBuilder!(name: String, value: {value = JsonArrayBuilder[r]}, bld: JsonObjectBuilder[r]): Result[JsonObjectBuilder[r], String] \ Write(r) =
    //     try {
    //         import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonArrayBuilder): ##javax.json.JsonObjectBuilder \ r;
    //         let JsonObjectBuilder(bld1) = bld;
    //         let JsonArrayBuilder(value1) = value.value;
    //         add(bld1, name, value1) |> JsonObjectBuilder |> Ok
    //     } catch {
    //         case ex: ##java.lang.Exception =>
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             Err(getMessage(ex))
    //     }

    // pub def addJsonObjectBuilder!(name: String, value: {value = JsonObjectBuilder[r]}, bld: JsonObjectBuilder[r]): Result[JsonObjectBuilder[r], String] \ Write(r) =
    //     try {
    //         import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonObjectBuilder): ##javax.json.JsonObjectBuilder \ r;
    //         let JsonObjectBuilder(bld1) = bld;
    //         let JsonObjectBuilder(value1) = value.value;
    //         add(bld1, name, value1) |> JsonObjectBuilder |> Ok
    //     } catch {
    //         case ex: ##java.lang.Exception =>
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             Err(getMessage(ex))
    //     }

    pub def runJsonObjectBuilder(f: Unit -> a \ ef): Result[String, (JsonObject, a)] \ (ef - JsonObjectBuilder + IO) = 
        let builder = unsafe IO { Json.createObjectBuilder() };
        match handle(builder, f)() {
            case Err(s) => Err(s)
            case Ok(a)  => {
                let jso = unsafe IO { builder.build() };
                Ok((JsonObject.JsonObject(jso), a))
            }
        }
        

        
    pub def evalJsonObjectBuilder(f: Unit -> a \ ef): Result[String, JsonObject] \ (ef - JsonObjectBuilder + IO) = 
        runJsonObjectBuilder(f) |> Result.map(fst)

    pub def temp01(): JsonObject \ IO = 
        let builder = Json.createObjectBuilder();
        builder.add("five", 5);
        builder.add("twelve", 12);
        JsonObject.JsonObject(builder.build())


}
