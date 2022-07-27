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


namespace JsonProcessing {

    pub enum JsonMergePatch(##javax.json.JsonMergePatch)


}

namespace JsonProcessing/JsonMergePatch {

    use JsonProcessing.JsonMergePatch;
    use JsonProcessing.JsonMergePatch.{JsonMergePatch};

    use JsonProcessing.JsonValue;
    use JsonProcessing.JsonValue.{JsonValue};

    pub def createMergeDiff(src: JsonValue, dst: JsonValue): JsonMergePatch = 
        import static javax.json.Json.createMergeDiff(##javax.json.JsonValue, ##javax.json.JsonValue): ##javax.json.JsonMergePatch & Pure;
        let JsonValue(src1) = src;
        let JsonValue(dst1) = dst;
        JsonMergePatch(createMergeDiff(src1, dst1))

    pub def createMergePatch(patch: JsonValue): JsonMergePatch = 
        import static javax.json.Json.createMergePatch(##javax.json.JsonValue): ##javax.json.JsonMergePatch & Pure;
        let JsonValue(patch1) = patch;
        JsonMergePatch(createMergePatch(patch1))


    pub def toJsonValue(x: JsonMergePatch): JsonValue =
        import javax.json.JsonMergePatch.toJsonValue(): ##javax.json.JsonValue & Pure;
        let JsonMergePatch(x1) = x;
        JsonValue(toJsonValue(x1))

    pub def apply(x: JsonMergePatch, v: JsonValue): JsonValue =
        import javax.json.JsonMergePatch.apply(##javax.json.JsonValue): ##javax.json.JsonValue & Pure;
        let JsonMergePatch(x1) = x;
        let JsonValue(v1) = v;
        JsonValue(apply(x1, v1))

}
