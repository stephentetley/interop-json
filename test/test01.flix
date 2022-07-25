

namespace Test01 {

    @test
    def test01(): Bool & Impure = 
        JsonProcessing/JsonValue.jsonTrue() |> println;
        true


    @test
    def test02(): Bool & Impure = 
        use Applicative.{*>};
        use JsonProcessing/JsonObjectBuilder.{addString, addInt32};
        region r {
            JsonProcessing/JsonObjectBuilder.createObject(r, addInt32("number", 12) *> addString("hello", "world")) |> println;
            true
        }

}