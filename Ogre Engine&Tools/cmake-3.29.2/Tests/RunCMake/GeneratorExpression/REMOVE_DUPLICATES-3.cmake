cmake_policy(VERSION 3.11)

file(GENERATE OUTPUT "REMOVE_DUPLICATES-generated.txt" CONTENT "$<REMOVE_DUPLICATES:2$<SEMICOLON>1>")
