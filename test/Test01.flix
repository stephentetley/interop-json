

pub mod Test01 {

    use Assert.{assertEq}

    @Test
    def getString01(): Unit \ { Assert } = 
        assertEq(
            expected = Some("hello world"),
            { let json = InteropJson.JsonValue.jsonString("hello world"); 
            InteropJson.JsonValue.getString(json) }
        )

    @Test
    def getString02(): Unit \ { Assert } = 
        assertEq(
            expected = None,
            { let json = InteropJson.JsonValue.jsonNumberFromInt32(5000); 
            InteropJson.JsonValue.getString(json) }
        )


    @Test
    def test01(): Unit \ { Assert, IO } = 
        assertEq(
            expected = true, 
            { InteropJson.JsonValue.jsonTrue() |> println; true }
        )

    @Test
    def test02(): Unit \ { Assert, IO } = 
        use InteropJson.JsonObjectBuilder.BuildJsonObject;
        region rc {
            let obj = run {
                BuildJsonObject.addInt32(name = "number", 12);
                BuildJsonObject.addString(name = "hello", "world");
                BuildJsonObject.addBigInt(name = "big", 1000ii);
                BuildJsonObject.addFloat64(name = "decimal", 1.0763f64);
                true
            } with InteropJson.JsonObjectBuilder.evalBuildJsonObject(rc);
            println(obj);
            assertEq(expected = true, true)
        }

    @Test
    def test03(): Unit \ { Assert, IO } = 
        use InteropJson.JsonObjectBuilder.BuildJsonObject;
        region rc {
            let obj = run {
                BuildJsonObject.addString(name = "title", "hello world");
                BuildJsonObject.addNestedJsonValue(name = "nesting", run {
                    BuildJsonObject.addString(name = "location", "uk");
                    BuildJsonObject.addInt32(name = "year", 2026);
                    ()
                } with InteropJson.JsonObjectBuilder.evalBuildJsonObjectValue(rc));
                true
            } with InteropJson.JsonObjectBuilder.evalBuildJsonObject(rc);
            println(obj);
            assertEq(expected = true, true)
        }


    // @Test
    // def test04(): Bool & Impure = 
    //     match Interop/Json/JsonValue.readValue("{ \"number\": 1000, \"string\": \"some_text\" } ") {
    //         case Ok(json) => {println("Read: ${json}"); true}
    //         case Err(msg) => {println(msg); false}
    //     }


}
