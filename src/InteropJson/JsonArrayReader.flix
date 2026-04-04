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


pub mod InteropJson.JsonArrayReader {

    use InteropJson.JsonArray
    use InteropJson.JsonObject

    import jakarta.json.{JsonArray => JJsonArray}
    import jakarta.json.{JsonNumber => JJsonNumber}
    import jakarta.json.{JsonObject => JJsonObject}
    import java.lang.{Exception}




    pub eff ReadJsonArray {
        def isNull(index: {index = Int32}): Bool
        def getBool(index: {index = Int32}): Bool
        def getBoolWithDefault(index: {index = Int32}, d: Bool): Bool
        def getInt32(index: {index = Int32}): Int32
        def getInt32WithDefault(index: {index = Int32}, d: Int32): Int32
        def getInt64(index: {index = Int32}): Int64
        def getInt64WithDefault(index: {index = Int32}, d: Int64): Int64
        def getBigInt(index: {index = Int32}): BigInt
        def getBigIntWithDefault(index: {index = Int32}, d: BigInt): BigInt
        def getFloat64(index: {index = Int32}): Float64
        def getFloat64WithDefault(index: {index = Int32}, d: Float64): Float64
        def getBigDecimal(index: {index = Int32}): BigDecimal
        def getBigDecimalWithDefault(index: {index = Int32}, d: BigDecimal): BigDecimal
        def getString(index: {index = Int32}): String
        def getStringWithDefault(index: {index = Int32}, d: String): String
        def getJsonArray(index: {index = Int32}): JsonArray
        def getJsonObject(index: {index = Int32}): JsonObject
    }

    pub def handle(_: Region[r], jsarray: JsonArray, f: a -> b \ ef): a -> Result[String, b] \ (ef - ReadJsonArray + r) = x -> {
        let JsonArray.JsonArray(jsarray1) = jsarray;
        run {
            Ok(f(x))
        } with handler ReadJsonArray {

            def isNull(ix, k) = try {
                let ans = unchecked_cast(jsarray1.isNull(ix#index) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }
        
            def getBool(ix, k) = try {
                let ans = unchecked_cast(jsarray1.getBoolean(ix#index) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getBoolWithDefault(ix, d, k) = {
                let ans = unchecked_cast(jsarray1.getBoolean(ix#index, d) as _ \ r);
                k(ans)
            } 

            def getInt32(ix, k) = try {
                let ans = unchecked_cast(jsarray1.getInt(ix#index) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getInt32WithDefault(ix, d, k) = {
                let ans = unchecked_cast(jsarray1.getInt(ix#index, d) as _ \ r);
                k(ans)
            } 
            
            def getInt64(ix, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.longValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getInt64WithDefault(ix, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.longValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }

            def getBigInt(ix, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.bigIntegerValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getBigIntWithDefault(ix, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.bigIntegerValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }

            def getFloat64(ix, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.doubleValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getFloat64WithDefault(ix, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.doubleValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }

            def getBigDecimal(ix, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.bigDecimalValue() as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getBigDecimalWithDefault(ix, d, k) = try {
                let num: JJsonNumber = unchecked_cast(jsarray1.getJsonNumber(ix#index) as _ \ r);
                let ans = unchecked_cast(num.bigDecimalValue() as _ \ r);
                k(ans)
            } catch {
                case _: Exception => k(d)
            }

            def getString(ix, k) = try {
                let ans = unchecked_cast(jsarray1.getString(ix#index) as _ \ r);
                k(ans)
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getStringWithDefault(ix, d, k) = {
                let ans = unchecked_cast(jsarray1.getString(ix#index, d) as _ \ r);
                k(ans)
            } 

            def getJsonArray(ix, k) = try {
                let arr: JJsonArray = unchecked_cast(jsarray1.getJsonArray(ix#index) as _ \ r);
                k(JsonArray.JsonArray(arr))
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

            def getJsonObject(ix, k) = try {
                let obj: JJsonObject = unchecked_cast(jsarray1.getJsonObject(ix#index) as _ \ r);
                k(JsonObject.JsonObject(obj))
            } catch {
                case ex: Exception => Err(ex.getMessage())
            }

        }
    }

    pub def runReadJsonArray(jsarr: JsonArray, f: Unit -> a \ ef): Result[String, a] \ (ef - ReadJsonArray) =
        region rc {
            handle(rc, jsarr, f)() 
        }



    // pub def readFile(path: String): Result[JsonArray, String] \ IO = 
    //     File.read(path) |> Result.flatMap(readArray)

}
