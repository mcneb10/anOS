# gcc intel syntax asm to nasm syntax asm\
import sys
import os
lines = []
if len(sys.argv)<2:
    print("Please provide an input file")
elif len(sys.argv)<3:
    print("Please provide an output file")
else:
    if not os.path.exists(sys.argv[1]):
        print("Input file "+sys.argv[1]+" does not exist")
    else:
        with open(sys.argv[1]) as gccasmfile:
            for line in gccasmfile:
                line = line.lstrip()
                line=line.replace("#",";")
                #do special handling for strings
                if line.startswith(".ascii"):
                    if line.__contains__("\\0"):
                        lines.append("db \'"+line.split(".ascii \"")[1][:-2].replace("\\0","")+"\',0\n")
                        continue
                    lines.append("db \'"+line.split(".ascii \"")[1][:-2]+"\'\n")
                if line.startswith(".asciz"):
                    lines.append("db \'"+line.split(line[0:8])[1][:-2]+"\',0\n")
                if line.startswith(".space"):
                    temp = "db "
                    for x in range(int(line[7:])):
                        temp+="0,"
                    temp = temp[:-1]
                    temp+="\n"
                    lines.append(temp)
                if line.startswith(".globl"):
                    lines.append("global "+line[7:])
                if line.startswith(".long"):# or line.startswith(".int"):
                    lines.append("dd "+line.split(".long\t")[1])
                if line.startswith(".byte"):# or line.startswith(".int"):
                    lines.append("db "+line.split(".byte\t")[1])
                if line.startswith(".zerofill"):
                    lines.append(line.split(",")[2]+":\n")
                    temp = "db "
                    for x in range(int(line.split(",")[3])):
                        temp+="0,"
                    temp = temp[:-1]
                    lines.append(temp+"\n")
                #ignore other directives
                if line.startswith("."):
                    continue
                if line.startswith("/"):
                    line = ";"+line
                #make "l" lables local
                if (line.startswith("L") or line.startswith("LB")) and line.__contains__(":") and not(line.startswith("LC")) and not(line.__contains__("L_.str")) and not(line.__contains__("$")) and not(line.__contains__("const")):
                    line = "."+line
                if(line.__contains__("L")):
                    if (line.startswith("j")) and line[3] == "L":
                        line = line[:2]+" ."+line[3:]
                        
                    elif (line.startswith("j")) and line[4] == "L":
                        line = line[:3]+" ."+line[4:]
                    elif (line.startswith("j")) and line[5] == "L":
                        line = line[:4]+" ."+line[5:]
                    elif (line.startswith("j")) and line[6] == "L":
                        line = line[:5]+" ."+line[6:]
                
                #PTR is not needed with NASM
                line = line.replace("PTR ","")
                line = line.replace("ptr ","")
                line = line.replace("OFFSET FLAT:","")
                #handle movzx thing with pointer
                if line.__contains__("movzx") and line.__contains__("BYTE") and not line.__contains__("["):
                    lines.append("push ax\n")
                    lines.append("mov al,"+line.split(",")[1])
                    lines.append(line.split(",")[0]+", ax\n")
                    lines.append("pop ax\n")
                    continue
                #add brackets for some mov instructions
                if line.split(",")[0].__contains__("mov\t") and line.split(",")[0].__contains__("BYTE") and line.split(",")[0].__contains__("_"):
                    line=line[:line.find("_")-1]+" ["+line[line.find("_"):]
                    line=line[:line.find(",")]+"]"+line[line.find(","):]
                #i will add more as time goes on
                lines.append(line)
        #assembly file has been made compatible with nasm
        f = open(sys.argv[2],"w")
        f.writelines(lines)
        f.close()