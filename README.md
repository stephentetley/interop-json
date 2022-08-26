# interop-json

A Flix wrapper over parts of the javax.json API.

To run the tests or programs depending on this library you are likely to 
have to use the classpath option to tell java where to find to the javax.json 
implementation (`interop-json` is developed with Apache Geronimo and Apache 
Johnzon - jars are included in the folder `lib` for convenience).

In the command below we point to `lib` which is expected to contain the 
necessary Apache Geronimo and Johnzon jars:

> java -cp "./lib/*;../bin/flix.jar" ca.uwaterloo.flix.Main test

License: Apache 2.0

## Dependencies

https://github.com/stephentetley/monad-lib

https://github.com/stephentetley/interop-base (pkg and jar)

A `javax.json` implementation e.g. Apache Geronimo  and Apache Johnzon
