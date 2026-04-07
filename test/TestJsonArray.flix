

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


}

