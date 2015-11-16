#!/usr/bin/python
import os

for  i in range(19, 25):
	f = open("Code/Raw/t.r",'r')
	filedata = f.read()
	f.close()

	newdata = filedata.replace( str(i-1) + ")", str(i) + ")")

	f = open("Code/Raw/t.r",'w')
	f.write(newdata)
	f.close()

	os.system("Rscript Code/Raw/t.r")




