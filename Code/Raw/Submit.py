src = "Data/Raw/res.csv" 
dest = "Data/Raw/res_mod.csv" 

def func(src):
	missingRows = "\n"
	lines = ""
	with open(src) as f:
		lines = f.readlines()
		for i in range(1, len(lines)-1):
			x = float(lines[i].split(",")[0])
			# print("x: " + str(x))
			y = float(lines[i+1].split(",")[0])
			# print("y: " + str(y))
			diff = int(y - x)
			if diff == 1:
				continue # no missing rows
			else:
				for i in range(1, diff):
					missingRows += '{:g}'.format(float(x+i)) + ",0.0\n"
	# print(missingRows)

	lines[0] = "Id,Expected\n"
	destFile = open(dest,'w')
	data = ''.join(lines) + missingRows +"717625,0.0\n"
	destFile.write(data)
	destFile.close()


if __name__ == "__main__":
	func(src)
	