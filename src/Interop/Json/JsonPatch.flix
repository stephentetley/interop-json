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

    pub enum JsonPatch(##javax.json.JsonPatch)

    instance ToString[JsonPatch] {
        pub def toString(x: JsonPatch): String = Interop/Json/JsonPatch.toJsonArray(x) |> ToString.toString
    }

}

namespace Interop/Json/JsonPatch {

    use Interop/Json.JsonPatch;
    use Interop/Json.JsonPatch.{JsonPatch};

    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};
    use Interop/Json.JsonStructure;
    use Interop/Json.JsonStructure.{JsonStructure};
    use Interop/Json.ImpJsonStructure;

    pub def getHH(p: JsonPatch): ##javax.json.JsonPatch = 
        let JsonPatch(p1) = p;
        p1

    pub def toJsonArray(x: JsonPatch): JsonArray =
        import javax.json.JsonPatch.toJsonArray(): ##javax.json.JsonArray \ {};
        let JsonPatch(x1) = x;
        JsonArray(toJsonArray(x1))



    pub def apply(x: JsonPatch, js: t): Result[t, String] with ImpJsonStructure[t] =
        import javax.json.JsonPatch.apply(##javax.json.JsonStructure): ##javax.json.JsonStructure \ {};
        try {
            let JsonPatch(x1) = x;
            let st1 = Interop/Json/JsonStructure.toJsonStructureHH(js);
            let ans = apply(x1, st1);
            JsonStructure(ans) |> Interop/Json/ImpJsonStructure.fromJsonStructure |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

}
