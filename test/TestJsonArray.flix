

pub mod TestJsonArray {
    import jakarta.json.JsonArray

    use Assert.{assertEq}

    @Test
    def fromList01(): Unit \ { Assert } =
        let xs: List[Int32] = Nil;
        let json = InteropJson.JsonArray.fromList(xs);
        assertEq(
            expected = 0,
            InteropJson.JsonArray.size(json)
        )

    @Test
    def fromList02(): Unit \ { Assert } =
        let json = InteropJson.JsonArray.fromList(List#{1,3,6,7});
        assertEq(
            expected = 4,
            InteropJson.JsonArray.size(json)
        )


    @Test
    def map01(): Unit \ { Assert } =
        let xs: List[Int32] = List#{};
        let json = InteropJson.JsonArray.fromList(xs);
        let ten = InteropJson.JsonNumber.fromInt32(10);
        let ans = InteropJson.JsonArray.map(InteropJson.JsonValue.mapJsonNumber(_ -> ten), json);
        assertEq(
            expected = { let ys: List[Int32] = Nil; InteropJson.JsonArray.fromList(ys) },
            ans
        )

    @Test
    def map02(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ten = InteropJson.JsonNumber.fromInt32(10);
        let ans = InteropJson.JsonArray.map(InteropJson.JsonValue.mapJsonNumber(_ -> ten), json);
        assertEq(
            expected = { let ys: List[Int32] = List#{10, 10, 10}; InteropJson.JsonArray.fromList(ys) },
            ans
        )

    @Test
    def filter01(): Unit \ { Assert } =
        let xs: List[Int32] = List#{};
        let json = InteropJson.JsonArray.fromList(xs);
        let three = InteropJson.JsonNumber.fromInt32(3);
        let ans = InteropJson.JsonArray.filter(InteropJson.JsonValue.existsJsonNumber(x -> x < three), json);
        assertEq(
            expected = { let ys: List[Int32] = Nil; InteropJson.JsonArray.fromList(ys) },
            ans
        )

    @Test
    def filter02(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let three = InteropJson.JsonNumber.fromInt32(3);
        let ans = InteropJson.JsonArray.filter(InteropJson.JsonValue.existsJsonNumber(x -> x < three), json);
        assertEq(
            expected = { let ys: List[Int32] = List#{1, 2}; InteropJson.JsonArray.fromList(ys) },
            ans
        )


    @Test
    def foldLeft01(): Unit \ { Assert } =
        let xs: List[Int32] = List#{};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.foldLeft((ac, x) -> "${ac}${x}", "", json);
        assertEq(
            expected = "",
            ans
        )

    @Test
    def foldLeft02(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.foldLeft((ac, x) -> "${ac}${x}", "", json);
        assertEq(
            expected = "123",
            ans
        )

    @Test
    def foldRight01(): Unit \ { Assert } =
        let xs: List[Int32] = List#{};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.foldRight((x, ac) -> "${ac}${x}", "", json);
        assertEq(
            expected = "",
            ans
        )

    @Test
    def foldRight02(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.foldRight((x, ac) -> "${ac}${x}", "", json);
        assertEq(
            expected = "321",
            ans
        )


    @Test
    def exists01(): Unit \ { Assert } =
        let xs: List[Int32] = List#{};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.exists(x -> InteropJson.JsonValue.getInt32(x) == Some(3), json);
        assertEq(
            expected = false,
            ans
        )

    @Test
    def exists02(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.exists(x -> InteropJson.JsonValue.getInt32(x) == Some(3), json);
        assertEq(
            expected = true,
            ans
        )

    @Test
    def exists03(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.exists(x -> InteropJson.JsonValue.getInt32(x) == Some(10), json);
        assertEq(
            expected = false,
            ans
        )

    @Test
    def find01(): Unit \ { Assert } =
        let xs: List[Int32] = List#{};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.find(x -> InteropJson.JsonValue.getInt32(x) == Some(3), json);
        assertEq(
            expected = None,
            ans
        )

    @Test
    def find02(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.find(x -> InteropJson.JsonValue.getInt32(x) == Some(3), json);
        assertEq(
            expected = Some(InteropJson.JsonValue.jsonNumberFromInt32(3)),
            ans
        )

    @Test
    def find03(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.find(x -> InteropJson.JsonValue.getInt32(x) == Some(10), json);
        assertEq(
            expected = None,
            ans
        )

    @Test
    def findMap01(): Unit \ { Assert } =
        let xs: List[Int32] = List#{};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.findMap(InteropJson.JsonValue.getInt32 >> Option.filter(x -> x == 3), json);
        assertEq(
            expected = None,
            ans
        )

    @Test
    def findMap02(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.findMap(InteropJson.JsonValue.getInt32 >> Option.filter(x -> x == 3), json);
        assertEq(
            expected = Some(3),
            ans
        )

    @Test
    def findMap03(): Unit \ { Assert } =
        let xs: List[Int32] = List#{1,2,3};
        let json = InteropJson.JsonArray.fromList(xs);
        let ans = InteropJson.JsonArray.findMap(InteropJson.JsonValue.getInt32 >> Option.filter(x -> x == 10), json);
        assertEq(
            expected = None,
            ans
        )

}

