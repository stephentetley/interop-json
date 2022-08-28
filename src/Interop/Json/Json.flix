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

    use Interop/Json.JsonMergePatch;
    use Interop/Json.JsonMergePatch.{JsonMergePatch};
    use Interop/Json.JsonPatch;
    use Interop/Json.JsonPatch.{JsonPatch};
    use Interop/Json.JsonPointer;
    use Interop/Json.JsonPointer.{JsonPointer};
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};
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



}
