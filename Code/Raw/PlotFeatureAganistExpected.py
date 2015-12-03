#!/usr/bin/python

src = "Data/Raw/trainCleaned.csv"

import csv


def getstuff(filename, criterion):
    with open(filename, "rb") as csvfile:
        datareader = csv.reader(csvfile)
        count = 0
        for row in datareader:
            if row[3] in ("column header", criterion):
                yield row
                count += 1
            elif count < 2:
                continue
            else:
                return


if __name__ == "__main__":
	x = getNumberOfCompleteFeaturesRows(src)
	print(x)