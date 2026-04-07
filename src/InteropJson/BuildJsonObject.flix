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


pub mod InteropJson.BuildJsonObject {

    use InteropJson.JsonObject
    use InteropJson.JsonValue
    use InteropJson.ToJsonValue
    

    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonObjectBuilder => JJsonObjectBuilder}
    import jakarta.json.{JsonObject => JJsonObject}
    import java.lang.{Exception}


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
        def addNestedJsonValue(name: {name = String}, v: Result[String, JsonValue]): Unit
        def remove(name: {name = String}): Unit
        def addAll(o: JsonObject): Unit
    }


    pub def add(name: {name = String}, value: t): Unit \ BuildJsonObject with ToJsonValue[t] = 
        BuildJsonObject.addJsonValue(name, ToJsonValue.toJsonValue(value))



    // Can't have a default handler because we have extra input and output requirements
    // Use a region to stop the Flix compiler eliminating Java calls that are called for their side effect


    pub def handle(o: Option[JsonObject], f: a -> b \ ef): a -> Result[String, (JsonObject, b)] \ (ef - BuildJsonObject) = x -> 
        region rc { 
            let builder: JJsonObjectBuilder = match o {
                case Some(o1) => { 
                    let JsonObject.JsonObject(jo1) = o1;
                    unsafe IO { JJson.createObjectBuilder(jo1) }
                }
                case None => unsafe IO { JJson.createObjectBuilder() }
            };
            handleHelper(rc, builder, f, x) 
            
        }

    // TODO - make builder a param so we can initialize from empty or a JJsonObject
    def handleHelper(_: Region[r], jbuilder: JJsonObjectBuilder, f: a -> b \ ef): a -> Result[String, (JsonObject, b)] \ (ef - BuildJsonObject + r) = x -> {        
        let ans = run {
            Ok(f(x))
        } with handler BuildJsonObject {

            def addNull(name, k) = {
                unchecked_cast(discard jbuilder.addNull(name#name) as _ \ r);
                k()
            }

            def addBool(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addInt32(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addInt64(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addBigInt(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addFloat64(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addInt64(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addBigDecimal(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addString(name, value, k) = {
                unchecked_cast(discard jbuilder.add(name#name, value) as _ \ r);
                k()
            }

            def addJsonValue(name, value, k) = {
                let JsonValue.JsonValue(value1) = value;
                unchecked_cast(discard jbuilder.add(name#name, value1) as _ \ r);
                k()
            }


            def remove(name, k) = try {
                unchecked_cast(discard jbuilder.remove(name#name) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def addNestedJsonValue(name, rvalue, k) = match rvalue {
                case Err(msg)   => Err(msg)
                case Ok(value)  => {
                    let JsonValue.JsonValue(value1) = value;
                    unchecked_cast(discard jbuilder.add(name#name, value1) as _ \ r);
                    k()
                }
            }
            
            def addAll(obj, k) = try {
                let JsonObject.JsonObject(obj1) = obj;
                let b1: JJsonObjectBuilder = unchecked_cast(JJson.createObjectBuilder(obj1) as _ \ r );
                unchecked_cast(discard jbuilder.addAll(b1) as _ \ r);
                k()
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

        };
        match ans { 
            case Err(msg) => Err(msg)
            case Ok(ans1) => {
                let jsobj: JJsonObject = unchecked_cast(jbuilder.build() as _ \ r);
                Ok((JsonObject.JsonObject(jsobj), ans1))
            }
        }

    }

    pub def runBuildJsonObject(o: Option[JsonObject], f: Unit -> a \ ef): Result[String, (JsonObject, a)] \ (ef - BuildJsonObject) =
        handle(o, f)()

        
    pub def evalBuildJsonObject(o: Option[JsonObject], f: Unit -> a \ ef): Result[String, JsonObject] \ (ef - BuildJsonObject) =
        runBuildJsonObject(o, f) |> Result.map(fst)

    pub def evalBuildJsonValue(o: Option[JsonObject], f: Unit -> a \ ef): Result[String, JsonValue] \ (ef - BuildJsonObject) =
        evalBuildJsonObject(o, f) |> Result.map(ToJsonValue.toJsonValue)
    
    // On failure generates a Json object with a single field "error" : msg
    pub def evalToJsonValue(o: Option[JsonObject], f: Unit -> a \ ef): JsonValue \ (ef - BuildJsonObject) =
        match evalBuildJsonValue(o, f) {
            case Ok(v)    => v
            case Err(msg) => InteropJson.JsonObject.singleton("error", msg) |> ToJsonValue.toJsonValue
        }
}
