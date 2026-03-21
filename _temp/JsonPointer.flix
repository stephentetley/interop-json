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

    pub enum JsonPointer(##javax.json.JsonPointer)


}

namespace Interop/Json/JsonPointer {

    use Interop/Json.JsonPointer;
    use Interop/Json.JsonPointer.{JsonPointer};
    use Interop/Json.JsonValue;
    use Interop/Json.JsonValue.{JsonValue};
    use Interop/Json.ImpJsonStructure;


    pub def getHH(ptr: JsonPointer): ##javax.json.JsonPointer = 
        let JsonPointer(ptr1) = ptr;
        ptr1


    pub def containsValue(ptr: JsonPointer, js: t): Bool with ImpJsonStructure[t] = 
        import javax.json.JsonPointer.containsValue(##javax.json.JsonStructure): Bool \ {};
        let JsonPointer(ptr1) = ptr;
        Interop/Json/JsonStructure.toJsonStructureHH(js) 
            |> containsValue(ptr1)

    pub def getValue(ptr: JsonPointer, js: t): Result[JsonValue, String] with ImpJsonStructure[t] = 
        try {
            import javax.json.JsonPointer.getValue(##javax.json.JsonStructure): ##javax.json.JsonValue \ {};
            let JsonPointer(ptr1) = ptr;
            Interop/Json/JsonStructure.toJsonStructureHH(js) 
                |> getValue(ptr1)
                |> JsonValue
                |> Ok
         } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
         }


}
