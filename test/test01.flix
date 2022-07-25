

namespace Test01 {

    @test
    def test01(): Bool & Impure = 
        JsonProcessing/JsonValue.jsonTrue() |> println;
        true


    @test
    def test02(): Bool & Impure = 
        use Applicative.{*>};
        use JsonProcessing/JsonObjectBuilder.{addString, addBigInt, addInt32, addFloat64};
        region r {
            let proc = () -> addInt32("number", 12) *> addString("hello", "world") *> addBigInt("big", 1000ii) *> addFloat64("decimal", 1.0763f64);
            JsonProcessing/JsonObjectBuilder.createObject(r, proc()) |> println;
            true
        }
    @test
    def test03(): Bool & Impure = 
        use Applicative.{*>};
        use JsonProcessing/JsonObjectBuilder.{addString, addBigInt, addInt32, addFloat64, addJsonObjectBuilder};
        region r {
            let proc = () -> addInt32("number", 12) *> addString("hello", "world") *> addBigInt("big", 1000ii) *> addJsonObjectBuilder("object", addFloat64("decimal", 1.0763f64));
            JsonProcessing/JsonObjectBuilder.createObject(r, proc()) |> println;
            true
        }
}