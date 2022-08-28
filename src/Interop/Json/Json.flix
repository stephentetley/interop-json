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


namespace Interop/Json/Json {

    use Interop/IO.InputStream;
    use Interop/IO.InputStream.{InputStream};
    use Interop/IO.OutputStream;
    use Interop/IO.OutputStream.{OutputStream};
    use Interop/IO.Reader;
    use Interop/IO.Reader.{Reader};
    use Interop/IO.Writer;
    use Interop/IO.Writer.{Writer};

    use Interop/Json.JsonMergePatch;
    use Interop/Json.JsonMergePatch.{JsonMergePatch};
    use Interop/Json.JsonPatch;
    use Interop/Json.JsonPatch.{JsonPatch};
    use Interop/Json.JsonPointer;
    use Interop/Json.JsonPointer.{JsonPointer};
    use Interop/Json.JsonReader;
    use Interop/Json.JsonReader.{JsonReader};
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};
    use Interop/Json.JsonWriter;
    use Interop/Json.JsonWriter.{JsonWriter};
    use Interop/Json.ImpJsonValue;
    use Interop/Json.ImpJsonStructure;

    pub def createPointer(ptr: String): Result[JsonPointer, String] = 
        try {
            import static javax.json.Json.createPointer(String): ##javax.json.JsonPointer \ {};
            createPointer(ptr) |> JsonPointer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
        }


    pub def createJsonDiff(src: t, dst: t): JsonPatch with ImpJsonStructure[t] = 
        import static javax.json.Json.createDiff(##javax.json.JsonStructure, ##javax.json.JsonStructure): ##javax.json.JsonPatch \ {};
        let src1 = Interop/Json/JsonStructure.toJsonStructureHH(src);
        let dst1 = Interop/Json/JsonStructure.toJsonStructureHH(dst);
        createDiff(src1, dst1) |> JsonPatch

    pub def createMergePatch(patch: t): JsonMergePatch with ImpJsonValue[t] = 
        import static javax.json.Json.createMergePatch(##javax.json.JsonValue): ##javax.json.JsonMergePatch \ {};
        let patch1 = Interop/Json/JsonValue.toJsonValueHH(patch);
        createMergePatch(patch1) |> JsonMergePatch


    pub def createReaderWithInputStream(ins: InputStream[r2]): JsonReader[r] \ {Write(r), Write(r2)} = 
        import static javax.json.Json.createReader(##java.io.InputStream): ##javax.json.JsonReader \ {r, r2};
        let InputStream(ins1) = ins;
        createReader(ins1) |> JsonReader

    pub def createReaderWithWriter(rd: Reader[r2]): JsonReader[r] \ {Write(r), Write(r2)} = 
        import static javax.json.Json.createReader(##java.io.Reader): ##javax.json.JsonReader \ {r, r2};
        let Reader(rd1) = rd;
        createReader(rd1) |> JsonReader


    pub def createWriterWithOutputStream(outs: OutputStream[r2]): JsonWriter[r] \ {Write(r), Write(r2)} = 
        import static javax.json.Json.createWriter(##java.io.OutputStream): ##javax.json.JsonWriter \ {r, r2};
        let OutputStream(outs1) = outs;
        createWriter(outs1) |> JsonWriter

    pub def createWriterWithWriter(wr: Writer[r2]): JsonWriter[r] \ {Write(r), Write(r2)} = 
        import static javax.json.Json.createWriter(##java.io.Writer): ##javax.json.JsonWriter \ {r, r2};
        let Writer(wr1) = wr;
        createWriter(wr1) |> JsonWriter

}
