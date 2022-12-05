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

    instance Scoped[JsonPatchBuilder] {
        pub def regionOf(_: JsonPatchBuilder[r]): Region[r] = unsafe_cast () as Region[r]
    }


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
    use Interop/Json.ImpJsonValue;

    pub def getHH(bld: JsonPatchBuilder[r]): ##javax.json.JsonPatchBuilder = 
        let JsonPatchBuilder(bld1) = bld;
        bld1

    pub def build(bld: JsonPatchBuilder[r]): JsonPatch \ Read(r) =
        import javax.json.JsonPatchBuilder.build(): ##javax.json.JsonPatch \ r;
        let JsonPatchBuilder(bld1) = bld;
        build(bld1) |> JsonPatch


    pub def addBool!(path: {path = String}, value: Bool, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.add(String, Bool): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        add(bld1, path.path, value) |> JsonPatchBuilder 

    pub def addInt32!(path: {path = String}, value: Int32, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.add(String, Int32): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        add(bld1, path.path, value) |> JsonPatchBuilder 


    pub def addString!(path: {path = String}, value: String, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.add(String, String): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        add(bld1, path.path, value) |> JsonPatchBuilder

    pub def addJsonValue!(path: {path = String}, value: t, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) with ImpJsonValue[t] =
        import javax.json.JsonPatchBuilder.add(String, ##javax.json.JsonValue): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
        add(bld1, path.path, value1) |> JsonPatchBuilder


    pub def copy!(path: {path = String}, src: String, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.copy(String, String): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        copy(bld1, path.path, src) |> JsonPatchBuilder


    pub def move!(path: {path = String}, src: String, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.move(String, String): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        move(bld1, path.path, src) |> JsonPatchBuilder

    pub def remove!(path: {path = String}, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.remove(String): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        remove(bld1, path.path) |> JsonPatchBuilder 

    pub def replaceBool!(path: {path = String}, value: Bool, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.replace(String, Bool): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        replace(bld1, path.path, value) |> JsonPatchBuilder 

    pub def replaceInt32!(path: {path = String}, value: Int32, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.replace(String, Int32): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        replace(bld1, path.path, value) |> JsonPatchBuilder 

    pub def replaceString!(path: {path = String}, value: String, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.replace(String, String): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        replace(bld1, path.path, value) |> JsonPatchBuilder

    pub def replaceJsonValue!(path: {path = String}, value: t, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) with ImpJsonValue[t] =
        import javax.json.JsonPatchBuilder.replace(String, ##javax.json.JsonValue): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
        replace(bld1, path.path, value1) |> JsonPatchBuilder

    pub def testBool!(path: {path = String}, value: Bool, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.test(String, Bool): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        test(bld1, path.path, value) |> JsonPatchBuilder 

    pub def testInt32!(path: {path = String}, value: Int32, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.test(String, Int32): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        test(bld1, path.path, value) |> JsonPatchBuilder 

    pub def testString!(path: {path = String}, value: String, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) =
        import javax.json.JsonPatchBuilder.test(String, String): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        test(bld1, path.path, value) |> JsonPatchBuilder

    pub def testJsonValue!(path: {path = String}, value: t, bld: JsonPatchBuilder[r]): JsonPatchBuilder[r] \ Write(r) with ImpJsonValue[t] =
        import javax.json.JsonPatchBuilder.test(String, ##javax.json.JsonValue): ##javax.json.JsonPatchBuilder \ r;
        let JsonPatchBuilder(bld1) = bld;
        let value1 = Interop/Json/JsonValue.toJsonValueHH(value);
        test(bld1, path.path, value1) |> JsonPatchBuilder

}
