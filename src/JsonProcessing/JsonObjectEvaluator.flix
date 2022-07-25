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

    use JsonProcessing/JsonObjectEvaluator.{getJsonObjectEvaluator};

    pub enum JsonObjectEvaluator[r: Region, ka: Type, a: Type](MonadLib.Evaluator[r, ka, ##javax.json.JsonObject, a])
        

    instance Functor[JsonObjectEvaluator[r, ka]] {
        pub def map(f: a -> b & ef, ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef = 
            JsonObjectEvaluator(MonadLib/Evaluator.map(f, getJsonObjectEvaluator(ma)))
    }

    instance Applicative[JsonObjectEvaluator[r, ka]] {
        pub def point(x: a): JsonObjectEvaluator[r, ka, a] = JsonObjectEvaluator(MonadLib/Evaluator.point(x))

        pub def ap(mf: JsonObjectEvaluator[r, ka, a -> b & ef], ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef =
            JsonObjectEvaluator(MonadLib/Evaluator.ap(getJsonObjectEvaluator(mf), getJsonObjectEvaluator(ma)))
    }

    instance Monad[JsonObjectEvaluator[r, ka]] {
        pub def flatMap(f: a -> JsonObjectEvaluator[r, ka, b] & ef, ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef =
            JsonObjectEvaluator(MonadLib/Evaluator.flatMap(f >> getJsonObjectEvaluator, getJsonObjectEvaluator(ma)))
    }

}

namespace JsonProcessing/JsonObjectEvaluator {

    use JsonProcessing.JsonObjectEvaluator;
    use JsonProcessing.JsonObjectEvaluator.{JsonObjectEvaluator};

    pub def getJsonObjectEvaluator(x: JsonObjectEvaluator[r, ka, a]): MonadLib.Evaluator[r, ka, ##javax.json.JsonObject, a] = 
        let JsonObjectEvaluator(x1) = x;
        x1

    pub def throwError(msg: String): JsonObjectEvaluator[r, ka, a] = 
        JsonObjectEvaluator(MonadLib/Evaluator.throwError(msg))
    
    pub def liftGetter(f: ##javax.json.JsonObject -> a & ef): JsonObjectEvaluator[r, ka, a] & ef =
        JsonObjectEvaluator(MonadLib/Evaluator.liftGetter(f))


    pub def getInt32(name: String): JsonObjectEvaluator[r, ka, Int32] =
        import javax.json.JsonObject.getInt(String): Int32 & Pure;
        liftGetter(x1 -> getInt(x1, name))

}

