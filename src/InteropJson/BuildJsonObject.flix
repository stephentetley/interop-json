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

    use EffectExtras.Fail.Fail

    use InteropJson.JsonObject
    use InteropJson.JsonValue
    use InteropJson.ToJsonValue
    

    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonObjectBuilder => JJsonObjectBuilder}
    import jakarta.json.{JsonObject => JJsonObject}
    import java.lang.{Exception => JException}


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
        def remove(name: {name = String}): Unit
        def addAll(o: JsonObject): Unit
    }


    pub def add(name: {name = String}, value: t): Unit \ BuildJsonObject with ToJsonValue[t] = 
        BuildJsonObject.addJsonValue(name, ToJsonValue.toJsonValue(value))



    // Can't have a default handler because we have extra input and output requirements
    // Use a region to stop the Flix compiler eliminating Java calls that are called for their side effect


    pub def handle(o: Option[JsonObject], f: a -> b \ ef): a -> (JsonObject, b) \ (ef + Fail  - BuildJsonObject) = x -> {
        let jbuilder: JJsonObjectBuilder = match o {
            case Some(o1) => { 
                let JsonObject.JsonObject(jo1) = o1;
                unsafe IO as {ef + Fail - BuildJsonObject} { JJson.createObjectBuilder(jo1) }
            }
            case None => unsafe IO as {ef + Fail - BuildJsonObject} { JJson.createObjectBuilder() }
        };
        let ans = run {
            f(x)
        } with handler BuildJsonObject {

            def addNull(name, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.addNull(name#name) };
                k()
            }

            def addBool(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addInt32(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addInt64(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addBigInt(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addFloat64(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addInt64(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addBigDecimal(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addString(name, value, k) = {
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value) };
                k()
            }

            def addJsonValue(name, value, k) = {
                let JsonValue.JsonValue(value1) = value;
                unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.add(name#name, value1) };
                k()
            }


            def remove(name, k) = 
                try {
                    unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.remove(name#name) };
                    k()
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

            
            def addAll(obj, k) = 
                try {
                    let JsonObject.JsonObject(obj1) = obj;
                    let b1: JJsonObjectBuilder = unsafe IO as {ef + Fail - BuildJsonObject} { JJson.createObjectBuilder(obj1) };
                    unsafe IO as {ef + Fail - BuildJsonObject} { discard jbuilder.addAll(b1) };
                    k()
                } catch {
                    case ex: JException => Fail.report(ex.getMessage())
                }

        } with EffectExtras.Fail.runWithResult;
        match ans { 
            case Err(msg) => Fail.report(msg)
            case Ok(ans1) => {
                let jsobj: JJsonObject = unsafe IO as {ef + Fail - BuildJsonObject} { jbuilder.build() };
                (JsonObject.JsonObject(jsobj), ans1)
            }
        }
    }


    pub def runBuildJsonObject(o: Option[JsonObject], f: Unit -> a \ ef): (JsonObject, a) \ (ef + Fail - BuildJsonObject) =
        handle(o, f)()

        
    pub def evalBuildJsonObject(o: Option[JsonObject], f: Unit -> a \ ef): JsonObject \ (ef + Fail - BuildJsonObject) =
        runBuildJsonObject(o, f) |> fst

    pub def evalBuildJsonValue(o: Option[JsonObject], f: Unit -> a \ ef): JsonValue \ (ef + Fail - BuildJsonObject) =
        evalBuildJsonObject(o, f) |> ToJsonValue.toJsonValue
    
    // On failure generates a Json object with a single field "error" : msg
    pub def evalToJsonValue(o: Option[JsonObject], f: Unit -> a \ ef): JsonValue \ (ef - Fail - BuildJsonObject) =
        let ans = run { evalBuildJsonValue(o, f) } with EffectExtras.Fail.runWithResult;
        match ans {
            case Ok(v)    => v
            case Err(msg) => InteropJson.JsonObject.singleton("error", msg) |> ToJsonValue.toJsonValue
        }
}
