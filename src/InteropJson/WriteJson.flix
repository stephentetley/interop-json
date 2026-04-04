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


mod InteropJson.WriteJson {

    use IoError.ErrorKind
    use IoError.IoError
    use InteropJson.JsonValue


    import jakarta.json.{JsonWriter => JJsonWriter}
    import jakarta.json.{Json => JJson}
    import java.io.{FileOutputStream => JFileOutputStream}
    import java.lang.Exception



    pub def handle(f: a -> b \ ef): a -> b \ (ef - WriteJson) + IO = x ->
        run {
            f(x)
        } with handler WriteJson {
            def writeJson(path, value, k) = try {
                let outs: JFileOutputStream = new JFileOutputStream(path);
                let jsonwriter: JJsonWriter = JJson.createWriter(outs);
                let JsonValue.JsonValue(value1) = value;
                jsonwriter.write(value1);
                jsonwriter.close();
                k(Ok())
            } catch {
                case ex: Exception => k(Err(IoError(ErrorKind.Other, ex.getMessage())))
            }
        }


    @DefaultHandler
    pub def runWithIO(f: Unit -> a \ ef): a \ (ef - WriteJson) + IO = handle(f)()

}
