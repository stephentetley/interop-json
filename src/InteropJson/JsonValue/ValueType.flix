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


pub mod InteropJson.JsonValue.ValueType {
    use InteropJson.JsonValue.ValueType.ValueType.{ARRAY, FALSE,
        NULL, NUMBER, OBJECT, STRING, TRUE}

    import jakarta.json.{JsonValue$ValueType => JValueType}


    pub enum ValueType with Eq, Order, ToString, Hash {
        case ARRAY
        case FALSE
        case NULL
        case NUMBER
        case OBJECT
        case STRING
        case TRUE
    }

    pub def marshalValueType(x: ValueType): JValueType =
        match x {
            case ARRAY      => unsafe IO { JValueType.ARRAY }
            case FALSE      => unsafe IO { JValueType.FALSE }
            case NULL       => unsafe IO { JValueType.NULL }
            case NUMBER     => unsafe IO { JValueType.NUMBER }
            case OBJECT     => unsafe IO { JValueType.OBJECT }
            case STRING     => unsafe IO { JValueType.STRING }
            case TRUE       => unsafe IO { JValueType.TRUE }
        }

    def primEquals(x: JValueType, y: JValueType): Bool =
        unsafe IO { x.equals(y) }


    pub def unmarshalValueType(x: JValueType): ValueType =
        match x {
            case x1 if primEquals(x1, unsafe IO { JValueType.ARRAY })   => ARRAY
            case x1 if primEquals(x1, unsafe IO { JValueType.FALSE })   => FALSE
            case x1 if primEquals(x1, unsafe IO { JValueType.NULL })    => NULL
            case x1 if primEquals(x1, unsafe IO { JValueType.NUMBER })  => NUMBER
            case x1 if primEquals(x1, unsafe IO { JValueType.OBJECT })  => OBJECT
            case x1 if primEquals(x1, unsafe IO { JValueType.STRING })  => STRING
            case x1 if primEquals(x1, unsafe IO { JValueType.TRUE })    => TRUE
            case _      => bug!("unmarshalValueType")
        }


}
