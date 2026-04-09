

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
    @Test
    def forEach01(): Unit \ { Assert, IO } =
        let xm: Map[String, Int32] = Map#{};
        let json = InteropJson.JsonObject.fromMap(xm);
        InteropJson.JsonObject.forEach((k, v) -> println("${k}:=${v}"), json);
        assertEq(
            expected = true,
            true
        )

    @Test
    def forEach02(): Unit \ { Assert, IO } =
        let xm: Map[String, Int32] = Map#{"a" => 1, "b" => 2, "c" => 3};
        let json = InteropJson.JsonObject.fromMap(xm);
        InteropJson.JsonObject.forEach((k, v) -> println("${k}:=${v}"), json);
        assertEq(
            expected = true,
            true
        )

    @Test
    def map01(): Unit \ { Assert } =
        let xm: Map[String, Int32] = Map#{};
        let json = InteropJson.JsonObject.fromMap(xm);
        let ans = InteropJson.JsonObject.map(InteropJson.JsonValue.mapInt32(_ -> 10), json);
        assertEq(
            expected = { let ym: Map[String, Int32] = Map#{}; InteropJson.JsonObject.fromMap(ym) },
            ans
        )

    @Test
    def map02(): Unit \ { Assert } =
        let xm: Map[String, Int32] = Map#{"a" => 1, "b" => 2, "c" => 3};
        let json = InteropJson.JsonObject.fromMap(xm);
        let ans = InteropJson.JsonObject.map(InteropJson.JsonValue.mapInt32(_ -> 10), json);
        assertEq(
            expected = { let ym: Map[String, Int32] = Map#{"a" => 10, "b" => 10, "c" => 10}; InteropJson.JsonObject.fromMap(ym) },
            ans
        )

}

