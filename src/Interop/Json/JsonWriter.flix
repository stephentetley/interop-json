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
    /// Represents a JsonWriter.
    /// Interface / Mutable
    ///
    pub enum JsonWriter[_: Region](##javax.json.JsonWriter)


}

namespace Interop/Json/JsonWriter {

    use Interop/Json.JsonWriter;
    use Interop/Json.JsonWriter.{JsonWriter};
    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};
    use Interop/Json.ImpJsonStructure;
    use Interop/Json.ImpJsonValue;


    pub def getHH(wr: JsonWriter[r]): ##javax.json.JsonWriter = 
        let JsonWriter(wr1) = wr;
        wr1


    pub def close(wr: JsonWriter[r]): Unit \ Write(r) = 
        import javax.json.JsonWriter.close(): Unit \ r;
        let JsonWriter(wr1) = wr;
        close(wr1)

    pub def writeArray(arr: JsonArray, wr: JsonWriter[r]): Result[Unit, String] \ Write(r) = 
        try {
            import javax.json.JsonWriter.writeArray(##javax.json.JsonArray): Unit \ r;
            let JsonWriter(wr1) = wr;
            let JsonArray(arr1) = arr;
            writeArray(wr1, arr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def writeObject(o: JsonObject, wr: JsonWriter[r]): Result[Unit, String] \ Write(r) = 
        try {
            import javax.json.JsonWriter.writeObject(##javax.json.JsonObject): Unit \ r;
            let JsonWriter(wr1) = wr;
            let JsonObject(o1) = o;
            writeObject(wr1, o1) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def writeJsonStructure(js: t, wr: JsonWriter[r]): Result[Unit, String] \ Write(r) with ImpJsonStructure[t] = 
        try {
            import javax.json.JsonWriter.write(##javax.json.JsonStructure): Unit \ r;
            let JsonWriter(wr1) = wr;
            let v1 = Interop/Json/JsonStructure.toJsonStructureHH(js);
            write(wr1, v1) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }


    pub def writeJsonValue(js: t, wr: JsonWriter[r]): Result[Unit, String] \ Write(r) with ImpJsonValue[t] = 
        try {
            import javax.json.JsonWriter.write(##javax.json.JsonValue): Unit \ r;
            let JsonWriter(wr1) = wr;
            let v1 = Interop/Json/JsonValue.toJsonValueHH(js);
            write(wr1, v1) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

}
