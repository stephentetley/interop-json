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


pub mod InteropJson.ReadJsonObject {

    use InteropJson.JsonArray
    use InteropJson.JsonObject

    import jakarta.json.{JsonArray => JJsonArray}
    import jakarta.json.{JsonNumber => JJsonNumber}
    import jakarta.json.{JsonObject => JJsonObject}
    import java.lang.{Exception}



    pub eff ReadJsonObject {
        def isNull(name: {name = String}): Bool
        def getBool(name: {name = String}): Bool
        def getBoolWithDefault(name: {name = String}, d: Bool): Bool
        def getInt32(name: {name = String}): Int32
        def getInt32WithDefault(name: {name = String}, d: Int32): Int32
        def getInt64(name: {name = String}): Int64
        def getInt64WithDefault(name: {name = String}, d: Int64): Int64
        def getBigInt(name: {name = String}): BigInt
        def getBigIntWithDefault(name: {name = String}, d: BigInt): BigInt
        def getFloat64(name: {name = String}): Float64
        def getFloat64WithDefault(name: {name = String}, d: Float64): Float64
        def getBigDecimal(name: {name = String}): BigDecimal
        def getBigDecimalWithDefault(name: {name = String}, d: BigDecimal): BigDecimal
        def getString(name: {name = String}): String
        def getStringWithDefault(name: {name = String}, d: String): String
        def getJsonArray(name: {name = String}): JsonArray
        def getJsonObject(name: {name = String}): JsonObject      
    }

    pub def handle(jsobject: JsonObject, f: a -> b \ ef): a -> Result[String, b] \ (ef - ReadJsonObject) = x -> 
        region rc { handleHelper(rc, jsobject, f, x) }

    def handleHelper(_: Region[r], jsobject: JsonObject, f: a -> b \ ef): a -> Result[String, b] \ (ef - ReadJsonObject + r) = x -> {
        let JsonObject.JsonObject(jsobject1) = jsobject;
        run {
            Ok(f(x))
        } with handler ReadJsonObject {

            def isNull(name, k) = try {
                let ans = unchecked_cast(jsobject1.isNull(name#name) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }
        
            def getBool(name, k) = try {
                let ans = unchecked_cast(jsobject1.getBoolean(name#name) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getBoolWithDefault(name, d, k) = {
                let ans = unchecked_cast(jsobject1.getBoolean(name#name, d) as _ \ r);
                k(ans)
            }

            def getInt32(name, k) = try {
                let ans = unchecked_cast(jsobject1.getInt(name#name) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getInt32WithDefault(name, d, k) = {
                let ans = unchecked_cast(jsobject1.getInt(name#name, d) as _ \ r);
                k(ans)
            } 

            def getInt32(name, k) = try {
                let ans = unchecked_cast(jsobject1.getInt(name#name) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getInt32WithDefault(name, d, k) = {
                let ans = unchecked_cast(jsobject1.getInt(name#name, d) as _ \ r);
                k(ans)
            } 
            
            def getInt64(name, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.longValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getInt64WithDefault(name, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.longValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }

            def getBigInt(name, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.bigIntegerValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getBigIntWithDefault(name, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.bigIntegerValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }

            def getFloat64(name, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.doubleValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getFloat64WithDefault(name, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.doubleValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }

            def getBigDecimal(name, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.bigDecimalValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getBigDecimalWithDefault(name, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsobject1.getJsonNumber(name#name) as _ \ r);
                let ans = unchecked_cast(num.bigDecimalValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }


            def getString(name, k) = try {
                let ans = unchecked_cast(jsobject1.getString(name#name) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getStringWithDefault(name, d, k) = {
                let ans = unchecked_cast(jsobject1.getString(name#name, d) as _ \ r);
                k(ans)
            } 

            def getJsonArray(name, k) = try {
                let arr: JJsonArray = unchecked_cast(jsobject1.getJsonArray(name#name) as _ \ r);
                k(JsonArray.JsonArray(arr))
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getJsonObject(name, k) = try {
                let obj: JJsonObject = unchecked_cast(jsobject1.getJsonObject(name#name) as _ \ r);
                k(JsonObject.JsonObject(obj))
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }
        }
    }

    pub def runReadJsonObject(jsobj: JsonObject, f: Unit -> a \ ef): Result[String, a] \ (ef - ReadJsonObject) =
        handle(jsobj, f)() 
        
}
