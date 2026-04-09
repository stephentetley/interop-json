

pub mod TestJsonArray {

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

}

