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

    import jakarta.json.{JsonArrayBuilder => JJsonArrayBuilder}
    import java.lang.{Exception}

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
    }

    pub enum JsonArrayBuilderHandle(JJsonArrayBuilder)

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
                    let _ = unsafe IO { jarrb.addNull(ix#index) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addBool(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addBoolAt(ix, value, k) =  try {
                    let _ = unsafe IO { jarrb.add(ix#index, value) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addInt32(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addInt32At(ix, value, k) = try {
                    let _ = unsafe IO { jarrb.add(ix#index, value) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addBigInt(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addBigIntAt(ix, value, k) = try {
                    let _ = unsafe IO { jarrb.add(ix#index, value) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addFloat64(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addFloat64At(ix, value, k) = try {
                    let _ = unsafe IO { jarrb.add(ix#index, value) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addBigDecimal(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addBigDecimalAt(ix, value, k) = try {
                    let _ = unsafe IO { jarrb.add(ix#index, value) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

                def addString(value, k) = {
                    let _ = unsafe IO { jarrb.add(value) };
                    k()
                }

                def addStringAt(ix, value, k) = try {
                    let _ = unsafe IO { jarrb.add(ix#index, value) };
                    k()
                } catch {
                    case ex: Exception => Err(ex.getMessage())
                }

            }
        }


    // pub def build(bld: JsonArrayBuilder[r]): JsonArray \ Read(r) =
    //     import javax.json.JsonArrayBuilder.build(): ##javax.json.JsonArray \ r;
    //     let JsonArrayBuilder(bld1) = bld;
    //     build(bld1) |> JsonArray






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
