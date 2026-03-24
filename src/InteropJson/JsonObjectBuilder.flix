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
    }

    pub enum JsonObjectBuilderHandle(JJsonObjectBuilder)

    pub def handle(objb: JsonObjectBuilderHandle, f: a -> b \ ef): a -> Result[String, b] \ (ef - JsonObjectBuilder) =
        x -> {
            let JsonObjectBuilderHandle.JsonObjectBuilderHandle(jobjb) = objb;
            run {
                Ok(f(x))
            } with handler JsonObjectBuilder {
                
                def addNull(name, k) = {
                    let _ = unsafe IO { jobjb.addNull(name#name) };
                    k()
                }
                
                def addBool(name, value, k) = {
                    let _ = unsafe IO { jobjb.add(name#name, value) };
                    k()
                }

                def addInt32(name, value, k) = {
                    let _ = unsafe IO { jobjb.add(name#name, value) };
                    k()
                }

                def addInt64(name, value, k) = {
                    let _ = unsafe IO { jobjb.add(name#name, value) };
                    k()
                }

                def addBigInt(name, value, k) = {
                    let _ = unsafe IO { jobjb.add(name#name, value) };
                    k()
                }

                def addFloat64(name, value, k) = {
                    let _ = unsafe IO { jobjb.add(name#name, value) };
                    k()
                }

                def addInt64(name, value, k) = {
                    let _ = unsafe IO { jobjb.add(name#name, value) };
                    k()
                }

                def addBigDecimal(name, value, k) = {
                    let _ = unsafe IO { jobjb.add(name#name, value) };
                    k()
                }

            }
        }

    // pub def build(bld: JsonObjectBuilder[r]): JsonObject \ Read(r) =
    //     import javax.json.JsonObjectBuilder.build(): ##javax.json.JsonObject \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     build(bld1) |> JsonObject


    // /// Note - the Java exception `addNull` thrown should be "unreachable" in Flix.
    // pub def addNull!(name: String, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.addNull(String): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     addNull(bld1, name) |> JsonObjectBuilder 

        
    // pub def addJsonValue!(name: String, value: t, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) with ImpJsonValue[t] =
    //     import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonValue): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
    //     add(bld1, name, value1) |> JsonObjectBuilder 
        

    // pub def addBool!(name: String, value: Bool, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, Bool): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     add(bld1, name, value) |> JsonObjectBuilder

    // pub def addBigInt!(name: String, value: BigInt, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, BigInt): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     add(bld1, name, value) |> JsonObjectBuilder


    // pub def addFloat64!(name: String, value: Float64, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, Float64): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     add(bld1, name, value) |> JsonObjectBuilder

    // pub def addInt32!(name: String, value: Int32, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, Int32): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     add(bld1, name, value) |> JsonObjectBuilder


    // pub def addString!(name: String, value: String, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, String): ##javax.json.JsonObjectBuilder \ r;
    //     let JsonObjectBuilder(bld1) = bld;
    //     add(bld1, name, value) |> JsonObjectBuilder



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

        
}
