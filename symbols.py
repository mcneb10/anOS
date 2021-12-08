#example line
#0000006c g     F .text  0000004f strlen
f = open("symbols.txt","r")
lines = f.readlines()
reslines = []
f.close()
for line in lines:
    if line[0]=="0" and line[15] == "F" and not line.__contains__(".hidden"):
        print(line[32:])
        reslines.append(line[32:]+" equ "+"\n")