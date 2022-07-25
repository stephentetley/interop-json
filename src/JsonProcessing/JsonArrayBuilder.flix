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


namespace JsonProcessing {

    use JsonProcessing/JsonArrayBuilder.{getJsonArrayBuilder};

    pub enum JsonArrayBuilder[r: Region, ka: Type, a: Type](MonadLib.Builder[r, ka, ##javax.json.JsonArrayBuilder, a])

    instance Functor[JsonArrayBuilder[r, ka]] {
        pub def map(f: a -> b & ef, ma: JsonArrayBuilder[r, ka, a]): JsonArrayBuilder[r, ka, b] & ef = 
            JsonArrayBuilder(MonadLib/Builder.map(f, getJsonArrayBuilder(ma)))
    }

    instance Applicative[JsonArrayBuilder[r, ka]] {
        pub def point(x: a): JsonArrayBuilder[r, ka, a] = JsonArrayBuilder(MonadLib/Builder.point(x))
        pub def ap(mf: JsonArrayBuilder[r, ka, a -> b & ef], ma: JsonArrayBuilder[r, ka, a]): JsonArrayBuilder[r, ka, b] & ef =
            JsonArrayBuilder(MonadLib/Builder.ap(getJsonArrayBuilder(mf), getJsonArrayBuilder(ma)))
    }

    instance Monad[JsonArrayBuilder[r, ka]] {
        pub def flatMap(f: a -> JsonArrayBuilder[r, ka, b] & ef, ma: JsonArrayBuilder[r, ka, a]): JsonArrayBuilder[r, ka, b] & ef =
            JsonArrayBuilder(MonadLib/Builder.flatMap(f >> getJsonArrayBuilder, getJsonArrayBuilder(ma)))
    }


}

namespace JsonProcessing/JsonArrayBuilder {

    use JsonProcessing.JsonArrayBuilder;
    use JsonProcessing.JsonArrayBuilder.{JsonArrayBuilder};
    use JsonProcessing.JsonArray;
    use JsonProcessing.JsonArray.{JsonArray};
    use JsonProcessing.JsonObjectBuilder;
    use JsonProcessing.JsonObjectBuilder.{JsonObjectBuilder};    
    use JsonProcessing.JsonValue;
    use JsonProcessing.JsonValue.{JsonValue};

    pub def getJsonArrayBuilder(x: JsonArrayBuilder[r, ka, a]): MonadLib.Builder[r, ka, ##javax.json.JsonArrayBuilder, a] = 
        let JsonArrayBuilder(x1) = x;
        x1

    pub def throwError(msg: String): JsonArrayBuilder[r, ka, a] = 
        JsonArrayBuilder(MonadLib/Builder.throwError(msg))
    
    pub def liftSetter(f: ##javax.json.JsonArrayBuilder -> ##javax.json.JsonArrayBuilder & ef): JsonArrayBuilder[r, ka, Unit] & ef =
        JsonArrayBuilder(MonadLib/Builder.liftSetter(f))

    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    pub def runBuilder(r: Region[r], 
                        ma: JsonArrayBuilder[r, a, a], 
                        s: ##javax.json.JsonArrayBuilder): Result[a, String] & r = 
        MonadLib/Builder.runBuilder(r, getJsonArrayBuilder(ma), s)




    pub def createArray(r: Region[r], ma: JsonArrayBuilder[r, a, a]): Result[JsonArray, String] \ { Write(r) } = 
        import static javax.json.Json.createArrayBuilder(): ##javax.json.JsonArrayBuilder & r;
        import javax.json.JsonArrayBuilder.build(): ##javax.json.JsonArray & r as build1;
        try {
            let jbuilder = createArrayBuilder();
            match runBuilder(r, ma, jbuilder) {
                case Err(msg) => Err(msg)
                case Ok(_)    => Ok(JsonArray(build1(jbuilder)))
            }
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }




    pub def addNull(): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.addNull(): ##javax.json.JsonArrayBuilder & r;
        liftSetter(x1 -> addNull(x1))

    pub def addBool(value: Bool): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(Bool): ##javax.json.JsonArrayBuilder & r;
        liftSetter(x1 -> add(x1, value))

    pub def addBigInt(value: BigInt): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(BigInt): ##javax.json.JsonArrayBuilder & r;
        liftSetter(x1 -> add(x1, value))


    pub def addFloat64(value: Float64): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(Float64): ##javax.json.JsonArrayBuilder & r;
        liftSetter(x1 -> add(x1, value))

    pub def addInt32(value: Int32): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(Int32): ##javax.json.JsonArrayBuilder & r;
        liftSetter(x1 -> add(x1, value))


    pub def addString(value: String): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(String): ##javax.json.JsonArrayBuilder & r;
        liftSetter(x1 -> add(x1, value))

    pub def addJsonValue(value: JsonValue): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(##javax.json.JsonValue): ##javax.json.JsonArrayBuilder & r;
        let JsonValue(v1) = value;
        liftSetter(x1 -> add(x1, v1))

    pub def addJsonArrayBuilder(value: JsonArrayBuilder[r, ka, ka]): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(##javax.json.JsonArrayBuilder): ##javax.json.JsonArrayBuilder & r;
        import static javax.json.Json.createArrayBuilder(): ##javax.json.JsonArrayBuilder & r;
        let st = createArrayBuilder();
        match runBuilder(() as Region[r], value, st) {
            case Ok(_)    => liftSetter(x1 -> add(x1, st))
            case Err(msg) => throwError(msg)
        }

    pub def addJsonObjectBuilder(value: JsonObjectBuilder[r, ka, ka]): JsonArrayBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonArrayBuilder.add(##javax.json.JsonObjectBuilder): ##javax.json.JsonArrayBuilder & r;
        import static javax.json.Json.createObjectBuilder(): ##javax.json.JsonObjectBuilder & r;
        let st = createObjectBuilder();
        match JsonProcessing/JsonObjectBuilder.runBuilder(() as Region[r], value, st) {
            case Ok(_)    => liftSetter(x1 -> add(x1, st))
            case Err(msg) => throwError(msg)
        }
        

        
}
