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


pub mod InteropJson.JsonStructure {

    use InteropJson.JsonValue.JsonValue

    import jakarta.json.{JsonStructure => JJsonStructure}
    
    ///
    /// Represents a JsonStructure.
    /// Interface
    ///
    pub enum JsonStructure(JJsonStructure)


    pub trait JsonStructureInterop[t: Type] {
        pub def toJsonStructure(x: t): JsonStructure
        pub def fromJsonStructure(x: JsonStructure): t
    }

    // instance JsonStructureInterop[JsonStructure] {
    //     pub def toJsonValue(x: JsonStructure): JsonValue = 
    //         let JsonStructure(x1) = x;
    //         JsonValue(unsafe_cast x1 as ##javax.json.JsonValue)

    //     pub def fromJsonValue(x: JsonValue): JsonStructure = 
    //         let JsonValue(x1) = x;
    //         JsonStructure(unsafe_cast x1 as ##javax.json.JsonStructure)
    // }




    pub def getValue(pointer: String, js: JsonStructure): Result[String, JsonValue] = 
        Result.tryCatch(_ -> {
            let JsonStructure.JsonStructure(js1) = js;
            JsonValue.JsonValue(unsafe IO { js1.getValue(pointer) })
        })

}
