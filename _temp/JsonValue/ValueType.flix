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


namespace Interop/Json/JsonValue {
    
    use Interop/Lang.Enum;
    use Interop/Lang.Enum.{Enum};

    pub enum ValueType(##javax.json.JsonValue$ValueType)

    instance Interop/Flix.Marshal[ValueType] {
        pub def toJavaObject(x: ValueType): ##java.lang.Object =
            let ValueType(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): ValueType = 
            ValueType(unsafe_cast o as ##javax.json.JsonValue$ValueType)
    }

    instance Interop/Lang.SubEnum[ValueType] {
        pub def toEnum(x: ValueType): Enum[a] = 
            let ValueType(x1) = x;
            Enum(unsafe_cast x1 as ##java.lang.Enum)

        pub def fromEnum(x: Enum[a]): ValueType = 
            let Enum(x1) = x;
            ValueType(unsafe_cast x1 as ##javax.json.JsonValue$ValueType) 
    }

}

namespace Interop/Json/JsonValue/ValueType {

    use Interop/Json/JsonValue.ValueType;
    use Interop/Json/JsonValue.ValueType.{ValueType};

    pub def getHH(t: ValueType): ##javax.json.JsonValue$ValueType = 
        let ValueType(t1) = t;
        t1


    pub def array(): ValueType = 
        import static get javax.json.JsonValue$ValueType.ARRAY: ##javax.json.JsonValue$ValueType \ {} as get_ARRAY;
        get_ARRAY() |> ValueType


    pub def falsez(): ValueType = 
        import static get javax.json.JsonValue$ValueType.FALSE: ##javax.json.JsonValue$ValueType \ {} as get_FALSE;
        get_FALSE() |> ValueType


    pub def nullz(): ValueType = 
        import static get javax.json.JsonValue$ValueType.NULL: ##javax.json.JsonValue$ValueType \ {} as get_NULL;
        get_NULL() |> ValueType        


    pub def number(): ValueType = 
        import static get javax.json.JsonValue$ValueType.NUMBER: ##javax.json.JsonValue$ValueType \ {} as get_NUMBER;
        get_NUMBER() |> ValueType  

    pub def objectz(): ValueType = 
        import static get javax.json.JsonValue$ValueType.OBJECT: ##javax.json.JsonValue$ValueType \ {} as get_OBJECT;
        get_OBJECT() |> ValueType  


    pub def stringz(): ValueType = 
        import static get javax.json.JsonValue$ValueType.STRING: ##javax.json.JsonValue$ValueType \ {} as get_STRING;
        get_STRING() |> ValueType  


    pub def truez(): ValueType = 
        import static get javax.json.JsonValue$ValueType.TRUE: ##javax.json.JsonValue$ValueType \ {} as get_TRUE;
        get_TRUE() |> ValueType 

}
