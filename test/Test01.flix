

pub mod Test01 {

    use Assert.{assertEq}

    @Test
    def test01(): Unit \ { Assert, IO } = 
        assertEq(
            expected = true, 
            { InteropJson.JsonValue.jsonTrue() |> println; true }
        )

    @Test
    def test02(): Unit \ { Assert, IO } = 
        use InteropJson.JsonObjectBuilder.JsonObjectBuilder;
        let obj = run {
            let _ = JsonObjectBuilder.addInt32(name = "number", 12);
            let _ = JsonObjectBuilder.addString(name = "hello", "world");
            let _ = JsonObjectBuilder.addBigInt(name = "big", 1000ii);
            let _ = JsonObjectBuilder.addFloat64(name = "decimal", 1.0763f64);
            true
        } with InteropJson.JsonObjectBuilder.evalJsonObjectBuilder;
        println(obj);
        assertEq(expected = true, true)

    // @Test
    // def test03(): Bool & Impure = 
    //     use Applicative.{*>};
    //     use Interop/Json/JsonObjectBuilder.{addString, addBigInt, addInt32, addFloat64, addJsonObjectBuilder};
    //     region r {
    //         let proc = () -> addInt32("number", 12) *> addString("hello", "world") *> addBigInt("big", 1000ii) *> addJsonObjectBuilder("object", addFloat64("decimal", 1.0763f64));
    //         Interop/Json/JsonObjectBuilder.createObject(r, proc()) |> println;
    //         true
    //     }

    // @Test
    // def test04(): Bool & Impure = 
    //     match Interop/Json/JsonValue.readValue("{ \"number\": 1000, \"string\": \"some_text\" } ") {
    //         case Ok(json) => {println("Read: ${json}"); true}
    //         case Err(msg) => {println(msg); false}
    //     }


}
