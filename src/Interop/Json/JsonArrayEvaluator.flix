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

    pub enum JsonArrayEvaluator[r: Region, ka: Type, a: Type](MonadLib.Evaluator[r, ka, ##javax.json.JsonArray, a])
        

    instance Functor[JsonArrayEvaluator[r, ka]] {
        pub def map(f: a -> b & ef, ma: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, b] & ef = 
            Interop/Json/JsonArrayEvaluator.map(f, ma)
    }

    instance Applicative[JsonArrayEvaluator[r, ka]] {
        pub def point(x: a): JsonArrayEvaluator[r, ka, a] = Interop/Json/JsonArrayEvaluator.point(x)

        pub def ap(mf: JsonArrayEvaluator[r, ka, a -> b & ef], ma: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, b] & ef =
            Interop/Json/JsonArrayEvaluator.ap(mf, ma)
    }

    instance Monad[JsonArrayEvaluator[r, ka]] {
        pub def flatMap(f: a -> JsonArrayEvaluator[r, ka, b] & ef, ma: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, b] & ef =
            Interop/Json/JsonArrayEvaluator.flatMap(f, ma)
    }
    
    instance MonadZero[JsonArrayEvaluator[r, ka]] {
        pub def empty(): JsonArrayEvaluator[r, ka, a] = Interop/Json/JsonArrayEvaluator.empty()
    }
    
    instance MonadLib.MonadOr[JsonArrayEvaluator[r, ka]] {
        pub def orelse(a: JsonArrayEvaluator[r, ka, a], b: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, a] =
            Interop/Json/JsonArrayEvaluator.orelse(a, b)
    }

}

namespace Interop/Json/JsonArrayEvaluator {

    use Interop/Json.JsonArrayEvaluator;
    use Interop/Json.JsonArrayEvaluator.{JsonArrayEvaluator};

    use Interop/Json.JsonArray;
    use Interop/Json.JsonArray.{JsonArray};
    use Interop/Json.JsonObjectEvaluator;
    use Interop/Json.JsonNumber;
    use Interop/Json.JsonNumber.{JsonNumber};
    use Interop/Json.JsonObject;
    use Interop/Json.JsonObject.{JsonObject};

    pub def runJsonArrayEvaluator(r: Region[r], 
                                ma: JsonArrayEvaluator[r, a, a], 
                                arr: JsonArray): Result[a, String] & r =
        let JsonArray(arr1) = arr;
        MonadLib/Evaluator.runEvaluator(r, getJsonArrayEvaluator(ma), arr1)


    pub def point(x: a): JsonArrayEvaluator[r, ka, a] = JsonArrayEvaluator(MonadLib/Evaluator.point(x))

            
    pub def map(f: a -> b & ef, ma: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, b] & ef = 
        JsonArrayEvaluator(MonadLib/Evaluator.map(f, getJsonArrayEvaluator(ma)))

    pub def ap(mf: JsonArrayEvaluator[r, ka, a -> b & ef], ma: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, b] & ef =
        JsonArrayEvaluator(MonadLib/Evaluator.ap(getJsonArrayEvaluator(mf), getJsonArrayEvaluator(ma)))

    pub def flatMap(f: a -> JsonArrayEvaluator[r, ka, b] & ef, ma: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, b] & ef =
        JsonArrayEvaluator(MonadLib/Evaluator.flatMap(f >> getJsonArrayEvaluator, getJsonArrayEvaluator(ma)))


    pub def getJsonArrayEvaluator(x: JsonArrayEvaluator[r, ka, a]): MonadLib.Evaluator[r, ka, ##javax.json.JsonArray, a] = 
        let JsonArrayEvaluator(x1) = x;
        x1

    pub def throwError(msg: String): JsonArrayEvaluator[r, ka, a] = 
        JsonArrayEvaluator(MonadLib/Evaluator.throwError(msg))
    
    pub def empty(): JsonArrayEvaluator[r, ka, a] = JsonArrayEvaluator(MonadLib/Evaluator.empty())
        
    pub def orelse(ma: JsonArrayEvaluator[r, ka, a], mb: JsonArrayEvaluator[r, ka, a]): JsonArrayEvaluator[r, ka, a] =
        JsonArrayEvaluator(MonadLib/Evaluator.orelse(getJsonArrayEvaluator(ma), getJsonArrayEvaluator(mb)))

    def liftGetter(f: ##javax.json.JsonArray -> a & ef): JsonArrayEvaluator[r, ka, a] & ef =
        JsonArrayEvaluator(MonadLib/Evaluator.liftGetter(f))

    def liftActionResult(f: Unit -> Result[a, String] & ef): JsonArrayEvaluator[r, ka, a] & ef =          
        JsonArrayEvaluator(MonadLib/Evaluator.liftActionResult(f))

    pub def getBool(ix: Int32): JsonArrayEvaluator[r, ka, Bool] =
        import javax.json.JsonArray.getBoolean(Int32): Bool & Pure;
        liftGetter(x1 -> getBoolean(x1, ix))

    pub def getBoolWithDefault(ix: Int32, defaultVal: Bool): JsonArrayEvaluator[r, ka, Bool] =
        import javax.json.JsonArray.getBoolean(Int32, Bool): Bool & Pure;
        liftGetter(x1 -> getBoolean(x1, ix, defaultVal))

    pub def getInt32(ix: Int32): JsonArrayEvaluator[r, ka, Int32] =
        import javax.json.JsonArray.getInt(Int32): Int32 & Pure;
        liftGetter(x1 -> getInt(x1, ix))
    
    pub def getInt32WithDefault(ix: Int32, defaultVal: Int32): JsonArrayEvaluator[r, ka, Int32] =
        import javax.json.JsonArray.getInt(Int32, Int32): Int32 & Pure;
        liftGetter(x1 -> getInt(x1, ix, defaultVal))

    pub def getJsonArray(ix: Int32): JsonArrayEvaluator[r, ka, JsonArray] =
        import javax.json.JsonArray.getJsonArray(Int32): ##javax.json.JsonArray & Pure;
        liftGetter(x1 -> getJsonArray(x1, ix)) |> map(JsonArray)

    pub def getJsonNumber(ix: Int32): JsonArrayEvaluator[r, ka, JsonNumber] =
        import javax.json.JsonArray.getJsonNumber(Int32): ##javax.json.JsonNumber & Pure;
        liftGetter(x1 -> getJsonNumber(x1, ix)) |> map(JsonNumber)

    pub def getJsonObject(ix: Int32): JsonArrayEvaluator[r, ka, JsonObject] =
        import javax.json.JsonArray.getJsonObject(Int32): ##javax.json.JsonObject & Pure;
        liftGetter(x1 -> getJsonObject(x1, ix)) |> map(JsonObject)        

    pub def getString(ix: Int32): JsonArrayEvaluator[r, ka, String] =
        import javax.json.JsonArray.getString(Int32): String & Pure;
        liftGetter(x1 -> getString(x1, ix))
    
    pub def getStringWithDefault(ix: Int32, defaultVal: String): JsonArrayEvaluator[r, ka, String] =
        import javax.json.JsonArray.getString(Int32, String): String & Pure;
        liftGetter(x1 -> getString(x1, ix, defaultVal))

    pub def isNull(ix: Int32): JsonArrayEvaluator[r, ka, Bool] =
        import javax.json.JsonArray.isNull(Int32): Bool & Pure;
        liftGetter(x1 -> isNull(x1, ix))


    pub def evalJsonObject(ix: Int32, ma: JsonObjectEvaluator[r, a, a]): JsonArrayEvaluator[r, ka, a] & r =
        let* obj = getJsonObject(ix);
        liftActionResult(_ -> Interop/Json/JsonObjectEvaluator.runJsonObjectEvaluator(() as Region[r], ma, obj))
        
    pub def evalJsonArray(ix: Int32, ma: JsonArrayEvaluator[r, a, a]): JsonArrayEvaluator[r, ka, a] & r =
        let* obj = getJsonArray(ix);
        liftActionResult(_ -> runJsonArrayEvaluator(() as Region[r], ma, obj))

    pub def size(): JsonArrayEvaluator[r, ka, Int32] =
        import java.util.Collection.size(): Int32 & Pure;
        liftGetter(x1 -> size(x1 as ##java.util.Collection))

    pub def isEmpty(): JsonArrayEvaluator[r, ka, Bool] =
        import java.util.Collection.isEmpty(): Bool & Pure;
        liftGetter(x1 -> isEmpty(x1 as ##java.util.Collection))


}

