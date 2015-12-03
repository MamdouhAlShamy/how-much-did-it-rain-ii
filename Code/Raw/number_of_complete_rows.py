#!/usr/bin/python

src = "Data/Raw/trainCleaned.csv"
dest = "Data/Raw/trainCleanedCompletely.csv" 

src = "Data/Raw/trainIgnoreNATuples.csv"

def getNumberOfCompleteFeaturesRows(src):
	numberOfCompleteFeaturesRows = 0
	with open(src) as f:
		for line in f:
			if "NA" in line:
				numberOfCompleteFeaturesRows += 1

	return numberOfCompleteFeaturesRows


def removeUncompleteFeaturesRows(src, dest):
	destFile = open(dest,'w')
	with open(src) as f:
		for line in f:
			if "NA" not in line:
				destFile.write(line)
	destFile.close()


if __name__ == "__main__":
	x = getNumberOfCompleteFeaturesRows(src)
	print(x)
