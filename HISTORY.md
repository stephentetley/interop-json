### v0.7.0 
   Added `foldLeft` etc. functions to `JsonArray`.

### v0.6.0
   Added `JsonArray` and `JsonObject` modules back. Added enough
   functions to them to be generally useful.
   Removed `ReadJsonArray` and `ReadJsonObject`.

### v0.5.0
   Renamed modules for building and read JsonObject and JsonArray 
   so the module names match the effect names.
   Pushed regions inside the `__Builder` and `__Reader` effects 
   so they aren't visible to clients.
   Added more utility functions to `JsonValue`.

### v0.4.0
   Added "get with default" functions to `JsonValue`.
   Added `ReadJson` and `WriteJson` effects.

### v0.3.0
   Moved `JsonValue`, `JsonArray` and `JsonObject` types into the 
   top-level module `InteropJson`.
   Renamed `ToJson` and `FromJson` traits - now `ToJsonValue` and 
   `FromJsonValue`.
   Simplfied `JsonArrayBuilder` and `JsonObjectBuilder` - builder 
   handles have been removed.

### v0.2.0
   Added many functions to `JsonValue`.
   Added `ToJson` and `FromJson` traits.
   Renamed Builder traits - `JsonArrayBuilder` is now `BuildJsonArray`, 
   `JsonArrayObject` is now `BuildJsonObject`. 
   Added Reader effects - `ReadJsonArray` and `ReadJsonObject`.
   Removed `JsonString`, `JsonNumber` and `JsonStructure` modules.

### v0.1.0
   Initial release.
