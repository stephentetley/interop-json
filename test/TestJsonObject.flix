

pub mod TestJsonObject {

    use Assert.{assertEq}

    @Test
    def fromMap01(): Unit \ { Assert } =
        let x: Map[String, Int32] = Map#{};
        let json = InteropJson.JsonObject.fromMap(x);
        assertEq(
            expected = 0,
            InteropJson.JsonObject.size(json)
        )

    @Test
    def fromMap02(): Unit \ { Assert } =
        let json = InteropJson.JsonObject.fromMap(
                        Map#{"a" => 1, "b" => 3, "c" => 6, "d" => 7} );
        assertEq(
            expected = 4,
            InteropJson.JsonObject.size(json)
        )


}

