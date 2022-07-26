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

    pub enum JsonObjectEvaluator[r: Region, ka: Type, a: Type](MonadLib.Evaluator[r, ka, ##javax.json.JsonObject, a])
        

    instance Functor[JsonObjectEvaluator[r, ka]] {
        pub def map(f: a -> b & ef, ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef = 
            JsonProcessing/JsonObjectEvaluator.map(f, ma)
    }

    instance Applicative[JsonObjectEvaluator[r, ka]] {
        pub def point(x: a): JsonObjectEvaluator[r, ka, a] = JsonProcessing/JsonObjectEvaluator.point(x)

        pub def ap(mf: JsonObjectEvaluator[r, ka, a -> b & ef], ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef =
            JsonProcessing/JsonObjectEvaluator.ap(mf, ma)
    }

    instance Monad[JsonObjectEvaluator[r, ka]] {
        pub def flatMap(f: a -> JsonObjectEvaluator[r, ka, b] & ef, ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef =
            JsonProcessing/JsonObjectEvaluator.flatMap(f, ma)
    }

}

namespace JsonProcessing/JsonObjectEvaluator {

    use JsonProcessing.JsonObjectEvaluator;
    use JsonProcessing.JsonObjectEvaluator.{JsonObjectEvaluator};

    use JsonProcessing.JsonArray;
    use JsonProcessing.JsonArray.{JsonArray};
    use JsonProcessing.JsonArrayEvaluator;
    use JsonProcessing.JsonNumber;
    use JsonProcessing.JsonNumber.{JsonNumber};
    use JsonProcessing.JsonObject;
    use JsonProcessing.JsonObject.{JsonObject};

    pub def runJsonObjectEvaluator(r: Region[r], 
                                    ma: JsonObjectEvaluator[r, a, a], 
                                    obj: JsonObject): Result[a, String] & r =
        let JsonObject(obj1) = obj;
        MonadLib/Evaluator.runEvaluator(r, getJsonObjectEvaluator(ma), obj1)

    pub def point(x: a): JsonObjectEvaluator[r, ka, a] = JsonObjectEvaluator(MonadLib/Evaluator.point(x))

            
    pub def map(f: a -> b & ef, ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef = 
        JsonObjectEvaluator(MonadLib/Evaluator.map(f, getJsonObjectEvaluator(ma)))

    pub def ap(mf: JsonObjectEvaluator[r, ka, a -> b & ef], ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef =
        JsonObjectEvaluator(MonadLib/Evaluator.ap(getJsonObjectEvaluator(mf), getJsonObjectEvaluator(ma)))

    pub def flatMap(f: a -> JsonObjectEvaluator[r, ka, b] & ef, ma: JsonObjectEvaluator[r, ka, a]): JsonObjectEvaluator[r, ka, b] & ef =
        JsonObjectEvaluator(MonadLib/Evaluator.flatMap(f >> getJsonObjectEvaluator, getJsonObjectEvaluator(ma)))


    pub def getJsonObjectEvaluator(x: JsonObjectEvaluator[r, ka, a]): MonadLib.Evaluator[r, ka, ##javax.json.JsonObject, a] = 
        let JsonObjectEvaluator(x1) = x;
        x1

    pub def throwError(msg: String): JsonObjectEvaluator[r, ka, a] = 
        JsonObjectEvaluator(MonadLib/Evaluator.throwError(msg))
    
    def liftGetter(f: ##javax.json.JsonObject -> a & ef): JsonObjectEvaluator[r, ka, a] & ef =
        JsonObjectEvaluator(MonadLib/Evaluator.liftGetter(f))

    def liftActionResult(f: Unit -> Result[a, String] & ef): JsonObjectEvaluator[r, ka, a] & ef =          
        JsonObjectEvaluator(MonadLib/Evaluator.liftActionResult(f))

    pub def getBool(name: String): JsonObjectEvaluator[r, ka, Bool] =
        import javax.json.JsonObject.getBoolean(String): Bool & Pure;
        liftGetter(x1 -> getBoolean(x1, name))

    pub def getBoolWithDefault(name: String, defaultVal: Bool): JsonObjectEvaluator[r, ka, Bool] =
        import javax.json.JsonObject.getBoolean(String, Bool): Bool & Pure;
        liftGetter(x1 -> getBoolean(x1, name, defaultVal))

    pub def getInt32(name: String): JsonObjectEvaluator[r, ka, Int32] =
        import javax.json.JsonObject.getInt(String): Int32 & Pure;
        liftGetter(x1 -> getInt(x1, name))
    
    pub def getInt32WithDefault(name: String, defaultVal: Int32): JsonObjectEvaluator[r, ka, Int32] =
        import javax.json.JsonObject.getInt(String, Int32): Int32 & Pure;
        liftGetter(x1 -> getInt(x1, name, defaultVal))

    pub def getJsonArray(name: String): JsonObjectEvaluator[r, ka, JsonArray] =
        import javax.json.JsonObject.getJsonArray(String): ##javax.json.JsonArray & Pure;
        liftGetter(x1 -> getJsonArray(x1, name)) |> map(JsonArray)

    pub def getJsonNumber(name: String): JsonObjectEvaluator[r, ka, JsonNumber] =
        import javax.json.JsonObject.getJsonNumber(String): ##javax.json.JsonNumber & Pure;
        liftGetter(x1 -> getJsonNumber(x1, name)) |> map(JsonNumber)

    pub def getJsonObject(name: String): JsonObjectEvaluator[r, ka, JsonObject] =
        import javax.json.JsonObject.getJsonObject(String): ##javax.json.JsonObject & Pure;
        liftGetter(x1 -> getJsonObject(x1, name)) |> map(JsonObject)        

    pub def getString(name: String): JsonObjectEvaluator[r, ka, String] =
        import javax.json.JsonObject.getString(String): String & Pure;
        liftGetter(x1 -> getString(x1, name))
    
    pub def getStringWithDefault(name: String, defaultVal: String): JsonObjectEvaluator[r, ka, String] =
        import javax.json.JsonObject.getString(String, String): String & Pure;
        liftGetter(x1 -> getString(x1, name, defaultVal))

    pub def isNull(name: String): JsonObjectEvaluator[r, ka, Bool] =
        import javax.json.JsonObject.isNull(String): Bool & Pure;
        liftGetter(x1 -> isNull(x1, name))

    pub def evalJsonObject(name: String, ma: JsonObjectEvaluator[r, a, a]): JsonObjectEvaluator[r, ka, a] & r =
        let* obj = getJsonObject(name);
        liftActionResult(_ -> runJsonObjectEvaluator(() as Region[r], ma, obj))
        
    pub def evalJsonArray(name: String, ma: JsonArrayEvaluator[r, a, a]): JsonObjectEvaluator[r, ka, a] & r =
        let* obj = getJsonArray(name);
        liftActionResult(_ -> JsonProcessing/JsonArrayEvaluator.runJsonArrayEvaluator(() as Region[r], ma, obj))

}

