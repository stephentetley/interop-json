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
    /// Represents a JsonPatchBuilder.
    /// Interface / Mutable
    ///
    pub enum JsonPatchBuilder[_: Region](##javax.json.JsonPatchBuilder)


}

namespace Interop/Json/JsonPatchBuilder {

    use Interop/Json.JsonPatchBuilder;
    use Interop/Json.JsonPatchBuilder.{JsonPatchBuilder};

    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};
    use Interop/Json.JsonPatch;
    use Interop/Json.JsonPatch.{JsonPatch};
    use Interop/Json.JsonStructure;
    use Interop/Json.JsonStructure.{JsonStructure};
    use Interop/Json.ImpJsonStructure;

    pub def getHH(bld: JsonPatchBuilder[r]): ##javax.json.JsonPatchBuilder = 
        let JsonPatchBuilder(bld1) = bld;
        bld1

    pub def build(bld: JsonPatchBuilder[r]): JsonPatch \ Read(r) =
        import javax.json.JsonPatchBuilder.build(): ##javax.json.JsonPatch \ r;
        let JsonPatchBuilder(bld1) = bld;
        build(bld1) |> JsonPatch


    pub def addBool!(path: String, value: Bool, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.add(String, Bool): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        add(bld1, path, value) |> JsonPatchBuilder 

    pub def addInt32!(path: String, value: Int32, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.add(String, Int32): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        add(bld1, path, value) |> JsonPatchBuilder 

}
