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


pub mod InteropJson.JsonObjectReader {

    use InteropJson.JsonValue.JsonArray
    use InteropJson.JsonValue.JsonObject
    use InteropJson.JsonNumber.JsonNumber


    import jakarta.json.{JsonObject => JJsonObject}
    import java.lang.{Exception}



    pub eff ReadJsonObject {
        def isNull(name: {name = String}): Bool
        def getBool(name: {name = String}): Bool
        def getBoolWithDefault(name: {name = String}, d: Bool): Bool
        def getInt32(name: {name = String}): Int32
        def getInt32WithDefault(name: {name = String}, d: Int32): Int32
        def getString(name: {name = String}): String
        def getStringWithDefault(name: {name = String}, d: String): String        
    }

    pub def handle(_: Region[r], jsobject: JsonObject, f: a -> b \ ef): a -> Result[String, b] \ (ef - ReadJsonObject + r) = x -> {
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

        }
    }



    // pub def readFile(path: String): Result[JsonObject, String] \ IO = 
    //     File.read(path) |> Result.flatMap(readObject)
        
}
