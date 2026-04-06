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


mod InteropJson.ReadJsonFromString {

    use InteropJson.JsonValue


    import jakarta.json.{JsonReader => JJsonReader}
    import jakarta.json.{Json => JJson}
    import jakarta.json.{JsonValue => JJsonValue}
    import java.io.{StringReader => JStringReader}
    import java.lang.Exception


    pub def handle(f: a -> b \ ef): a -> b \ (ef - ReadJsonFromString) = x -> region rc {
        handleHelper(rc, f, x)
    }

    def handleHelper(_: Region[r], f: a -> b \ ef): a -> b \ (ef - ReadJsonFromString) + r = x ->
        run {
            f(x)
        } with handler ReadJsonFromString {
            def readJson(s, k) = try {
                let ins: JStringReader = unchecked_cast(new JStringReader(s) as _ \ r);
                let jsonreader: JJsonReader = unchecked_cast(JJson.createReader(ins) as _ \ r);
                let value1: JJsonValue = unchecked_cast(jsonreader.readValue() as _ \ r);
                unchecked_cast(jsonreader.close() as _ \ r);
                k(Ok(JsonValue.JsonValue(value1)))
            } catch {
                case ex: Exception => k(Err(ex.getMessage()))
            }
        }
    
    pub def runReadJsonFromString(f: Unit -> a \ ef): a \ (ef - ReadJsonFromString) = handle(f)()

    
}
