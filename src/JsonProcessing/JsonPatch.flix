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

    pub enum JsonPatch(##javax.json.JsonPatch)


}

namespace JsonProcessing/JsonPatch {

    use JsonProcessing.JsonPatch;
    use JsonProcessing.JsonPatch.{JsonPatch};

    use JsonProcessing.JsonArray;
    use JsonProcessing.JsonArray.{JsonArray};
    use JsonProcessing.JsonObject;
    use JsonProcessing.JsonObject.{JsonObject};

    pub enum Operation with Eq, Order, ToString, Hash, Boxable {
        case Add
        case Copy
        case Move
        case Remove
        case Replace
        case Test
    }


    pub def marshal(x: Operation): ##javax.json.JsonPatch$Operation =
        import static get javax.json.JsonPatch$Operation.ADD: ##javax.json.JsonPatch$Operation & Pure as get_ADD;
        import static get javax.json.JsonPatch$Operation.COPY: ##javax.json.JsonPatch$Operation & Pure as get_COPY;
        import static get javax.json.JsonPatch$Operation.MOVE: ##javax.json.JsonPatch$Operation & Pure as get_MOVE;
        import static get javax.json.JsonPatch$Operation.REMOVE: ##javax.json.JsonPatch$Operation & Pure as get_REMOVE;
        import static get javax.json.JsonPatch$Operation.REPLACE: ##javax.json.JsonPatch$Operation & Pure as get_REPLACE;
        import static get javax.json.JsonPatch$Operation.TEST: ##javax.json.JsonPatch$Operation& Pure as get_TEST;
        match x {
            case Add        => get_ADD()
            case Copy       => get_COPY()
            case Move       => get_MOVE()
            case Remove     => get_REMOVE()
            case Replace    => get_REPLACE()
            case Test       => get_TEST()
        }

    def primEquals(x: ##javax.json.JsonPatch$Operation, y: ##javax.json.JsonPatch$Operation): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        let x1 = x as ##java.lang.Enum;
        let y1 = y as ##java.lang.Object;
        equals(x1, y1)


    pub def unmarshal(x: ##javax.json.JsonPatch$Operation): Operation = 
        import static get javax.json.JsonPatch$Operation.ADD: ##javax.json.JsonPatch$Operation & Pure as get_ADD;
        import static get javax.json.JsonPatch$Operation.COPY: ##javax.json.JsonPatch$Operation & Pure as get_COPY;
        import static get javax.json.JsonPatch$Operation.MOVE: ##javax.json.JsonPatch$Operation & Pure as get_MOVE;
        import static get javax.json.JsonPatch$Operation.REMOVE: ##javax.json.JsonPatch$Operation & Pure as get_REMOVE;
        import static get javax.json.JsonPatch$Operation.REPLACE: ##javax.json.JsonPatch$Operation & Pure as get_REPLACE;
        import static get javax.json.JsonPatch$Operation.TEST: ##javax.json.JsonPatch$Operation& Pure as get_TEST;
        match x {
            case x1 if primEquals(x1, get_ADD())        => Add
            case x1 if primEquals(x1, get_COPY())       => Copy
            case x1 if primEquals(x1, get_MOVE())       => Move
            case x1 if primEquals(x1, get_REMOVE())     => Remove
            case x1 if primEquals(x1, get_REPLACE())    => Replace
            case x1 if primEquals(x1, get_TEST())       => Test
        }

    pub def toJsonArray(x: JsonPatch): JsonArray =
        import javax.json.JsonPatch.toJsonArray(): ##javax.json.JsonArray & Pure;
        let JsonPatch(x1) = x;
        JsonArray(toJsonArray(x1))

    pub def applyToJsonObject(x: JsonPatch, o: JsonObject): Result[JsonObject, String] =
        import javax.json.JsonPatch.apply(##javax.json.JsonStructure): ##javax.json.JsonStructure & Pure;
        try {
            let JsonPatch(x1) = x;
            let JsonObject(o1) = o;
            let ans = apply(x1, o1 as ##javax.json.JsonStructure);
            JsonObject(ans as ##javax.json.JsonObject) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

    pub def applyToJsonArray(x: JsonPatch, arr: JsonArray): Result[JsonArray, String] =
        import javax.json.JsonPatch.apply(##javax.json.JsonStructure): ##javax.json.JsonStructure & Pure;
        try {
            let JsonPatch(x1) = x;
            let JsonArray(arr1) = arr;
            let ans = apply(x1, arr1 as ##javax.json.JsonStructure);
            JsonArray(ans as ##javax.json.JsonArray) |> Ok
        } catch {
            case ex: ##java.lang.Exception => {
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex as ##java.lang.Throwable))
            }
        }

}
