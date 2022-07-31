# interop-json

A Flix wrapper over parts of the javax.json API.

To run the tests or programs depending on this library you are likely to 
have to use the classpath option to tell java where to find to the javax.json 
implementation.

In the command below we point to `lib` which is expected to contain the 
necessary Apache Geronimo and Johnzon jars:

> java -cp "./lib/*;../bin/flix.jar" ca.uwaterloo.flix.Main test
