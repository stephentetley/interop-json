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
    /// Represents a JsonObjectBuilder.
    /// Interface / Mutable
    ///
    pub enum JsonObjectBuilder[_: Region](##javax.json.JsonObjectBuilder)



}

namespace Interop/Json/JsonObjectBuilder {

    use Interop/Json.JsonObjectBuilder;
    use Interop/Json.JsonObjectBuilder.{JsonObjectBuilder};

    use Interop/Json.JsonArrayBuilder;
    use Interop/Json.JsonArrayBuilder.{JsonArrayBuilder};    
    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};
    use Interop/Json.ImpJsonValue;


    pub def getHH(bld: JsonObjectBuilder[r]): ##javax.json.JsonObjectBuilder = 
        let JsonObjectBuilder(bld1) = bld;
        bld1

    /// Note - the Java exception `addNull` thrown should be "unreachable" in Flix.
    pub def addNull(name: String, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
        import javax.json.JsonObjectBuilder.addNull(String): ##javax.json.JsonObjectBuilder \ r;
        let JsonObjectBuilder(bld1) = bld;
        addNull(bld1, name) |> JsonObjectBuilder 

        
    pub def addJsonValue(name: String, value: t, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) with ImpJsonValue[t] =
        import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonValue): ##javax.json.JsonObjectBuilder \ r;
        let JsonObjectBuilder(bld1) = bld;
        let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
        add(bld1, name, value1) |> JsonObjectBuilder 
        

    pub def addBool(name: String, value: Bool, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, Bool): ##javax.json.JsonObjectBuilder \ r;
        let JsonObjectBuilder(bld1) = bld;
        add(bld1, name, value) |> JsonObjectBuilder

    pub def addBigInt(name: String, value: BigInt, bld: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, BigInt): ##javax.json.JsonObjectBuilder \ r;
        let JsonObjectBuilder(bld1) = bld;
        add(bld1, name, value) |> JsonObjectBuilder


    // pub def addFloat64(name: String, value: Float64): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, Float64): ##javax.json.JsonObjectBuilder \ r;
    //     liftSetter(x1 -> add(x1, name, value))

    // pub def addInt32(name: String, value: Int32): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, Int32): ##javax.json.JsonObjectBuilder \ r;
    //     liftSetter(x1 -> add(x1, name, value))


    // pub def addString(name: String, value: String): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, String): ##javax.json.JsonObjectBuilder \ r;
    //     liftSetter(x1 -> add(x1, name, value))



    // pub def addJsonArrayBuilder(name: String, value: JsonArrayBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonArrayBuilder): ##javax.json.JsonObjectBuilder \ r;
    //     import static javax.json.Json.createArrayBuilder(): ##javax.json.JsonArrayBuilder \ r;
    //     let st = createArrayBuilder();
    //     match Interop/Json/JsonArrayBuilder.runBuilder(() as Region[r], value, st) {
    //         case Ok(_)    => liftSetter(x1 -> add(x1, name, st))
    //         case Err(msg) => throwError(msg)
    //     }

    // pub def addJsonObjectBuilder(name: String, value: JsonObjectBuilder[r]): JsonObjectBuilder[r] \ Write(r) =
    //     import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonObjectBuilder): ##javax.json.JsonObjectBuilder \ r;
    //     import static javax.json.Json.createObjectBuilder(): ##javax.json.JsonObjectBuilder \ r;
    //     let st = createObjectBuilder();
    //     match runBuilder(() as Region[r], value, st) {
    //         case Ok(_)    => liftSetter(x1 -> add(x1, name, st))
    //         case Err(msg) => throwError(msg)
    //     }
        

        
}
