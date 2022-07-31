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

    pub enum JsonObjectBuilder[r: Region, ka: Type, a: Type](MonadLib.Builder[r, ka, ##javax.json.JsonObjectBuilder, a])

    instance Functor[JsonObjectBuilder[r, ka]] {
        pub def map(f: a -> b & ef, ma: JsonObjectBuilder[r, ka, a]): JsonObjectBuilder[r, ka, b] & ef = 
            Interop/Json/JsonObjectBuilder.map(f, ma)
    }

    instance Applicative[JsonObjectBuilder[r, ka]] {
        pub def point(x: a): JsonObjectBuilder[r, ka, a] = Interop/Json/JsonObjectBuilder.point(x)
        
        pub def ap(mf: JsonObjectBuilder[r, ka, a -> b & ef], ma: JsonObjectBuilder[r, ka, a]): JsonObjectBuilder[r, ka, b] & ef =
            Interop/Json/JsonObjectBuilder.ap(mf, ma)
    }

    instance Monad[JsonObjectBuilder[r, ka]] {
        pub def flatMap(f: a -> JsonObjectBuilder[r, ka, b] & ef, ma: JsonObjectBuilder[r, ka, a]): JsonObjectBuilder[r, ka, b] & ef =
            Interop/Json/JsonObjectBuilder.flatMap(f, ma)
    }


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

    pub def getJsonObjectBuilder(x: JsonObjectBuilder[r, ka, a]): MonadLib.Builder[r, ka, ##javax.json.JsonObjectBuilder, a] = 
        let JsonObjectBuilder(x1) = x;
        x1

    pub def point(x: a): JsonObjectBuilder[r, ka, a] = JsonObjectBuilder(MonadLib/Builder.point(x))
    
    pub def map(f: a -> b & ef, ma: JsonObjectBuilder[r, ka, a]): JsonObjectBuilder[r, ka, b] & ef = 
        JsonObjectBuilder(MonadLib/Builder.map(f, getJsonObjectBuilder(ma)))

    pub def ap(mf: JsonObjectBuilder[r, ka, a -> b & ef], ma: JsonObjectBuilder[r, ka, a]): JsonObjectBuilder[r, ka, b] & ef =
        JsonObjectBuilder(MonadLib/Builder.ap(getJsonObjectBuilder(mf), getJsonObjectBuilder(ma)))
        
    pub def flatMap(f: a -> JsonObjectBuilder[r, ka, b] & ef, ma: JsonObjectBuilder[r, ka, a]): JsonObjectBuilder[r, ka, b] & ef =
        JsonObjectBuilder(MonadLib/Builder.flatMap(f >> getJsonObjectBuilder, getJsonObjectBuilder(ma)))


    pub def throwError(msg: String): JsonObjectBuilder[r, ka, a] = 
        JsonObjectBuilder(MonadLib/Builder.throwError(msg))
    
    pub def liftSetter(f: ##javax.json.JsonObjectBuilder -> ##javax.json.JsonObjectBuilder & ef): JsonObjectBuilder[r, ka, Unit] & ef =
        JsonObjectBuilder(MonadLib/Builder.liftSetter(f))

    ///
    /// Returns the result of applying `ma` to the initial state `s`.
    ///
    pub def runBuilder(r: Region[r], 
                        ma: JsonObjectBuilder[r, a, a], 
                        s: ##javax.json.JsonObjectBuilder): Result[a, String] & r = 
        MonadLib/Builder.runBuilder(r, getJsonObjectBuilder(ma), s)




    /// Must be Impure uses IO...
    pub def createObject(r: Region[r], ma: JsonObjectBuilder[r, a, a]): Result[JsonObject, String] \ { Write(r) } = 
        import static javax.json.Json.createObjectBuilder(): ##javax.json.JsonObjectBuilder & r;
        import javax.json.JsonObjectBuilder.build(): ##javax.json.JsonObject & r as build1;
        try {
            let jbuilder = createObjectBuilder();
            match runBuilder(r, ma, jbuilder) {
                case Err(msg) => Err(msg)
                case Ok(_)    => Ok(JsonObject(build1(jbuilder)))
            }
        } catch {
            case ex: ##java.lang.Exception => 
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }




    pub def addNull(name: String): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.addNull(String): ##javax.json.JsonObjectBuilder & r;
        liftSetter(x1 -> addNull(x1, name))

    pub def addBool(name: String, value: Bool): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, Bool): ##javax.json.JsonObjectBuilder & r;
        liftSetter(x1 -> add(x1, name, value))

    pub def addBigInt(name: String, value: BigInt): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, BigInt): ##javax.json.JsonObjectBuilder & r;
        liftSetter(x1 -> add(x1, name, value))


    pub def addFloat64(name: String, value: Float64): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, Float64): ##javax.json.JsonObjectBuilder & r;
        liftSetter(x1 -> add(x1, name, value))

    pub def addInt32(name: String, value: Int32): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, Int32): ##javax.json.JsonObjectBuilder & r;
        liftSetter(x1 -> add(x1, name, value))


    pub def addString(name: String, value: String): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, String): ##javax.json.JsonObjectBuilder & r;
        liftSetter(x1 -> add(x1, name, value))

    pub def addJsonValue(name: String, value: JsonValue): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonValue): ##javax.json.JsonObjectBuilder & r;
        let JsonValue(v1) = value;
        liftSetter(x1 -> add(x1, name, v1))


    pub def addJsonArrayBuilder(name: String, value: JsonArrayBuilder[r, ka, ka]): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonArrayBuilder): ##javax.json.JsonObjectBuilder & r;
        import static javax.json.Json.createArrayBuilder(): ##javax.json.JsonArrayBuilder & r;
        let st = createArrayBuilder();
        match Interop/Json/JsonArrayBuilder.runBuilder(() as Region[r], value, st) {
            case Ok(_)    => liftSetter(x1 -> add(x1, name, st))
            case Err(msg) => throwError(msg)
        }

    pub def addJsonObjectBuilder(name: String, value: JsonObjectBuilder[r, ka, ka]): JsonObjectBuilder[r, ka, Unit] \ Write(r) =
        import javax.json.JsonObjectBuilder.add(String, ##javax.json.JsonObjectBuilder): ##javax.json.JsonObjectBuilder & r;
        import static javax.json.Json.createObjectBuilder(): ##javax.json.JsonObjectBuilder & r;
        let st = createObjectBuilder();
        match runBuilder(() as Region[r], value, st) {
            case Ok(_)    => liftSetter(x1 -> add(x1, name, st))
            case Err(msg) => throwError(msg)
        }
        

        
}
