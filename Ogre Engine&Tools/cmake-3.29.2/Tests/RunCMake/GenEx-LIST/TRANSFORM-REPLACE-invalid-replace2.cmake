
file(GENERATE OUTPUT result.txt CONTENT "$<LIST:TRANSFORM,a;b,REPLACE,^a,\\b>")
