### v0.3.0
   Moved `JsonValue`, `JsonArray` and `JsonObject` types into the top-level module `InteropJson`.
   Renamed `ToJson` and `FromJson` traits - now `ToJsonValue` and 
   `FromJsonValue`.

### v0.2.0
   Added many functions to `JsonValue`.
   Added `ToJson` and `FromJson` traits.
   Renamed Builder traits - `JsonArrayBuilder` is now `BuildJsonArray`, 
   `JsonArrayObject` is now `BuildJsonObject`. 
   Added Reader effects - `ReadJsonArray` and `ReadJsonObject`.
   Removed `JsonString`, `JsonNumber` and `JsonStructure` modules.

### v0.1.0
   Initial release.
