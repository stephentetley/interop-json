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


namespace Interop/Json/JsonPatch {

    pub enum Operation(##javax.json.JsonPatch$Operation)

    instance Interop/Flix.Marshal[Operation] {
        pub def toJavaObject(x: Operation): ##java.lang.Object =
            let Operation(x1) = x;
            x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): Operation = 
            Operation(o as ##javax.json.JsonPatch$Operation)
    }

}

namespace Interop/Json/JsonPatch/Operation {

    use Interop/Json/JsonPatch.Operation;
    use Interop/Json/JsonPatch.Operation.{Operation};

    pub def getHH(o: Operation): ##javax.json.JsonPatch$Operation = 
        let Operation(o1) = o;
        o1


    pub def add(): Operation = 
        import static get javax.json.JsonPatch$Operation.ADD: ##javax.json.JsonPatch$Operation \ {} as get_ADD;
        get_ADD() |> Operation

    pub def copy(): Operation = 
        import static get javax.json.JsonPatch$Operation.COPY: ##javax.json.JsonPatch$Operation \ {} as get_COPY;
        get_COPY() |> Operation

    pub def move(): Operation = 
        import static get javax.json.JsonPatch$Operation.MOVE: ##javax.json.JsonPatch$Operation \ {} as get_MOVE;
        get_MOVE() |> Operation

    pub def remove(): Operation = 
        import static get javax.json.JsonPatch$Operation.REMOVE: ##javax.json.JsonPatch$Operation \ {} as get_REMOVE;
        get_REMOVE() |> Operation

    pub def replace(): Operation = 
        import static get javax.json.JsonPatch$Operation.REPLACE: ##javax.json.JsonPatch$Operation \ {} as get_REPLACE;
        get_REPLACE() |> Operation

    pub def test(): Operation = 
        import static get javax.json.JsonPatch$Operation.TEST: ##javax.json.JsonPatch$Operation\ {} as get_TEST;
        get_TEST() |> Operation

    pub def operationName(x: Operation): String =
        import javax.json.JsonPatch$Operation.operationName(): String \ {};
        let Operation(x1) = x;
        operationName(x1)

}
