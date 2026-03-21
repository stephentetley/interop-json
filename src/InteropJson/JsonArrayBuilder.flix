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


// namespace Interop/Json {


//     ///
//     /// Represents a JsonArrayBuilder.
//     /// Interface / Mutable
//     ///
//     pub enum JsonArrayBuilder[_: Region](##javax.json.JsonArrayBuilder)


//     instance Scoped[JsonArrayBuilder] {
//         pub def regionOf(_: JsonArrayBuilder[r]): Region[r] = unsafe_cast () as Region[r]
//     }

// }

pub mod InteropJson.JsonArrayBuilder {

    import jakarta.json.{JsonArrayBuilder => JJsonArrayBuilder}
    import java.lang.{Exception}

    pub eff JsonArrayBuilder {
        def addNull(): Unit
        def addNullAt(ix: Int32): Unit
        def addBool(b: Bool): Unit
        def addBoolAt(ix: Int32, b: Bool): Unit
        def addInt32(i: Int32): Unit
        def addBigInt(i: BigInt): Unit
        def addFloat64(d: Float64): Unit
    }

    pub enum JsonArrayBuilderHandle (JJsonArrayBuilder)

    pub def handle(arrb: JsonArrayBuilderHandle, f: a -> b \ ef): a -> Result[String, b] \ (ef - JsonArrayBuilder) =
        x -> {
            let JsonArrayBuilderHandle.JsonArrayBuilderHandle(jarrb) = arrb;
            run {
                Ok(f(x))
            } with handler JsonArrayBuilder {
                
                def addNull(k) = {
                    let _ = unsafe IO { jarrb.addNull() };
                    k()
                }
                
                def addNullAt(ix, k) =  try {
                    let _ = unsafe IO { jarrb.addNull(ix) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addBool(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addBoolAt(ix, value, k) =  try {
                    let _ = unsafe IO { jarrb.add(ix, value) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addInt32(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addBigInt(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addFloat64(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }
            }
        }


    // pub def build(bld: JsonArrayBuilder[r]): JsonArray \ Read(r) =
    //     import javax.json.JsonArrayBuilder.build(): ##javax.json.JsonArray \ r;
    //     let JsonArrayBuilder(bld1) = bld;
    //     build(bld1) |> JsonArray




    // pub def addFloat64!(value: Float64, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
    //     import javax.json.JsonArrayBuilder.add(Float64): ##javax.json.JsonArrayBuilder \ r;
    //     let JsonArrayBuilder(bld1) = bld;
    //     add(bld1, value) |> JsonArrayBuilder 

    // pub def addInt32!(value: Int32, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
    //     import javax.json.JsonArrayBuilder.add(Int32): ##javax.json.JsonArrayBuilder \ r;
    //     let JsonArrayBuilder(bld1) = bld;
    //     add(bld1, value) |> JsonArrayBuilder 


    // pub def addString!(value: String, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
    //     import javax.json.JsonArrayBuilder.add(String): ##javax.json.JsonArrayBuilder \ r;
    //     let JsonArrayBuilder(bld1) = bld;
    //     add(bld1, value) |> JsonArrayBuilder 

    // pub def addJsonValue!(value: t, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) with ImpJsonValue[t] =
    //     import javax.json.JsonArrayBuilder.add(##javax.json.JsonValue): ##javax.json.JsonArrayBuilder \ r;
    //     let JsonArrayBuilder(bld1) = bld;
    //     let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
    //     add(bld1, value1) |> JsonArrayBuilder


    // pub def addJsonArrayBuilder!(value: {value = JsonArrayBuilder[r]}, bld: JsonArrayBuilder[r]): Result[JsonArrayBuilder[r], String] \ Write(r) =
    //     try {
    //         import javax.json.JsonArrayBuilder.add(##javax.json.JsonArrayBuilder): ##javax.json.JsonArrayBuilder \ r;
    //         let JsonArrayBuilder(bld1) = bld;
    //         let JsonArrayBuilder(value1) = value.value;
    //         add(bld1, value1) |> JsonArrayBuilder |> Ok
    //     } catch {
    //         case ex: ##java.lang.Exception =>
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             Err(getMessage(ex))
    //     }

    // pub def addJsonObjectBuilder!(value: {value = JsonObjectBuilder[r]}, bld: JsonArrayBuilder[r]): Result[JsonArrayBuilder[r], String] \ Write(r) =
    //     try {
    //         import javax.json.JsonArrayBuilder.add(##javax.json.JsonObjectBuilder): ##javax.json.JsonArrayBuilder \ r;
    //         let JsonArrayBuilder(bld1) = bld;
    //         let JsonObjectBuilder(value1) = value.value;
    //         add(bld1, value1) |> JsonArrayBuilder |> Ok
    //     } catch {
    //         case ex: ##java.lang.Exception =>
    //             import java.lang.Throwable.getMessage(): String \ {};
    //             Err(getMessage(ex))
    //     }
        
    // TODO EE8 has set and remove methods...

    pub def runJsonArrayBuilder(arrb: JsonArrayBuilderHandle, f: Unit -> a \ ef): Result[String, a] \ (ef - JsonArrayBuilder) = 
        handle(arrb, f)()

}
