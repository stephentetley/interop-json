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


namespace Interop/Json {


    ///
    /// Represents a JsonArrayBuilder.
    /// Interface / Mutable
    ///
    pub enum JsonArrayBuilder[_: Region](##javax.json.JsonArrayBuilder)


}

namespace Interop/Json/JsonArrayBuilder {

    use Interop/Json.JsonArrayBuilder;
    use Interop/Json.JsonArrayBuilder.{JsonArrayBuilder};
    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonObjectBuilder;
    use Interop/Json.JsonObjectBuilder.{JsonObjectBuilder};    
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};
    use Interop/Json.ImpJsonValue;


    pub def getHH(bld: JsonArrayBuilder[r]): ##javax.json.JsonArrayBuilder = 
        let JsonArrayBuilder(bld1) = bld;
        bld1

    /// Note - the Java exception `addNull` thrown should be "unreachable" in Flix.
    pub def addNull!(bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
        import javax.json.JsonArrayBuilder.addNull(): ##javax.json.JsonArrayBuilder \ r;
        let JsonArrayBuilder(bld1) = bld;
        addNull(bld1) |> JsonArrayBuilder 

    pub def addBool!(value: Bool, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(Bool): ##javax.json.JsonArrayBuilder \ r;
        let JsonArrayBuilder(bld1) = bld;
        add(bld1, value) |> JsonArrayBuilder 

    pub def addBigInt!(value: BigInt, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(BigInt): ##javax.json.JsonArrayBuilder \ r;
        let JsonArrayBuilder(bld1) = bld;
        add(bld1, value) |> JsonArrayBuilder 


    pub def addFloat64!(value: Float64, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(Float64): ##javax.json.JsonArrayBuilder \ r;
        let JsonArrayBuilder(bld1) = bld;
        add(bld1, value) |> JsonArrayBuilder 

    pub def addInt32!(value: Int32, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(Int32): ##javax.json.JsonArrayBuilder \ r;
        let JsonArrayBuilder(bld1) = bld;
        add(bld1, value) |> JsonArrayBuilder 


    pub def addString!(value: String, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(String): ##javax.json.JsonArrayBuilder \ r;
        let JsonArrayBuilder(bld1) = bld;
        add(bld1, value) |> JsonArrayBuilder 

    pub def addJsonValue!(value: t, bld: JsonArrayBuilder[r]): JsonArrayBuilder[r] \ Write(r) with ImpJsonValue[t] =
        import javax.json.JsonArrayBuilder.add(##javax.json.JsonValue): ##javax.json.JsonArrayBuilder \ r;
        let JsonArrayBuilder(bld1) = bld;
        let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
        add(bld1, value1) |> JsonArrayBuilder


    pub def addJsonArrayBuilder!(value: { value :: JsonArrayBuilder[r]}, bld: JsonArrayBuilder[r]): Result[JsonArrayBuilder[r], String] \ Write(r) =
        try {
            import javax.json.JsonArrayBuilder.add(##javax.json.JsonArrayBuilder): ##javax.json.JsonArrayBuilder \ r;
            let JsonArrayBuilder(bld1) = bld;
            let JsonArrayBuilder(value1) = value.value;
            add(bld1, value1) |> JsonArrayBuilder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
        }

    pub def addJsonObjectBuilder!(value: { value :: JsonObjectBuilder[r]}, bld: JsonArrayBuilder[r]): Result[JsonArrayBuilder[r], String] \ Write(r) =
        try {
            import javax.json.JsonArrayBuilder.add(##javax.json.JsonObjectBuilder): ##javax.json.JsonArrayBuilder \ r;
            let JsonArrayBuilder(bld1) = bld;
            let JsonObjectBuilder(value1) = value.value;
            add(bld1, value1) |> JsonArrayBuilder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
        }
        
    // TODO EE8 has set and remove methods...
        
}
