

pub mod TestValueView {

    use Assert.{assertEq}

    use InteropJson.JsonValue.ValueView.{JsonValueView}
    use InteropJson.JsonValue.ValueView.{viewJsonValue}


    @Test
    def viewJsonValue01(): Unit \ { Assert } = 
        let json = InteropJson.JsonValue.jsonString("hello world"); 
        let ans = match viewJsonValue(json) {
            case JsonValueView.JsString(s) => Some(s)
            case _ => None
        };
        assertEq(expected = Some("hello world"), ans)

    @Test
    def viewJsonValue02(): Unit \ { Assert } = 
        let json = InteropJson.JsonValue.jsonTrue(); 
        let ans = match viewJsonValue(json) {
            case JsonValueView.JsTrue => Some(true)
            case JsonValueView.JsFalse => Some(false)
            case _ => None
        };
        assertEq(expected = Some(true), ans)

    @Test
    def viewJsonValue03(): Unit \ { Assert } = 
        let json = InteropJson.JsonArray.fromList(List#{"hello", "world"}) 
                    |> InteropJson.JsonArray.toJsonValue; 
        let ans = match viewJsonValue(json) {
            case JsonValueView.JsTrue => None
            case JsonValueView.JsFalse => None
            case JsonValueView.JsArray(arr) => InteropJson.JsonArray.getString(index = 0, arr)
            case _ => None
        };
        assertEq(expected = Some("hello"), ans)

    @Test
    def viewJsonValue04(): Unit \ { Assert } = 
        let json = InteropJson.JsonObject.fromList(List#{("l1", "hello"), ("l2", "world")}) 
                    |> InteropJson.JsonObject.toJsonValue; 
        let ans = match viewJsonValue(json) {
            case JsonValueView.JsTrue => None
            case JsonValueView.JsFalse => None
            case JsonValueView.JsArray(arr) => InteropJson.JsonArray.getString(index = 0, arr)
            case JsonValueView.JsObject(obj) => InteropJson.JsonObject.getString(name = "l2", obj)
            case _ => None
        };
        assertEq(expected = Some("world"), ans)


}
